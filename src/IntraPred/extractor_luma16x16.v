`timescale 1ns/1ps

module extractor_luma16x16 #(
    parameter LENGTH = 256,
    parameter WIDTH = 256 )(
    input clk,
    input reset,
    input enable,
    input [12:0] mbnumber,
    output reg [7:0] mb [255:0],
    output reg [7:0] toppixels [15:0],
    output reg [7:0] leftpixels [15:0]);
    
    reg [7:0] image [LENGTH*WIDTH - 1 : 0];
    reg [7:0] mbintermediate [255:0];

    initial begin
		$readmemh("output.mem", image);
	end

    reg [15:0] row, col;
	reg [7:0] i,j,k;

    always @ (posedge clk) begin

		if (enable) begin

            mb <= mbintermediate;

            row <= (16'(mbnumber) >> 4) << 4;
            col <= ((16'(mbnumber) & 15) - 1) << 4;

            // Fetch mb
            for (j = 0; j < 16; j = j + 1) begin
                for (k = 0; k < 16; k = k +1) begin
                    mbintermediate[(j<<4) + k] = image[((row+16'(j))<<8) + (col+16'(k))];
                end
            end
            
            // Fetch toppixels
            for (j = 0; j < 16; j = j + 1) begin
                toppixels[4'(j)] = (row == 0 ? 128 : (image[((row-1)<<8) + (col+16'(j))])); // should not come from the image, should come from the pred_frame.
            end

            // Fetch leftpixels
            for (i = 0; i < 16; i = i +1) begin
                leftpixels[4'(i)] = ((col == 0) ? 128 : (image[((row+16'(i))<<8) + (col-1)])); // same.
            end
            
        end

	end

endmodule
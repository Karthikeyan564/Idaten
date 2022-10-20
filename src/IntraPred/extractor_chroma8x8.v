`timescale 1ns/1ps

module extractor_chroma8x8 #(
    parameter LENGTH = 256,
    parameter WIDTH = 256 )(
    input clk,
    input reset,
    input enable,
    input mbnumber,
    output reg [7:0] mb [63:0],
    output reg [7:0] toppixels [7:0],
    output reg [7:0] leftpixels [7:0]);
    
    reg [7:0] image [LENGTH*WIDTH - 1 : 0];
    reg [7:0] mbintermediate [63:0];

    initial begin
		$readmemh("output.mem", image);
	end

    integer row;
	integer col;
	integer i,j,k;

    always @ (posedge clk) begin

		if (enable) begin

            mb <= mbintermediate;

            row <= (mbnumber >> 5) << 3;
            col <= ((mbnumber & 31) - 1) << 3;

            // Fetch mb
            for (j = 0; j < 8; j = j + 1) begin
                for (k = 0; k < 8; k = k +1) begin
                    mbintermediate[(j<<3) + k] = image[((row+j)<<8) + (col+k)];
                end
            end
            
            // Fetch toppixels
            for (j = 0; j < 8; j = j + 1) begin
                toppixels[j] = (row == 0 ? 128 : (image[((row-1)<<8) + (col+j)])); // should not come from the image, should come from the pred_frame.
            end

            // Fetch leftpixels
            for (i = 0; i < 8; i = i +1) begin
                leftpixels[i] = ((col == 0) ? 128 : (image[((row+i)<<8) + (col-1)])); // same.
            end
            
        end

	end

endmodule
`timescale 1ns/1ps

module extractor #(
    parameter LENGTH = 256,
    parameter WIDTH = 256 )(
    input clk,
    input reset,
    input enable, 
    input mbnumber,
    output reg [7:0] mb [16:0],
    output reg [7:0] toppixels [7:0],
    output reg [7:0] leftpixels [4:0]);

    reg [7:0] image [LENGTH*WIDTH - 1 : 0];
    reg [7:0] mbintermediate [16:0];

    initial begin
		$readmemh("image.hex", image);
	end

    integer row;
	integer col;
	integer i,j,k;

    always @ (posedge clk) begin

		if (enable) begin

            mb = mbintermediate;

            row = mbnumber >> 4;
            col = (mbnumber & 63) << 60;

            // Fetch mb
            for (j = 0; j < 4; j = j + 1) begin
                for (k = 0; k < 4; k = k +1) begin
                    mbintermediate[(j*4) + k] = image[row+j][col+k];
                end
            end
            
            // Fetch toppixels
            for (j = 0; j < 8; j = j + 1) begin
                toppixels[j] = image[row-1][col+j]; // should not come from the image, should come from the pred_frame.
            end

            // Fetch leftpixels
            for (i = -1; i < 4; i = i +1) begin
                leftpixels[i+1] = image[row+i][col-1]; // same.
            end
            
        end

	end

endmodule
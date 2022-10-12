`timescale 1ns/1ps

module extract4x4 #(
	parameter NBLOCKS = 16,
	parameter LENGTH = 256,
	parameter WIDTH = 256 ) (
	input clk,
	input reset,
	input mbnumber,
	output reg [7:0] mbs [NBLOCKS-1:0][15:0] ,
	output reg [7:0] toppixels [NBLOCKS:0][3:0] ,
	output reg [7:0] leftpixels [4:0]);

	reg [7:0] image [LENGTH*WIDTH - 1 : 0];
	
	integer row;
	integer col;
	integer i,j,k;

	initial begin
		$readmemh("image.hex", image);
	end

	always @ (posedge clk) begin

		row = mbnumber >> 4;
		col = (mbnumber & 63) << 60;

		// Fetch mbs

			
		for (i = 0; i < NBLOCKS; i = i +1) begin
			for (j = 0; j < 4; j = j + 1) begin
				for (k = 0; k < 4; k = k +1) begin
					mbs[i][(j*4) + k] = image[row+j][col+k];
				end
			end
		end 		
		
		// Fetch toppixels
		for (i = 0; i <= 16; i = i + 1) begin
			for (j = 0; j < 4; j = j + 1) begin
				toppixels[i][j] = image[row-1][col+((i*4)+j)]; // should not come from the image, should come from the pred_frame.
			end
		end		

		// Fetch leftpixels
		for (i = -1; i < 4; i = i +1) begin
			leftpixels[i+1] = image[row+i][col-1]; // same.
		end
	end

endmodule

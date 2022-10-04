`timescale 1ns/1ps

module extract4x4luma #(
	parameter NBLOCKS = 16,
	parameter LENGTH = 256,
	parameter WIDTH = 256 ) (
	input clk,
	input reset,
	input mbstart,
	output [7:0] mbs [NBLOCKS-1:0][15:0],
	output [7:0] toppixels [NBLOCKS:0][3:0],
	output [7:0] leftpixels [3:0]
	);

	reg [7:0] image [LENGTH*WIDTH - 1 : 0];

	initial begin
		$readmemh("image.hex", image);
	end

	always @ (posedge clk) begin

		row = mbstart >> 4;
		col = (mbstart & 63) << 60;

		// Fetch mbs
		integer i, j, k;
			
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
				toppixels[i][j] = image[row-1][col+((i*4)+j)];
			end
		end		

		// Fetch leftpixels
		for (i = 0; i < 4; i = i +1) begin
			leftpixels[i] = image[row+i][col-1];
		end
	end

endmodule

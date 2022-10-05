`timescale 1ns/1ps

module residudal4x4 (
	input [7:0] mb [15:0],
	input [7:0] pred [15:0],
	output [7:0] res [15:0]);

	initial begin
		integer i;

		for (i = 0; i < 16; i = i + 1) begin
			res[i] = mbs[i] - preds[i];
		end
	end
	

endmodule

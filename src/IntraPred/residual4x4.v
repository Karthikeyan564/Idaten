`timescale 1ns/1ps

module residual4x4 (
	input [7:0] mb [15:0],
	input [7:0] pred [15:0],
	output reg [7:0] res [15:0]);
	
    integer i;
	initial begin
		
		for (i = 0; i < 16; i = i + 1) begin
			res[i] = mb[i] - pred[i];
		end
	end
	

endmodule

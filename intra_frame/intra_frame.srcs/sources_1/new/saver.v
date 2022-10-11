`timescale 1ns/1ps

module saver(
    input clk,
    input reset,
    input enable,
    input sads [7:0],
    input [7:0] vres [15:0],
	input [7:0] hres [15:0],
    input [7:0] vlres [15:0],
	input [7:0] vrres [15:0],
	input [7:0] hures [15:0],
	input [7:0] hdres [15:0],
    input [7:0] ddlres [15:0],
	input [7:0] ddrres [15:0],
    input [12:0] mbnumber);

    integer i;
    
    reg [2:0] min;

    always @(posedge clk) begin
        
        if (enable) begin

            assign min = 0;
            
            for (i = 1; i < 8; i = i + 1) begin
            
                if (sads[i] < sads[min]) min = i;

            end 
            
            // Save residue corresponding to index

        end

    end

endmodule
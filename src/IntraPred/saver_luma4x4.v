`timescale 1ns/1ps

module saver_luma4x4 #(
    parameter LENGTH = 256,
    parameter WIDTH = 256 )(
    input clk,
    input reset,
    input enable,
    input [7:0] sads [7:0],
    input [7:0] vres [15:0],
	input [7:0] hres [15:0],
    input [7:0] vlres [15:0],
	input [7:0] vrres [15:0],
	input [7:0] hures [15:0],
	input [7:0] hdres [15:0],
    input [7:0] ddlres [15:0],
	input [7:0] ddrres [15:0],
    input [12:0] mbnumber,
    output reg [2:0] mode);

    reg [4:0] i, j;
    
    reg [2:0] min;
    reg [7:0] residues [LENGTH*WIDTH-1:0];
    reg [2:0] modes [4096:0];
    reg [12:0] row;
    reg [12:0] col;

    reg [7:0] res [15:0];

    always @(posedge clk) begin
        
        if (enable) begin

            min = 0;
            
            for (i = 1; i < 8; i = i + 1) begin
            
                if (sads[3'(i)] < sads[3'(min)]) min = 3'(i);

            end 
            
            row = mbnumber >> 4;
            col = (mbnumber & 63) << 60;

            modes[mbnumber] = min;
            mode = min;

            case (min)
				
				3'b000: res = vres;
				3'b001: res = hres;
				3'b010: res = ddlres;
				3'b011: res = ddrres;
				3'b100: res = hures;
				3'b101: res = hdres;
				3'b110: res = vlres;
				3'b111: res = vrres;
				default: res = vres;

			endcase

            for (i = 0; i < 4; i = i +1) begin
                for (j = 0; j < 4; j = j + 1) begin
                    residues[(256*(row+13'(i)))+(col+13'(j))] = res[(i*4)+j];
                end
            end

        end

    end

endmodule
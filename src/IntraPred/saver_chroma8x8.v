`timescale 1ns/1ps

module saver_chroma8x8 #(
    parameter LENGTH = 256,
    parameter WIDTH = 256 )(
    input clk,
    input reset,
    input enable,
    input [7:0] sads [2:0],
    input [7:0] vres [63:0],
	input [7:0] hres [63:0],
    input [7:0] dcres [63:0],
    input [8:0] mbnumber,
    output reg [2:0] mode);

    integer i, j;
    
    reg [2:0] min;
    reg [7:0] residues [LENGTH*WIDTH-1:0];
    reg [2:0] modes [63:0];
    reg [7:0] row;
    reg [7:0] col;

    reg [7:0] res [63:0];

    always @(posedge clk) begin
        
        if (enable) begin

            min = 0;
            
            for (i = 1; i < 3; i = i + 1) begin
            
                if (sads[i] < sads[min]) min = i;

            end 
            
            row <= (mbnumber >> 5) << 3;
            col <= ((mbnumber & 31) - 1) << 3;

            modes[mbnumber] = min;
            mode = min;

            case (min)
				
				3'b000: res = vres;
				3'b001: res = hres;
				3'b010: res = dcres;
				default: res = vres;

			endcase

            for (i = 0; i < 8; i = i +1) begin
                for (j = 0; j < 8; j = j + 1) begin
                    residues[(256*(row+i))+(col+j)] = res[(i*8)+j]; 
                end
            end

        end

    end
endmodule
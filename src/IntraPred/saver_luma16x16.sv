`timescale 1ns/1ps

module saver_luma16x16 #(
    parameter BIT_LENGTH = 15,
    parameter LENGTH = 1280,
    parameter WIDTH = 720,
    parameter MB_SIZE_L = 16,
    parameter MB_SIZE_W = 16)(
    input clk,
    input reset,
    input enable,
    input [7:0] sads [2:0],
    input [7:0] vres [MB_SIZE_L*MB_SIZE_W-1:0],
	input [7:0] hres [MB_SIZE_L*MB_SIZE_W-1:0],
    input [7:0] dcres [MB_SIZE_L*MB_SIZE_W-1:0],
    input [12:0] mbnumber,
    output reg [2:0] mode);

    reg [4:0] i, j;
    
    reg [2:0] min;
    reg [7:0] residues [LENGTH*WIDTH-1:0];
    reg [2:0] modes [(LENGTH/MB_SIZE_L)*(WIDTH/MB_SIZE_W):0];
    reg [12:0] row;
    reg [12:0] col;

    reg [7:0] res [MB_SIZE_L*MB_SIZE_W-1:0];
    
    reg [BIT_LENGTH:0] K1 = LENGTH/MB_SIZE_L;
	reg [BIT_LENGTH:0] K2 = WIDTH/MB_SIZE_W;
	wire [BIT_LENGTH:0] rowShift, colShift;
	
	case (MB_SIZE_L) 
	
	       5'b10000:   assign rowShift = 4;
	       5'b01000:   assign rowShift = 3;
	       5'b00100:   assign rowShift = 2;
	       default:    assign rowShift = 4;
	       
	endcase
	
	case (MB_SIZE_W) 
	
	       5'b10000:   assign colShift = 4;
	       5'b01000:   assign colShift = 3;
	       5'b00100:   assign colShift = 2;
	       default:    assign colShift = 4;
	       
	endcase

    always @(posedge clk) begin
        
        if (enable) begin

            min = 0;
            
            for (i = 1; i < 8; i = i + 1) begin
            
                if (sads[2'(i)] < sads[2'(min)]) min = 3'(i);

            end 
            
            row <= (mbnumber%K1) << rowShift;
            col <= (mbnumber%K2) << colShift;

            modes[9'(mbnumber)] = min;
            mode = min;

            case (min)
				
				3'b000: res = vres;
				3'b001: res = hres;
				3'b010: res = dcres;
				default: res = vres;

			endcase

            for (i = 0; i < MB_SIZE_L; i = i +1) begin
                for (j = 0; j < MB_SIZE_W; j = j + 1) begin
                    residues[((row+13'(i))*LENGTH)+(col+13'(j))] = res[(i*MB_SIZE_L)+j]; //is this right??
                end
            end

        end

    end

endmodule
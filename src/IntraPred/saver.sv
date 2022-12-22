`timescale 1ns/1ps

module saver #(
    parameter BIT_LENGTH = 31,
    parameter WIDTH = 1280,
    parameter LENGTH = 720,
    parameter MB_SIZE_L = 8,
    parameter MB_SIZE_W = 8)(
    input clk,
    input reset,
    input enable,
    input [7:0] sads [(MB_SIZE_L == 4 ? 7 : 2):0],
    input signed [7:0] allresidues [(MB_SIZE_L == 4 ? 7 : 2):0][(MB_SIZE_L*MB_SIZE_W)-1:0],
    input [31:0] mbnumber,
    output reg [2:0] mode,
    output reg signed [7:0] res [MB_SIZE_L*MB_SIZE_W-1:0]);

    reg [4:0] i, j;
    
    reg [2:0] min;
    reg [7:0] residues [LENGTH*WIDTH-1:0];
    reg [2:0] modes [(LENGTH/MB_SIZE_L)*(WIDTH/MB_SIZE_W)-1:0];
    
    reg [12:0] row;
    reg [12:0] col;

    always @(posedge clk) begin
        
        if (enable) begin

            min = 0;
            
            for (i = 1; i < (MB_SIZE_L == 4 ? 8 : 3); i = i + 1) 
                if (sads[3'(i)] < sads[3'(min)]) min = 3'(i);

            row = mbnumber[31:16];
            col = mbnumber[15:0];

            modes[9'(mbnumber)] = min;
            mode = min;
            
            res = allresidues[min];

            for (i = 0; i < MB_SIZE_L; i = i +1) 
                for (j = 0; j < MB_SIZE_W; j = j + 1) 
                    residues[((row+13'(i))*LENGTH)+(col+13'(j))] = res[(i*MB_SIZE_L)+j]; 
                    
        end

    end

endmodule
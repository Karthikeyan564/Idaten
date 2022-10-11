`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2022 17:13:07
// Design Name: 
// Module Name: DDL4x4Luma
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DDL4x4Luma(
    input clk,
    input reset,
    input [7:0] A,
    input [7:0] B,
    input [7:0] C,
    input [7:0] D,
    input [7:0] E,
    input [7:0] F,
    input [7:0] G,
    input [7:0] H,
    input [7:0] I,
    input [7:0] J,
    input [7:0] K,
    input [7:0] L,
    input [7:0] M,
    output reg [7:0] ddlpred [15:0]
    );
    
        always @(posedge clk) begin
            ddlpred[0] <= (A+2*B+C+2)>>2;
            ddlpred[1] <= (B+2*C+D+2)>>2;
            ddlpred[2] <= (C+2*D+E+2)>>2;
            ddlpred[3] <= (D+2*E+F+2)>>2;
            ddlpred[4] <= (B+2*C+D+2)>>2;
            ddlpred[5] <= (C+2*D+E+2)>>2;
            ddlpred[6] <= (D+2*E+F+2)>>2;
            ddlpred[7] <= (E+2*F+G+2)>>2;
            ddlpred[8] <= (C+2*D+E+2)>>2;
            ddlpred[9] <= (D+2*E+F+2)>>2;
            ddlpred[10] <=(E+2*F+G+2)>>2;
            ddlpred[11] <=(F+2*G+H+2)>>2;
            ddlpred[12] <=(D+2*E+F+2)>>2;
            ddlpred[13] <=(E+2*F+G+2)>>2;
            ddlpred[14] <=(F+2*G+H+2)>>2;
            ddlpred[15] <= (G+3*H+2)>>2;       
        end     
        

endmodule


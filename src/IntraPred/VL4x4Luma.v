`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2022 18:12:51
// Design Name: 
// Module Name: VL4x4Luma
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


module VL4x4Luma(
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
    output reg [7:0] vlpred [15:0]
    );
    
        always @(posedge clk) begin
            vlpred[0] <= (A+B+1)>>1; //a
            vlpred[1] <= (B+C+1)>>1;//b
            vlpred[2] <= (C+D+1)>>1;//c
            vlpred[3] <= (D+E+1)>>1;//d
            vlpred[4] <= (A+2*B+C)>>2;//e
            vlpred[5] <= (B+2*C+D+2)>>2;//f
            vlpred[6] <= (C+2*D+E+2)>>2;//g
            vlpred[7] <= (D+2*E+F+2)>>2;//h
            vlpred[8] <= (E+F+1)>>1;//i
            vlpred[9] <= (C+D+1)>>1;//j
            vlpred[10] <=(J+I+1)>>1;//k
            vlpred[11] <=(J+2*I+M+2)>>2;//l
            vlpred[12] <=(B+2*C+D+2)>>2;//m
            vlpred[13] <=(C+2*D+E+2)>>2;//n
            vlpred[14] <=(D+2*E+F+2)>>2;//o
            vlpred[15] <=(E+2*F+G+2)>>2;//p       
        end     
        

endmodule
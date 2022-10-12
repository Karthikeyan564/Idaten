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


module VR4x4Luma(
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
    output reg [7:0] vrpred [15:0]
    );
    
        always @(posedge clk) begin
            vrpred[0] <= (M+A+1)>>1; //a
            vrpred[1] <= (A+B+1)>>1;//b
            vrpred[2] <= (B+C+1)>>1;//c
            vrpred[3] <= (C+D+1)>>1;//d
            vrpred[4] <= (I+2*M+A+2)>>2;//e
            vrpred[5] <= (M+2*A+B+2)>>2;//f
            vrpred[6] <= (A+2*B+C+2)>>2;//g
            vrpred[7] <= (B+2*C+D+2)>>2;//h
            vrpred[8] <= (J+2*I+M+2)>>2;//i
            vrpred[9] <= (M+A+1)>>1;//j
            vrpred[10] <= (A+B+1)>>1;//k
            vrpred[11] <=(B+C+1)>>1;//l
            vrpred[12] <=(K+2*J+I+2)>>2;//m
            vrpred[13] <=(I+2*M+A+2)>>2;;//n
            vrpred[14] <=(M+2*A+B+2)>>2;//o
            vrpred[15] <=(A+2*B+C+2)>>2;;//p       
        end     
        

endmodule

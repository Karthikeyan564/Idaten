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


module HD4x4Luma(
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
    output reg [7:0] hdpred [15:0]
    );
    
        always @(posedge clk) begin
            hdpred[0] <= (I+M+1)>>1; //a
            hdpred[1] <= (I+2*M+A+2)>>2;//b
            hdpred[2] <= (M+2*A+B+2)>>2;//c
            hdpred[3] <= (A+2*B+C+2)>>2;//d
            hdpred[4] <= (J+I+1)>>1;//e
            hdpred[5] <= (J+2*I+M+2)>>2;//f
            hdpred[6] <= (I+M+1)>>1;//g
            hdpred[7] <= (I+2*M+A+2)>>2;//h
            hdpred[8] <= (K+J+1)>>1;//i
            hdpred[9] <= (K+2*J+I+2)>>2;//j
            hdpred[10] <=(J+I+1)>>1;//k
            hdpred[11] <=(J+2*I+M+2)>>2;//l
            hdpred[12] <=(L+K+1)>>1;//m
            hdpred[13] <=(L+2*K+J+2)>>2;;//n
            hdpred[14] <=(K+J+1)>>1;;//o
            hdpred[15] <=(K+2*J+I+2)>>2;//p       
        end     
        

endmodule

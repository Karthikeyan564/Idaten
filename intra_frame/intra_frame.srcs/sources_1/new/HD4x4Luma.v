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
    output reg [7:0] out_pred [15:0]
    );
    
        always @(posedge clk) begin
            out_pred[0] <= (I+M+1)>>1; //a
            out_pred[1] <= (I+2*M+A+2)>>2;//b
            out_pred[2] <= (M+2*A+B+2)>>2;//c
            out_pred[3] <= (A+2*B+C+2)>>2;//d
            out_pred[4] <= (J+I+1)>>1;//e
            out_pred[5] <= (J+2*I+M+2)>>2;//f
            out_pred[6] <= (I+M+1)>>1;//g
            out_pred[7] <= (I+2*M+A+2)>>2;//h
            out_pred[8] <= (K+J+1)>>1;//i
            out_pred[9] <= (K+2*J+I+2)>>2;//j
            out_pred[10] <=(J+I+1)>>1;//k
            out_pred[11] <=(J+2*I+M+2)>>2;//l
            out_pred[12] <=(L+K+1)>>1;//m
            out_pred[13] <=(L+2*K+J+2)>>2;;//n
            out_pred[14] <=(K+J+1)>>1;;//o
            out_pred[15] <=(K+2*J+I+2)>>2;//p       
        end     
        

endmodule

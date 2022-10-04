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
    output reg [7:0] out_pred [15:0]
    );
    
        always @(posedge clk) begin
            out_pred[0] <= (A+B+1)>>1; //a
            out_pred[1] <= (B+C+1)>>1;//b
            out_pred[2] <= (C+D+1)>>1;//c
            out_pred[3] <= (D+E+1)>>1;//d
            out_pred[4] <= (A+2*B+C)>>2;//e
            out_pred[5] <= (B+2*C+D+2)>>2;//f
            out_pred[6] <= (C+2*D+E+2)>>2;//g
            out_pred[7] <= (D+2*E+F+2)>>2;//h
            out_pred[8] <= (E+F+1)>>1;//i
            out_pred[9] <= (C+D+1)>>1;//j
            out_pred[10] <=(J+I+1)>>1;//k
            out_pred[11] <=(J+2*I+M+2)>>2;//l
            out_pred[12] <=(B+2*C+D+2)>>2;//m
            out_pred[13] <=(C+2*D+E+2)>>2;//n
            out_pred[14] <=(D+2*E+F+2)>>2;//o
            out_pred[15] <=(E+2*F+G+2)>>2;//p       
        end     
        

endmodule
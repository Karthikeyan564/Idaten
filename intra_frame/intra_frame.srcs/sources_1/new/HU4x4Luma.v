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


module HU4x4Luma(
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
    output reg [7:0] hupred [15:0]
    );
    
        always @(posedge clk) begin
            hupred[0] <= (J+I+1)>>1; //a
            hupred[1] <= (K+2*J+I)>>2;//b
            hupred[2] <= (K+J+1)>>1;//c
            hupred[3] <= (L+2*K+J+2)>>2;//d
            hupred[4] <= (K+J+1)>>1;//e
            hupred[5] <= (L+2*K+J+2)>>2;//f
            hupred[6] <= (L+K+1)>>1;//g
            hupred[7] <= (3*L+J+2)>>2;//h
            hupred[8] <= (L+K+1)>>1;//i
            hupred[9] <= (3*L+J+2)>>2;//j
            hupred[10] <=L;//k
            hupred[11] <=L;//l
            hupred[12] <=L;//m
            hupred[13] <=L;;//n
            hupred[14] <=L;//o
            hupred[15] <=L;//p       
        end     
        

endmodule

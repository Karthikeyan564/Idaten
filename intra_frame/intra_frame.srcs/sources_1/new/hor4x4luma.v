`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2022 16:53:37
// Design Name: 
// Module Name: hor4x4luma
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


module hor4x4luma(
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
    output reg [7:0] hpred [15:0]
    );
    
        always @(posedge clk) begin
            hpred[0] <=I;
            hpred[1] <=I;
            hpred[2] <=I;
            hpred[3] <=I;
            hpred[4] <=J;
            hpred[5] <=J;
            hpred[6] <=J;
            hpred[7] <=J;
            hpred[8] <=K;
            hpred[9] <=K;
            hpred[10] <=K;
            hpred[11] <=K;
            hpred[12] <=L;
            hpred[13] <=L;
            hpred[14] <=L;
            hpred[15] <=L;       
        end     
        

endmodule

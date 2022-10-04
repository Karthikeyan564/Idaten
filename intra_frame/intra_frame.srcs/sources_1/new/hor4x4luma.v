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
    output reg [7:0] out_pred [15:0]
    );
    
        always @(posedge clk) begin
            out_pred[0] <=I;
            out_pred[1] <=I;
            out_pred[2] <=I;
            out_pred[3] <=I;
            out_pred[4] <=J;
            out_pred[5] <=J;
            out_pred[6] <=J;
            out_pred[7] <=J;
            out_pred[8] <=K;
            out_pred[9] <=K;
            out_pred[10] <=K;
            out_pred[11] <=K;
            out_pred[12] <=L;
            out_pred[13] <=L;
            out_pred[14] <=L;
            out_pred[15] <=L;       
        end     
        

endmodule

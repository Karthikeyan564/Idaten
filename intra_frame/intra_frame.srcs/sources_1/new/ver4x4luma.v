`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2022 17:07:02
// Design Name: 
// Module Name: ver4x4luma
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

module ver4x4luma(
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
    output reg [7:0] vpred [15:0]
    );
    
        always @(posedge clk) begin
            vpred[0] <=I;
            vpred[1] <=J;
            vpred[2] <=K;
            vpred[3] <=L;
            vpred[4] <=I;
            vpred[5] <=J;
            vpred[6] <=K;
            vpred[7] <=L;
            vpred[8] <=I;
            vpred[9] <=J;
            vpred[10] <=K;
            vpred[11] <=L;
            vpred[12] <=I;
            vpred[13] <=J;
            vpred[14] <=K;
            vpred[15] <=L;       
        end     
        

endmodule

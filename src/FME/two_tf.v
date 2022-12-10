`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2022 00:35:11
// Design Name: 
// Module Name: two_tf
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


module two_tf(input clk, input [7:0] x, y, output reg [7:0] quat);

always @ (posedge clk)
 quat <= (x+y+1) >> 1;

endmodule

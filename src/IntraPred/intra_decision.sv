`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.12.2022 07:26:52
// Design Name: 
// Module Name: intra_decision
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


module intra_decision(
    input [11:0] sum_4x4,
    input [11:0] sum_16x16,
    input clk,
    input enable,
    output reg decision

    );
    
    always @ (posedge clk) begin
      if(enable) begin
        if(sum_4x4 > sum_16x16)
            decision = 0;
        else
            decision =  1;
     end
   end
endmodule

`timescale 1ns / 1ps

module decider #(
    parameter WIDTH = 1280,
    parameter LENGTH = 720,
    parameter MB_SIZE_L = 8,
    parameter MB_SIZE_W = 8)(
    input [11:0] sum_4x4,
    input [11:0] sum_16x16,
    input clk,
    input enable,
    output reg decision);
    
    always @ (posedge clk) begin
      if(enable) begin
        if(sum_4x4 > sum_16x16)
            decision = 0;
        else
            decision =  1;
     end
   end
endmodule

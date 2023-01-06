`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.01.2023 23:22:46
// Design Name: 
// Module Name: visualizer
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


module visualizer #(
    parameter LENGTH = 64,
    parameter WIDTH = 64
   )(
    input en,
    input clk,
    input luma_done,
    input chroma_done,
    input [7:0] image [LENGTH*WIDTH - 1: 0],
    output write_done
    
    );
    
    reg [7:0] image_copy [LENGTH*WIDTH - 1: 0]; //we can only write from reg
    always @(posedge clk) begin
    if(en == 1) begin
        if(luma_done == 1 && chroma_done == 1) begin
            image_copy = image;
            $writememh("image_file", image_copy);
        end
     end
   end
           
        
endmodule

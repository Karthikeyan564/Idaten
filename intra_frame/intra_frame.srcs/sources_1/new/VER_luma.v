`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.09.2022 00:50:34
// Design Name: 
// Module Name: VER_luma
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


module VER_luma(
    input clk,
    input reset,
    output reg [7:0] pred_pixels [15:0] // use a meory in this place
 );
    reg [7:0] neighbor_pixels [12:0];
    integer i;
    always @(posedge clk, posedge reset) begin
        for (i = 0; i<4; i=i+1) begin
            pred_pixels[i] <= neighbor_pixels[0];
            pred_pixels[i+4] <= neighbor_pixels[1];
            pred_pixels[i+8] <= neighbor_pixels[2];
            pred_pixels[i+12] <= neighbor_pixels[3];
            
         end
        end
      //pred_pixels to be written into a memory block
        
    
    
    
endmodule

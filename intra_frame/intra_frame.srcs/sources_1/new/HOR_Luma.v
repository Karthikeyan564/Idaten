`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.09.2022 01:23:37
// Design Name: 
// Module Name: HOR_Luma
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


module HOR_luma(
    input clk,
    input reset,
    input [7:0] neighbor_pixels [12:0],
    output reg [7:0] pred_pixels [15:0] // use a meory in this place
 );
    
    integer i;
    always @(posedge clk, posedge reset) begin
        
        for (i = 0; i<4; i=i+1) begin
            pred_pixels[i] <= neighbor_pixels[8];
            pred_pixels[i+1] <= neighbor_pixels[9];
            pred_pixels[i+2] <= neighbor_pixels[10];
            pred_pixels[i+3] <= neighbor_pixels[11];
            
         end
        end
      //pred_pixels to be written into a memory block
        
    
    
    
endmodule

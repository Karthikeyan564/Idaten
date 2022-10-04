`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2022 17:46:46
// Design Name: 
// Module Name: Original_block_gen
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


module Original_block_gen(
    input start_pixel,
    input clk,
    input reset,
    output reg [15:0] original_block [7:0]
    

    );
    reg [1920*1080 - 1:0] img_arr [7:0];
    initial begin
     //memory
     
     
    end
    
    always @(posedge clk, posedge reset, start_pixel) begin
        original_block[0] <= img_arr[start_pixel];
        original_block[1] <= img_arr[start_pixel + 3];
        original_block[2] <= img_arr[start_pixel + 6];
        original_block[3] <= img_arr[start_pixel + 9];
        original_block[4] <= img_arr[start_pixel + 1920*3];
        original_block[5] <= img_arr[start_pixel + 3 + 1920*3];
        original_block[6] <= img_arr[start_pixel + 6 + 1920*3];
        original_block[7] <= img_arr[start_pixel + 9 + 1920*3];
        original_block[8] <= img_arr[start_pixel + 1920*6];
        original_block[9] <= img_arr[start_pixel + 3 + 1920*6];
        original_block[10] <= img_arr[start_pixel + 6 + 1920*6];
        original_block[11] <= img_arr[start_pixel + 9 + 1920*6];
        original_block[12] <= img_arr[start_pixel + 1920*9];
        original_block[13] <= img_arr[start_pixel + 3 + 1920*9];
        original_block[14] <= img_arr[start_pixel + 6 + 1920*9];
        original_block[15] <= img_arr[start_pixel + 9 + 1920*9];
    end
    
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2022 13:44:32
// Design Name: 
// Module Name: extract_macro_block
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


module extract_4x4_block(
    input clk,
    input reset,
    input start_pixel,
    output mb_done,
    output reg [7:0] block_4x4 [15:0]
    );
    
    parameter LENGTH = 256;
    parameter WIDTH = 256;
    
    integer i,j,k;
    reg [7:0] image [LENGTH*WIDTH -1 :0 ];
    
    initial begin
       $readmemh("image.hex",image); 
    end
    
    always @(posedge clk) begin
        for(i=0;i<4;i=i+1) begin
            for(j=0;j<4;j=j+1) begin
                block_4x4[i] = image[start_pixel + LENGTH*WIDTH*3*i + j];
             end
    end
    end    
        
 endmodule

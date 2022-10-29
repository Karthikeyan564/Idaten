`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2022 00:38:36
// Design Name: 
// Module Name: moder_chroma8x8
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


module moder_chroma8x8(
        input clk,
    input reset,
    input enable,
    input [7:0] toppixels [7:0],
    input [7:0] leftpixels [7:0],
    output reg [7:0] vpred [63:0],
    output reg [7:0] hpred [63:0],
    output reg [7:0] dcpred [63:0]);
    
    integer i,j,k;
    reg [12:0] sum = 0;
    
    always @(posedge clk) begin
        sum = 12'b000000000000;
        if (enable == 1) begin 
        
            //vertical
            for(i=0; i<8; i=i+1) begin
                for(j=0;j<8; j=j+1)
                    vpred[i + 8*j] = toppixels[i];
             end
             
             //horizontal
            for(i=0; i<8; i=i+1) begin
                for(j=0;j<8; j=j+1)
                    hpred[j + 8*i] = leftpixels[i];
             end
             
             //dc
             for(i=0;i<8;i=i+1) begin
                sum = sum + toppixels[i];
             end
            
             for(i=0;i<8;i=i+1) begin
                sum = sum + leftpixels[i];
             end
             
             sum = sum >> 5;
             
             for(i=0; i<64; i = i+1) begin
                dcpred[i] = sum;
             end
             
       end
       
   end      
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2022 22:23:48
// Design Name: 
// Module Name: mode16
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


module mode16(
    input clk,
    input reset,
    input [15:0] toppixels [7:0],
    input en,
    input [15:0] leftpixels [7:0],
    output reg [255:0] vpred16 [7:0],
    output reg [255:0] hpred16 [7:0],
    output reg [255:0] dcpred16 [7:0]
    );
    
    integer i,j,k;
    reg [12:0] sum;
    
    always @(posedge clk) begin
        if(en == 1) begin 
            //vertical
            for(i=0; i<16; i=i+1) begin
                for(j=0;j<16; j=j+1)
                    vpred16[i + 16*j] = toppixels[i];
             end
             
             //horizontal
            for(i=0; i<16; i=i+1) begin
                for(j=0;j<16; j=j+1)
                    hpred16[j + 16*i] = leftpixels[i];
             end
             
             //dc
             for(i=0;i<17;i=i+1) begin
                sum = sum + toppixels[i];
             end
            
             for(i=0;i<16;i=i+1) begin
                sum = sum + leftpixels[i];
             end
             
             sum = sum/33;
             
             for(i=0; i<256; i = i+1) begin
                dcpred16[i] = sum;
             end
       end
   end         
                
                
endmodule

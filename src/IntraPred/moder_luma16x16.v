`timescale 1ns / 1ps

module moder_luma16x16(
    input clk,
    input reset,
    input enable,
    input [7:0] toppixels [15:0],
    input [7:0] leftpixels [15:0],
    output reg [7:0] vpred [255:0],
    output reg [7:0] hpred [255:0],
    output reg [7:0] dcpred [255:0]);
    
    integer i,j,k;
    reg [12:0] sum;

    
    always @(posedge clk) begin
        sum = 12'b000000000000;
        if (enable == 1) begin 
        
            //vertical
            for(i=0; i<16; i=i+1) begin
                for(j=0;j<16; j=j+1)
                    vpred[i + 16*j] = toppixels[i];
             end
             
             //horizontal
            for(i=0; i<16; i=i+1) begin
                for(j=0;j<16; j=j+1)
                    hpred[j + 16*i] = leftpixels[i];
             end
             
             //dc
             for(i=0;i<16;i=i+1) begin
                sum = sum + toppixels[i];
             end
            
             for(i=0;i<16;i=i+1) begin
                sum = sum + leftpixels[i];
             end
             
             sum = sum >> 5;
             
             for(i=0; i<256; i = i+1) begin
                dcpred[i] = sum;
             end
             
       end
       
   end         
                     
endmodule

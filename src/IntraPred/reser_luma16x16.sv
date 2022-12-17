`timescale 1ns / 1ps

module reser_luma16x16(
    input clk,
    input reset, 
    input enable,
    input [7:0] mb [255:0],
    input [7:0] vpred [255:0],
    input [7:0] hpred [255:0],
    input [7:0] dcpred [255:0],
    output reg signed [7:0] vres [255:0],
    output reg signed [7:0] hres [255:0],
    output reg signed [7:0] dcres [255:0]);
    
    integer i;
    
    always @(posedge clk) begin
    
        if (enable == 1) begin
        
            for(i=0;i<256;i=i+1) begin
                vres[i] <= mb[i] - vpred[i];
                hres[i] <= mb[i] - hpred[i];
                dcres[i] <= mb[i] - dcpred[i];
             end
             
        end
          
    end
    
endmodule

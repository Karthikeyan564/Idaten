`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2022 23:14:37
// Design Name: 
// Module Name: res16
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


module res16(
    
    input clk,
    input reset, 
    input enable,
    input [7:0] mb [255:0],
    input [7:0] vpred16 [255:0],
    input [7:0] hpred16 [255:0],
    input [7:0] dcpred16 [255:0],
    output reg [7:0] vres16 [255:0],
    output reg [7:0] hres16 [255:0],
    output reg [7:0] dcres16 [255:0]
    );
    
    
    integer i;
   always @(posedge clk) begin
        if(enable == 1)begin
            for(i=0;i<255;i++) begin
                vres16[i] <= mb[i] - vpred16[i];
                hres16[i] <= mb[i] - hpred16[i];
                dcres16[i] <= mb[i] - dcpred16[i];
             end
          end
    end
endmodule

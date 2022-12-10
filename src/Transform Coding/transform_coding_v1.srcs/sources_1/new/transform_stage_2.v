`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2022 19:15:12
// Design Name: 
// Module Name: transform_stage_2
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


module transform_stage_2(
    input clk,
    input en2,
    input reset,
    input [31:0] inp [15:0],
    output reg [31:0] output_2 [15:0]
    );
    
    always @(posedge clk)
        begin
        //row 1
        if(en2==1) begin
            output_2[0] = inp[0] + inp[1] + inp[2] + inp[3];
            output_2[1] = inp[0]<<1 + inp[1] - inp[2] - inp[3]<<1;
            output_2[2] = inp[0] - inp[1] - inp[2] - inp[3];
            output_2[3] = inp[0] - inp[1]<<1 + inp[2]<<1 - inp[3];
            
            
        //row 2
            output_2[4] = inp[4] + inp[5] + inp[6] + inp[7];
            output_2[5] = inp[4]<<1 + inp[5] - inp[6] - inp[7]<<1;
            output_2[6] = inp[4] - inp[5] - inp[6] - inp[7];
            output_2[7] = inp[4] - inp[5]<<1 + inp[6]<<1 - inp[7];
            
        //row 3
            output_2[8] = inp[8] + inp[9] + inp[10] + inp[11];
            output_2[9] = inp[8]<<1 + inp[9] - inp[10] - inp[11]<<1;
            output_2[10] = inp[8] - inp[9] - inp[10] - inp[11];
            output_2[11] = inp[8] - inp[9]<<1 + inp[10]<<1 - inp[11];
 
         //row 4
            output_2[12] = inp[12] + inp[13] + inp[14] + inp[15];
            output_2[13] = inp[12]<<1 + inp[13] - inp[14] - inp[15]<<1;
            output_2[14] = inp[12] - inp[13] - inp[14] - inp[15];
            output_2[15] = inp[12] - inp[13]<<1 + inp[14]<<1 - inp[15];           
          
         end  
       end
endmodule


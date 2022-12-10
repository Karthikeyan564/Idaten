`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2022 18:04:18
// Design Name: 
// Module Name: transform_stage_1
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


module transform_stage_1(
    input clk,
    input en1,
    input reset,
    input [31:0] res [15:0],
    output reg [31:0] output_1 [15:0]
    );
    
    always @(posedge clk)
        begin
        
        if(en1 == 1) begin
        //row 1
            output_1[0] = res[0] + res[4] + res[8] + res[12];
            output_1[1] = res[1] + res[5] + res[9] + res[13];
            output_1[2] = res[2] + res[6] + res[10] + res[14];
            output_1[3] = res[3] + res[7] + res[11] + res[15];
        //row 2
            output_1[4] = res[0]<<1 + res[4] - res[8] - res[12]<<1;
            output_1[5] = res[1]<<1 + res[5] - res[9] - res[13]<<1;
            output_1[6] = res[2]<<1 + res[6] - res[10] - res[14]<<1;
            output_1[7] = res[3]<<1 + res[7] - res[11] - res[15]<<1;   
            
        //ROW 3
            output_1[8] = res[0] - res[4] - res[8] - res[12];
            output_1[9] = res[1] - res[5] - res[9] - res[13];
            output_1[10] = res[2] - res[6] - res[10] - res[14];
            output_1[11] = res[3] - res[7] - res[11] - res[15];
            
       //row 4
            output_1[0] = res[0] - res[4]<<1 + res[8]<<1 - res[12];
            output_1[1] = res[1] - res[5]<<1 + res[9]<<1 - res[13];
            output_1[2] = res[2] - res[6]<<1 + res[10]<<1 - res[14];
            output_1[3] = res[3] - res[7]<<1 + res[11]<<1 - res[15];
          end
       end
endmodule

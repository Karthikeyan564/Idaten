`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.12.2022 07:27:11
// Design Name: 
// Module Name: tccontrol
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


module tccontrol(
    input clk,
    input en1,
    input en2,
    input en3,
    input [31:0] res [15:0],
    output reg [31:0] quant [15:0]
    
    );
    
    reg [31:0] output_1 [15:0];
    reg [31:0] output_2 [15:0];
    
    transform_stage_1 ts1(.clk(clk), .en1(en1), .res(res), .output_1(output_1));
    transform_stage_2 ts2(.clk(clk), .en2(en2), .inp(output_1), .output_2(output_2));
    quantize qnt(.clk(clk), .en3(en3), .transf(output_2), .quant(quant));
    
    
endmodule

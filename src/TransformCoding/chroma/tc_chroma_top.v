`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.01.2023 19:16:14
// Design Name: 
// Module Name: tc_chroma_top
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


module tc_chroma_top(
    input [7:0] residuals [63:0],
    input clk,
    input reset,
    input enable,
    input [5:0] QP,
    output pipeline_full1,
    output pipeline_full2,
    output pipeline_full3,
    output pinpeline_full4,
    output reg signed[7:0] processedres1 [15:0],
    output reg signed[7:0] processedres2 [15:0],
    output reg signed[7:0] processedres3 [15:0],
    output reg signed[7:0] processedres4 [15:0]
);
    reg [7:0] res1 [15:0];
    reg [7:0] res2 [15:0];
    reg [7:0] res3 [15:0];
    reg [7:0] res4 [15:0];
    
    initial begin
        
    end
    transformcoder n1(.residuals(res1),
                      .clk(clk), 
                      .reset(reset),
                      .enable(enable),
                      .QP(QP),
                      .pipeline_full(pipeline_full1),
                      .processedres(processedres1));
                      
     transformcoder n2(.residuals(res2),
                      .clk(clk), 
                      .reset(reset),
                      .enable(enable),
                      .QP(QP),
                      .pipeline_full(pipeline_full2),
                      .processedres(processedres2));
                      
    transformcoder n3(.residuals(res3),
                      .clk(clk), 
                      .reset(reset),
                      .enable(enable),
                      .QP(QP),
                      .pipeline_full(pipeline_full3),
                      .processedres(processedres3));
                      
      transformcoder n4(.residuals(res4),
                      .clk(clk), 
                      .reset(reset),
                      .enable(enable),
                      .QP(QP),
                      .pipeline_full(pipeline_full4),
                      .processedres(processedres4));
endmodule

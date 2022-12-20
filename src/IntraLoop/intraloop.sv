`timescale 1ns / 1ps

module intraloop #(
    parameter BIT_LENGTH = 31)(
    input clk,
    input reset,
    input enable,
    input [12:0] mbnumber,
    output [7:0] mb [15:0]);
    
    wire intrapred_pipeline_full;
    wire tc_pipeline_full;
    
    wire [2:0] mode_luma4x4;
	wire [2:0] mode_luma16x16;
	wire [2:0] mode_chromab8x8;
	wire [2:0] mode_chromar8x8;
	
	wire signed [7:0] res_luma4x4 [15:0];
	wire signed [7:0] res_luma16x16 [255:0];
	wire signed [7:0] res_chromab8x8 [63:0];
	wire signed [7:0] res_chromar8x8 [63:0];
    
    wire signed [7:0] processedres_luma4x4 [15:0];
    
    intrapred uintrapred (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .mbnumber(mbnumber),
        .pipeline_full(intrapred_pipeline_full),
        .mode_luma4x4(mode_luma4x4),
        .mode_luma16x16(mode_luma16x16),
        .mode_chromab8x8(mode_chromab8x8),
        .mode_chromar8x8(mode_chromar8x8),
        .res_luma4x4(res_luma4x4),
        .res_luma16x16(res_luma16x16),
        .res_chromab8x8(res_chromab8x8),
        .res_chromar8x8(res_chromar8x8));
        
    transformcoder utransformcoder (
        .clk(clk),
        .reset(reset),
        .enable(intrapred_pipeline_full),
        .QP(6'd3),
        .residuals(res_luma4x4),
        .pipeline_full(tc_pipeline_full),
        .processedres(processedres_luma4x4));
        
    reconst ureconst (
        .clk(clk),
        .reset(reset),
        .enable(tc_pipeline_full),
        .residue(processedres_luma4x4),
        .mb(mb));
    
endmodule

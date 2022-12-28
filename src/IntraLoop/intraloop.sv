`timescale 1ns / 1ps

module intraloop (
    input clk,
    input reset,
    input enable,
    input [31:0] mbnumber_luma4x4, mbnumber_chromab8x8, mbnumber_chromar8x8,
    output fb_luma4x4, fb_chromab8x8, fb_chromar8x8);
    
    wire intrapred_pipeline_full;
    wire tc_pipeline_full_luma4x4;
    wire tc_pipeline_full_chromab8x8;
    wire tc_pipeline_full_chromar8x8;
    
    wire [2:0] mode_luma4x4;
	wire [2:0] mode_chromab8x8;
	wire [2:0] mode_chromar8x8;
	
	wire signed [7:0] res_luma4x4 [15:0];
	wire signed [7:0] res_chromab8x8 [63:0];
	wire signed [7:0] res_chromar8x8 [63:0];
    
    wire signed [7:0] processedres_luma4x4 [15:0];
    wire signed [7:0] processedres_chromab8x8 [63:0];
    wire signed [7:0] processedres_chromar8x8 [63:0];
    
    intrapred uintrapred (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .mbnumber_luma4x4(mbnumber_luma4x4),
        .mbnumber_chromab8x8(mbnumber_chromab8x8),
        .mbnumber_chromar8x8(mbnumber_chromar8x8),
        .mode_luma4x4(mode_luma4x4),
        .mode_chromab8x8(mode_chromab8x8),
        .mode_chromar8x8(mode_chromar8x8),
        .res_luma4x4(res_luma4x4),
        .res_chromab8x8(res_chromab8x8),
        .res_chromar8x8(res_chromar8x8),
        .pipeline_full(intrapred_pipeline_full));
        
    transformcoder utransformcoder (
        .clk(clk),
        .reset(reset),
        .enable(intrapred_pipeline_full),
        .QP(6'd2),
        .residuals(res_luma4x4),
        .pipeline_full(tc_pipeline_full_luma4x4),
        .processedres(processedres_luma4x4));
        
    reconstructor ureconstructor (
        .clk(clk),
        .reset(reset),
        .enable(tc_pipeline_full),
        .mbnumber_luma4x4(mbnumber_luma4x4),
        .mbnumber_chromab8x8(mbnumber_chromab8x8),
        .mbnumber_chromar8x8(mbnumber_chromar8x8),
        .mode_luma4x4(mode_luma4x4),
        .mode_chromab8x8(mode_chromab8x8),
        .mode_chromar8x8(mode_chromar8x8),
        .residue_luma4x4(processedres_luma4x4),
        .residue_chromab8x8(processedres_chromab8x8),
        .residue_chromar8x8(processedres_chromar8x8),
        .fb_luma4x4(fb_luma4x4),
        .fb_chromab8x8(fb_chromab8x8),
        .fb_chromar8x8(fb_chromar8x8));
    
endmodule

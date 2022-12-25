`timescale 1ns / 1ps

module intraloop #(
    parameter BIT_LENGTH = 31)(
    input clk,
    input reset,
    input enable,
    input [31:0] mbnumber,
    output [7:0] mb [15:0]);
    
    wire intrapred_pipeline_full;
    wire tc_pipeline_full_luma4x4;
    wire tc_pipeline_full_luma16x16;
    wire tc_pipeline_full_chromab8x8;
    wire tc_pipeline_full_chromar8x8;

    reg [31:0] mbnumber_buffer [10:0];
    reg [2:0] modebuffer_luma4x4 [4:0];
    
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
        .QP(6'd2),
        .residuals(res_luma4x4),
        .pipeline_full(tc_pipeline_full_luma4x4),
        .processedres(processedres_luma4x4));
        
    reconstructor ureconstructor (
        .clk(clk),
        .reset(reset),
        .enable(tc_pipeline_full),
        .mbnumber(mbnumber_buffer[8]),
        .mode(modebuffer_luma4x4[3]),
        .residue(processedres_luma4x4),
        .mb(mb));
    
    always @ (posedge clk) begin
        
        if (enable) begin
            mbnumber_buffer[10] = mbnumber_buffer[9];
            mbnumber_buffer[9] = mbnumber_buffer[8];
            mbnumber_buffer[8] = mbnumber_buffer[7];
            mbnumber_buffer[7] = mbnumber_buffer[6];
            mbnumber_buffer[6] = mbnumber_buffer[5];
            mbnumber_buffer[5] = mbnumber_buffer[4];
            mbnumber_buffer[4] = mbnumber_buffer[3];
            mbnumber_buffer[3] = mbnumber_buffer[2];
            mbnumber_buffer[2] = mbnumber_buffer[1];
            mbnumber_buffer[1] = mbnumber_buffer[0];
            mbnumber_buffer[0] = mbnumber;
            
            modebuffer_luma4x4[4] = modebuffer_luma4x4[3];
            modebuffer_luma4x4[3] = modebuffer_luma4x4[2];
            modebuffer_luma4x4[2] = modebuffer_luma4x4[1];
            modebuffer_luma4x4[1] = modebuffer_luma4x4[0];
            modebuffer_luma4x4[0] = mode_luma4x4;
        end
    
    end
    
endmodule

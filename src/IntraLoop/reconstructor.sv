`timescale 1ns / 1ps

module reconstructor #(
    parameter BIT_LENGTH = 15,
    parameter WIDTH = 1280,
    parameter LENGTH = 720,
    parameter MB_SIZE_L = 4,
    parameter MB_SIZE_W = 4)(
    input clk,
    input reset,
    input enable,
    input [31:0] mbnumber,
    input [2:0] mode,
    input signed [7:0] residue [(MB_SIZE_L*MB_SIZE_W)-1:0],
    output reg [7:0] mb [MB_SIZE_L*MB_SIZE_W-1:0]);
        
    reg [7:0] reconstructed [(LENGTH*WIDTH)-1:0];
    
    int resi;
    initial for (resi = 0; resi < (LENGTH*WIDTH); resi = resi + 1) reconstructed[resi] = 8'd0;
    
    reg [7:0] toppixels [(MB_SIZE_W == 4 ? 7 : MB_SIZE_W-1):0];
    reg [7:0] leftpixels [(MB_SIZE_L == 4 ? 4 : MB_SIZE_L-1):0];
    
    reg [7:0] A, B, C, D, E, F, G, H, I, J, K, L, M;
    
    reg signed [7:0] allpreds [(MB_SIZE_L == 4 ? 7 : 2):0][(MB_SIZE_L*MB_SIZE_W)-1:0];
    
    reg [15:0] row, col;
    reg [12:0] sum = 0;
	reg [8:0] i, j, k;
    
    wire [7:0] toppixels_luma4x4 [7:0];
	wire [7:0] toppixels_luma16x16 [15:0];
	wire [7:0] toppixels_chromab8x8 [7:0];
	wire [7:0] toppixels_chromar8x8 [7:0];
	
	wire [7:0] leftpixels_luma4x4 [4:0];
	wire [7:0] leftpixels_luma16x16 [15:0];
	wire [7:0] leftpixels_chromab8x8 [7:0];
	wire [7:0] leftpixels_chromar8x8 [7:0];
    
    // Retrieve neighbouring pixels		
	// Luma 4x4
	extractor_np #(.MB_SIZE_L(4), .MB_SIZE_W(4)) uextractor_np_luma4x4 (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .mbnumber(mbnumber),
        .toppixels(toppixels_luma4x4),
        .leftpixels(leftpixels_luma4x4));
        
	// Luma 16x16
	extractor_np #(.MB_SIZE_L(16), .MB_SIZE_W(16)) uextractor_np_luma16x16 (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.mbnumber(mbnumber),
		.toppixels(toppixels_luma16x16),
		.leftpixels(leftpixels_luma16x16));

    // ChromaB 8x8
    extractor_np #(.MB_SIZE_L(8), .MB_SIZE_W(8)) uextractor_np_chromab8x8 (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .mbnumber(mbnumber),
        .toppixels(toppixels_chromab8x8),
        .leftpixels(leftpixels_chromab8x8));
               
    // ChromaR 8x8
    extractor_np #(.MB_SIZE_L(8), .MB_SIZE_W(8)) uextractor_np_chromar8x8 (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .mbnumber(mbnumber),
        .toppixels(toppixels_chromar8x8),
        .leftpixels(leftpixels_chromar8x8));
    
    always @ (posedge clk) begin

		if (enable) begin

            for (k = 0; k < (MB_SIZE_L*MB_SIZE_W); k = k + 1)
                mb[5'(k)] = allpreds[mode][5'(k)] + residue[5'(k)];
                        
        end

	end
    
endmodule

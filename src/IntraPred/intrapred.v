`timescale 1ns/1ps

module intrapred (
	input clk,
	input reset,
	input enable,
	input [12:0] mbnumber);
    
	// inputs
	wire [7:0] mb_luma4x4 [15:0];
	wire [7:0] mb_luma16x16 [255:0];
	wire [7:0] mb_chromab8x8 [63:0];
	wire [7:0] mb_chromar8x8 [63:0];
	
	wire [7:0] toppixels_luma4x4 [7:0];
	wire [7:0] toppixels_luma16x16 [15:0];
	wire [7:0] toppixels_chromab8x8 [7:0];
	wire [7:0] toppixels_chromar8x8 [7:0];
	
	wire [7:0] leftpixels_luma4x4 [4:0];
	wire [7:0] leftpixels_luma16x16 [15:0];
	wire [7:0] leftpixels_chromab8x8 [7:0];
	wire [7:0] leftpixels_chromar8x8 [7:0];

	// neighbouring pixels
	wire [7:0] A = toppixels_luma4x4[0];
	wire [7:0] B = toppixels_luma4x4[1];
	wire [7:0] C = toppixels_luma4x4[2];
	wire [7:0] D = toppixels_luma4x4[3];
	wire [7:0] E = toppixels_luma4x4[4];
	wire [7:0] F = toppixels_luma4x4[5];
	wire [7:0] G = toppixels_luma4x4[6];
	wire [7:0] H = toppixels_luma4x4[7];
	wire [7:0] M = leftpixels_luma4x4[0];
	wire [7:0] I = leftpixels_luma4x4[1];
	wire [7:0] J = leftpixels_luma4x4[2];
	wire [7:0] K = leftpixels_luma4x4[3];
	wire [7:0] L = leftpixels_luma4x4[4];

	// preds
	wire [7:0] vpred_luma4x4 [15:0];
	wire [7:0] hpred_luma4x4 [15:0];
	wire [7:0] ddlpred_luma4x4 [15:0];
	wire [7:0] ddrpred_luma4x4 [15:0];
	wire [7:0] hupred_luma4x4 [15:0];
	wire [7:0] hdpred_luma4x4 [15:0];
	wire [7:0] vlpred_luma4x4 [15:0];
	wire [7:0] vrpred_luma4x4 [15:0];
	
	wire [7:0] vpred_luma16x16 [255:0];
	wire [7:0] hpred_luma16x16 [255:0];
	wire [7:0] dcpred_luma16x16 [255:0];
	
	wire [7:0] vpred_chromab8x8 [63:0];
	wire [7:0] hpred_chromab8x8 [63:0];
	wire [7:0] dcpred_chromab8x8 [63:0];
	wire [7:0] vpred_chromar8x8 [63:0];
	wire [7:0] hpred_chromar8x8 [63:0];
	wire [7:0] dcpred_chromar8x8 [63:0];
	
	// res
	wire [7:0] vres_luma4x4 [15:0];
	wire [7:0] hres_luma4x4 [15:0];
	wire [7:0] ddlres_luma4x4 [15:0];
	wire [7:0] ddrres_luma4x4 [15:0];
	wire [7:0] hures_luma4x4 [15:0];
	wire [7:0] hdres_luma4x4 [15:0];
	wire [7:0] vlres_luma4x4 [15:0];
	wire [7:0] vrres_luma4x4 [15:0];
	
    wire [7:0] vres_luma16x16 [255:0];
    wire [7:0] hres_luma16x16 [255:0];
    wire [7:0] dcres_luma16x16 [255:0];
    
    wire [7:0] vres_chromab8x8 [63:0];
	wire [7:0] hres_chromab8x8 [63:0];
	wire [7:0] dcres_chromab8x8 [63:0];
	wire [7:0] vres_chromar8x8 [63:0];
	wire [7:0] hres_chromar8x8 [63:0];
	wire [7:0] dcres_chromar8x8 [63:0];

	// sad	
	wire [7:0] sads_luma4x4 [7:0];
	wire [7:0] sads_luma16x16 [2:0];
	wire [7:0] sads_chromab8x8 [2:0];
	wire [7:0] sads_chromar8x8 [2:0];
	
	// outputs
	reg [2:0] mode_luma4x4;
	reg [2:0] mode_luma16x16;
	reg [2:0] mode_chromab8x8;
	reg [2:0] mode_chromar8x8;
		
	// Retrieve macroblock and neighbouring pixels		
	// Luma 4x4
	extractor_luma4x4 uextractor_luma4x4 (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.mbnumber(mbnumber),
		.mb(mb_luma4x4),
		.toppixels(toppixels_luma4x4),
		.leftpixels(leftpixels_luma4x4));
		
	// Luma 16x16
	extractor_luma16x16 uextractor_luma16x16 (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.mbnumber(mbnumber),
		.mb(mb_luma16x16),
		.toppixels(toppixels_luma16x16),
		.leftpixels(leftpixels_luma16x16));

    // ChromaB 8x8
    extractor_chroma8x8 uextractor_chromab8x8 (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .mbnumber(mbnumber),
        .mb(mb_chromab8x8),
        .toppixels(toppixels_chromab8x8),
        .leftpixels(leftpixels_chromab8x8));
        
    // ChromaR 8x8
    extractor_chroma8x8 uextractor_chromar8x8 (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .mbnumber(mbnumber),
        .mb(mb_chromar8x8),
        .toppixels(toppixels_chromar8x8),
        .leftpixels(leftpixels_chromar8x8));

	// Compute 8 modes
	// Luma 4x4
	moder_luma4x4 umoder_luma4x4 (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.A(A),
		.B(B),
		.C(C),
		.D(D),
		.E(E),
		.F(F),
		.G(G),
		.H(H),
		.I(I),
		.J(J),
		.K(K),
		.L(L),
		.M(M),
		.vpred(vpred_luma4x4),
		.hpred(hpred_luma4x4),
		.vlpred(vlpred_luma4x4),
		.vrpred(vrpred_luma4x4),
		.hupred(hupred_luma4x4),
		.hdpred(hdpred_luma4x4),
		.ddlpred(ddlpred_luma4x4),
		.ddrpred(ddrpred_luma4x4));

    // Luma 16x16
    moder_luma16x16 umoder_luma16x16 (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .toppixels(toppixels_luma16x16),
        .leftpixels(leftpixels_luma16x16),
        .vpred(vpred_luma16x16),
        .hpred(hpred_luma16x16),
        .dcpred(dcpred_luma16x16));
        
    // ChromaB 8x8
    // ChromaR 8x8
      
	// Compute Residual
	// Luma 4x4
	reser_luma4x4 ureser_luma4x4 (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.mb(mb_luma4x4),
		.vpred(vpred_luma4x4),
		.hpred(hpred_luma4x4),
		.vlpred(vlpred_luma4x4),
		.vrpred(vrpred_luma4x4),
		.hupred(hupred_luma4x4),
		.hdpred(hdpred_luma4x4),
		.ddlpred(ddlpred_luma4x4),
		.ddrpred(ddrpred_luma4x4),
		.vres(vres_luma4x4),
		.hres(hres_luma4x4),
		.vlres(vlres_luma4x4),
		.vrres(vrres_luma4x4),
		.hures(hures_luma4x4),
		.hdres(hdres_luma4x4),
		.ddlres(ddlres_luma4x4),
		.ddrres(ddrres_luma4x4));

    // Luma 16x16
    reser_luma16x16 ureser_luma16x16 (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.mb(mb_luma16x16),
		.vpred(vpred_luma16x16),
		.hpred(hpred_luma16x16),
		.dcpred(dcres_luma16x16),
		.vres(vres_luma16x16),
		.hres(hres_luma16x16),
		.dcres(dcres_luma16x16));
		
    // ChromaB 8x8
    // ChromaR 8x8
    
	// Compute SAD
	// Luma 4x4
	sader_luma4x4 usader_luma4x4 (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.vres(vres_luma4x4),
		.hres(hres_luma4x4),
		.vlres(vlres_luma4x4),
		.vrres(vrres_luma4x4),
		.hures(hures_luma4x4),
		.hdres(hdres_luma4x4),
		.ddlres(ddlres_luma4x4),
		.ddrres(ddrres_luma4x4),
		.sads(sads_luma4x4));

    // Luma 16x16
    sader_luma16x16 usader_luma16x16 (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.vres(vres_luma16x16),
		.hres(hres_luma16x16),
		.dcres(dcres_luma16x16),
		.sads(sads_luma16x16));
		
	// ChromaB 8x8
	// ChromaR 8x8
		
	// Make decision and store residual
	// Luma 4x4
	saver_luma4x4 usaver_luma4x4 (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.sads(sads_luma4x4),
		.vres(vres_luma4x4),
		.hres(hres_luma4x4),
		.vlres(vlres_luma4x4),
		.vrres(vrres_luma4x4),
		.hures(hures_luma4x4),
		.hdres(hdres_luma4x4),
		.ddlres(ddlres_luma4x4),
		.ddrres(ddrres_luma4x4),
		.mbnumber(mbnumber),
		.mode(mode_luma4x4));
		
	// Luma 16x16
	saver_luma16x16 usaver_luma16x16 (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.sads(sads_luma16x16),
		.vres(vres_luma16x16),
		.hres(hres_luma16x16),
		.dcres(dcres_luma16x16),
		.mbnumber(mbnumber),
		.mode(mode_luma16x16));
		
	// ChromaB 8x8
	// ChromaR 8x8
	
endmodule

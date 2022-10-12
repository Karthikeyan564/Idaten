`timescale 1ns/1ps

module intrapred (
	input clk,
	input reset,
	input enable,
	input mbnumber);
    
	// Declarations
	wire [7:0] mb [15:0];
	wire [7:0] toppixels [7:0];
	wire [7:0] leftpixels [4:0];

	// neighbouring pixels
	wire [7:0] A = toppixels[0];
	wire [7:0] B = toppixels[1];
	wire [7:0] C = toppixels[2];
	wire [7:0] D = toppixels[3];
	wire [7:0] E = toppixels[4];
	wire [7:0] F = toppixels[5];
	wire [7:0] G = toppixels[6];
	wire [7:0] H = toppixels[7];
	wire [7:0] M = leftpixels[0];
	wire [7:0] I = leftpixels[1];
	wire [7:0] J = leftpixels[2];
	wire [7:0] K = leftpixels[3];
	wire [7:0] L = leftpixels[4];

	// preds
	wire [7:0] vpred [15:0];
	wire [7:0] hpred [15:0];
	wire [7:0] ddlpred [15:0];
	wire [7:0] ddrpred [15:0];
	wire [7:0] hupred [15:0];
	wire [7:0] hdpred [15:0];
	wire [7:0] vlpred [15:0];
	wire [7:0] vrpred [15:0];
	
	// res
	wire [7:0] vres [15:0];
	wire [7:0] hres [15:0];
	wire [7:0] ddlres [15:0];
	wire [7:0] ddrres [15:0];
	wire [7:0] hures [15:0];
	wire [7:0] hdres [15:0];
	wire [7:0] vlres [15:0];
	wire [7:0] vrres [15:0];
	wire [7:0] res [15:0];

	// sad	
	wire sads [7:0];
		
	// Retrieve macroblock and neighbouring pixels		
	extractor uextractor (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.mbnumber(mbnumber),
		.mb(mb),
		.toppixels(toppixels),
		.leftpixels(leftpixels));

	// Compute 8 modes
	moder umoder (
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
		.vpred(vpred),
		.hpred(hpred),
		.vlpred(vlpred),
		.vrpred(vrpred),
		.hupred(hupred),
		.hdpred(hdpred),
		.ddlpred(ddlpred),
		.ddrpred(ddrpred));

	// Compute Residual
	reser ureser (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.mb(mb),
		.vpred(vpred),
		.hpred(hpred),
		.vlpred(vlpred),
		.vrpred(vrpred),
		.hupred(hupred),
		.hdpred(hdpred),
		.ddlpred(ddlpred),
		.ddrpred(ddrpred),
		.vres(vres),
		.hres(hres),
		.vlres(vlres),
		.vrres(vrres),
		.hures(hures),
		.hdres(hdres),
		.ddlres(ddlres),
		.ddrres(ddrres));

	// Compute SAD
	sader usader (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.vres(vres),
		.hres(hres),
		.vlres(vlres),
		.vrres(vrres),
		.hures(hures),
		.hdres(hdres),
		.ddlres(ddlres),
		.ddrres(ddrres),
		.sads(sads));

	// Make decision and store residual
	saver usaver (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.sads(sads),
		.vres(vres),
		.hres(hres),
		.vlres(vlres),
		.vrres(vrres),
		.hures(hures),
		.hdres(hdres),
		.ddlres(ddlres),
		.ddrres(ddrres),
		.mbnumber(mbnumber));
	
endmodule

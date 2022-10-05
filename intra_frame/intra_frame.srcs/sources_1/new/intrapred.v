`timescale 1ns/1ps

module intrapred (
	input clk,
	input reset);

	// Declarations
	reg [7:0] mbs [NBLOCKS-1:0][15:0];
	reg [7:0] toppixels [NBLOCKS:0][3:0];
	reg [7:0] leftpixels [4:0];

	// preds
	reg [7:0] vpred [15:0];
	reg [7:0] hpred [15:0];
	reg [7:0] ddlpred [15:0];
	reg [7:0] ddrpred [15:0];
	reg [7:0] hupred [15:0];
	reg [7:0] hdpred [15:0];
	reg [7:0] vlred [15:0];
	reg [7:0] vrred [15:0];
	
	// res
	reg [7:0] vres [15:0];
	reg [7:0] hres [15:0];
	reg [7:0] ddlres [15:0];
	reg [7:0] ddrres [15:0];
	reg [7:0] hures [15:0];
	reg [7:0] hdres [15:0];
	reg [7:0] vlres [15:0];
	reg [7:0] vrres [15:0];
	reg [7:0] res [15:0];

	// neighbouring pixels
	wire [7:0] A;
	wire [7:0] B;
	wire [7:0] C;
	wire [7:0] D;
	wire [7:0] E;
	wire [7:0] F;
	wire [7:0] G;
	wire [7:0] H;
	wire [7:0] I;
	wire [7:0] J;
	wire [7:0] K;
	wire [7:0] L;
	wire [7:0] M;

	// sad	
	reg sads [7:0];

	wire mbnumber;
	wire optimal;

	initial begin
		
		// Retrieve macroblock and neighbouring pixels
		extract4x4 extractor (
			.clk(clk), 
			.reset(reset), 
			.mbnumber(mbnumber), 
			.mbs(mbs),
			.toppixels(toppixels),
			.leftpixels(leftpixels));

		// Compute 8 modes
			VER_Luma vl (
				.clk(clk),
				.reset(reset),
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
				.pred_pixels(vpred));

			HOR_Luma hl (
				.clk(clk),
				.reset(reset),
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
				.pred_pixels(hpred));

			DDL4x4Luma ddl (
				.clk(clk),
				.reset(reset),
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
				.pred_pixels(ddlpred));

			DDR4x4Luma ddr (
				.clk(clk),
				.reset(reset),
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
				.pred_pixels(ddrpred));		

			HU4x4Luma hu (
				.clk(clk),
				.reset(reset),
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
				.pred_pixels(hupred));

			HD4x4Luma hd (
				.clk(clk),
				.reset(reset),
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
				.pred_pixels(hdpred));	

			VL4x4Luma vl (
				.clk(clk),
				.reset(reset),
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
				.pred_pixels(vlpred));

			VR4x4Luma vr (
				.clk(clk),
				.reset(reset),
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
				.pred_pixels(vrpred));
			
			// Compute Residual
			residual4x4 r1 (mb, vpred, vres);
			residual4x4 r2 (mb, hpred, hres);
			residual4x4 r3 (mb, ddlpred, ddlres);
			residual4x4 r4 (mb, ddrpred, ddrres);
			residual4x4 r5 (mb, hupred, hures);
			residual4x4 r6 (mb, hdpred, hdres);
			residual4x4 r7 (mb, vlpred, vlres);
			residual4x4 r8 (mb, vrpred, vrres);

			// Compute SAD
			sad s1 (vres, sads[0]);
			sad s2 (hres, sads[1]);
			sad s3 (ddlres, sads[2]);
			sad s4 (ddrres, sads[3]);
			sad s5 (hures, sads[4]);
			sad s6 (hdres, sads[5]);
			sad s7 (vlres, sads[6]);
			sad s8 (vrres, sads[7]);

			// Make decision
			mindex m1 (sads, optimal);

			// Store residual
			save4x4 saver (optimal, mbnumber, res);


	end

	// Put everything in a loop
	integer mbcounter, blockcounter;

	for (mbcounter = 1; mbcounter <= 4096; mbcounter = mbcounter + NBLOCKS) begin		

		assign mbnumber = mbcounter;

		for (blockcounter = 0; blockcounter < NBLOCKS; blockcounter = blockcounter + 1) begin
			
			// Split pixels into A-M
			assign A = toppixels[blockcounter][0];
			assign B = toppixels[blockcounter][1];
			assign C = toppixels[blockcounter][2];
			assign D = toppixels[blockcounter][3];
			assign E = toppixels[blockcounter+1][0];
			assign F = toppixels[blockcounter+1][1];
			assign G = toppixels[blockcounter+1][2];
			assign H = toppixels[blockcounter+1][3];
			assign M = leftpixels[0];
			assign I = leftpixels[1];
			assign J = leftpixels[2];
			assign K = leftpixels[3];
			assign L = leftpixels[4];

			case (optimal) begin
				
				3b'000: res = vres;
				3b'001: res = hres;
				3b'010: res = ddlres;
				3b'011: res = ddrres;
				3b'100: res = hures;
				3b'101: res = hdres;
				3b'110: res = vlres;
				3b'111: res = vrres;

			endcase



		end
	end
	
endmodule
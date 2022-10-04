`timescale 1ns/1ps

module intrapred (
	input clk,
	input reset);

	// Declarations
	reg [7:0] mbs [NBLOCKS-1:0][15:0];
	reg [7:0] toppixels [NBLOCKS:0][3:0];
	reg [7:0] leftpixels [3:0];

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

	// sad	
	reg sads [7:0];

	// Put everything in a loop
	integer mbcounter, blockcounter;

	for (mbcounter = 1; mbcounter <= 4096; mbcounter = mbcounter + 16) begin

		// Retrieve macroblock and neighbouring pixels
		extract4x4luma(
			.clk(clk), 
			.reset(reset), 
			.mbstart(mbcounter), 
			.mbs(mbs),
			.toppixels(toppixels),
			.leftpixels(leftpixels));

		for (blockcounter = 0; blockcounter <= NBLOCKS; blockcounter = blockcounter + 1) begin
			
			// Split pixels into A-L

			// Compute 8 modes
			VER_Luma(
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
			
			VER_Luma(
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

			VER_Luma(
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

			VER_Luma(
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
				
			VER_Luma(
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

			VER_Luma(
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

			VER_Luma(
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

			VER_Luma(
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
			
			// Compute Residual
			residual4x4(mb, vpred, vres);
			residual4x4(mb, hpred, hres);
			residual4x4(mb, ddlpred, ddlres);
			residual4x4(mb, ddrpred, ddrres);
			residual4x4(mb, hupred, hures);
			residual4x4(mb, hdpred, hdres);
			residual4x4(mb, vlpred, vlres);
			residual4x4(mb, vrpred, vrres);

			// Compute SAD
			sad(vres, sads[0]);
			sad(hres, sads[1]);
			sad(ddlres, sads[2]);
			sad(ddrres, sads[3]);
			sad(hures, sads[4]);
			sad(hdres, sads[5]);
			sad(vlres, sads[6]);
			sad(vrres, sads[7]);

			// Make decision
			mindex(sads, optimal);

			// Store residual
			
		end
	end
	
endmodule

`timescale 1ns/1ps

module intrapred (
	input clk,
	input reset);
    
    parameter NBLOCKS = 16;
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
	reg [7:0] A;
	reg [7:0] B;
	reg [7:0] C;
	reg [7:0] D;
	reg [7:0] E;
	reg [7:0] F;
	reg [7:0] G;
	reg [7:0] H;
	reg [7:0] I;
	reg [7:0] J;
	reg [7:0] K;
	reg [7:0] L;
	reg [7:0] M;

	// sad	
	reg sads [7:0];

	integer mbnumber;
	integer optimal;
		
		// Retrieve macroblock and neighbouring pixels
		extract4x4 extractor (
			.clk(clk), 
			.reset(reset), 
			.mbnumber(mbnumber), 
			.mbs(mbs),
			.toppixels(toppixels),
			.leftpixels(leftpixels));			

		// 8 modes

		// Compute Residual

		// Compute SAD

		// Make decision and store residual
		save4x4 saver (optimal, mbnumber, res);

	// Put everything in a loop
	integer mbcounter, blockcounter;
	
	always @(posedge clk) begin

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

			case (optimal)
				
				3'b000: res = vres;
				3'b001: res = hres;
				3'b010: res = ddlres;
				3'b011: res = ddrres;
				3'b100: res = hures;
				3'b101: res = hdres;
				3'b110: res = vlres;
				3'b111: res = vrres;
				default: res = vres;

			endcase

    end

		end
	end
	
endmodule

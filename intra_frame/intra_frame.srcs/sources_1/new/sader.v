`timescale 1ns/1ps

module sader (
    input clk,
    input reset,
    input enable,
    input [7:0] vres [15:0],
	input [7:0] hres [15:0],
    input [7:0] vlres [15:0],
	input [7:0] vrres [15:0],
	input [7:0] hures [15:0],
	input [7:0] hdres [15:0],
    input [7:0] ddlres [15:0],
	input [7:0] ddrres [15:0],
    output reg sads [7:0]);

    reg [7:0] vsamp;
    reg [7:0] hsamp;
    reg [7:0] vlsamp;
    reg [7:0] vrsamp;
    reg [7:0] husamp;
    reg [7:0] hdsamp;
    reg [7:0] ddlsamp;
    reg [7:0] ddrsamp;

    always @(posedge clk) begin

        assign sads = 8'b0000000;

        if (enable) begin

            integer i;

            for (i = 0; i < 16; i = i + 1) begin
                
                vsamp = vres[i]; vsamp = vsamp < 0 ? vsamp * -1 : vsamp; sads[0] = sads[0] + 1;
                hsamp = hres[i]; hsamp = hsamp < 0 ? hsamp * -1 : hsamp; sads[1] = sads[1] + 1;
                vlsamp = vlres[i]; vlsamp = vlsamp < 0 ? vlsamp * -1 : vlsamp; sads[2] = sads[2] + 1;
                vrsamp = vrres[i]; vrsamp = vrsamp < 0 ? vrsamp * -1 : vrsamp; sads[3] = sads[3] + 1;
                husamp = hures[i]; husamp = husamp < 0 ? husamp * -1 : husamp; sads[4] = sads[4] + 1;
                hdsamp = hdres[i]; hdsamp = hdsamp < 0 ? hdsamp * -1 : hdsamp; sads[5] = sads[5] + 1;
                ddlsamp = ddlres[i]; ddlsamp = ddlsamp < 0 ? ddlsamp * -1 : ddlsamp; sads[6] = sads[6] + 1;
                ddrsamp = ddrres[i]; ddrsamp = ddrsamp < 0 ? ddrsamp * -1 : ddrsamp; sads[7] = sads[7] + 1;

            end

        end

    end

endmodule
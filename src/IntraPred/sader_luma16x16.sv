`timescale 1ns/1ps

module sader_luma16x16 (
    input clk,
    input reset,
    input enable,
    input [7:0] vres [255:0],
	input [7:0] hres [255:0],
	input [7:0] dcres [255:0],
    output reg [7:0] sads [2:0]);

    reg signed [7:0] vsamp16;
    reg signed [7:0] hsamp16;
    reg signed [7:0] dcsamp16;
    
    integer i;
    integer j;

    always @(posedge clk) begin

        if (enable) begin

            for(j =0; j<3;j=j+1)begin
                sads[j] = 8'b00000000;
            end

            for (i = 0; i < 256; i = i + 1) begin
                
                vsamp16 = vres[i]; vsamp16 = vsamp16 < 0 ? vsamp16 * -1 : vsamp16; sads[0] = sads[0] + vsamp16; 
                hsamp16 = hres[i]; hsamp16 = hsamp16 < 0 ? hsamp16 * -1 : hsamp16; sads[1] = sads[1] + hsamp16;
                dcsamp16 = dcres[i]; dcsamp16 = dcsamp16 < 0 ? dcsamp16 * -1 : dcsamp16; sads[2] = sads[2] + dcsamp16;

            end

        end

    end

endmodule

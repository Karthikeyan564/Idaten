`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2022 02:00:30
// Design Name: 
// Module Name: sadchroma8x8
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps

module sader_chroma8x8 (
    input clk,
    input reset,
    input enable,
    input [7:0] vres [63:0],
	input [7:0] hres [63:0],
	input [7:0] dcres [63:0],
    output reg [7:0] sads [2:0]);

    reg [7:0] vsamp8;
    reg [7:0] hsamp8;
    reg [7:0] dcsamp8;
    
    integer i;
    integer j;

    always @(posedge clk) begin

        if (enable) begin

            for(j =0; j<3;j=j+1)begin
                sads[j] = 8'b00000000;
            end

            for (i = 0; i < 64; i = i + 1) begin
                
                vsamp8 = vres[i]; vsamp8 = vsamp8 < 0 ? vsamp8 * -1 : vsamp8; sads[0] = sads[0] + vsamp8; 
                hsamp8 = hres[i]; hsamp8 = hsamp8 < 0 ? hsamp8 * -1 : hsamp8; sads[1] = sads[1] + hsamp8;
                dcsamp8 = dcres[i]; dcsamp8 = dcsamp8 < 0 ? dcsamp8 * -1 : dcsamp8; sads[2] = sads[2] + dcsamp8;

            end

        end

    end

endmodule

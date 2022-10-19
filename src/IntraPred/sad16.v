`timescale 1ns/1ps

module sad16 (
    input clk,
    input reset,
    input enable,
    input [7:0] vres16 [255:0],
	input [7:0] hres16 [255:0],
	input [7:0] dcres16 [255:0],





    output reg [7:0] sads16 [2:0] );

    reg [7:0] vsamp16;
    reg [7:0] hsamp16;
    reg [7:0] dcsamp16;
    
    integer i;
    integer j;

    always @(posedge clk) begin
        
        

        if (enable) begin

            for(j =0; j<8;j=j+1)begin
                sads16[j] = 8'b00000000;
            end

            for (i = 0; i < 256; i = i + 1) begin
                
                vsamp16 = vres16[i]; vsamp16 = vsamp16 < 0 ? vsamp16 * -1 : vsamp16; sads16[0] = sads16[0] + vsamp16; 
                hsamp16 = hres16[i]; hsamp16 = hsamp16 < 0 ? hsamp16 * -1 : hsamp16; sads16[1] = sads16[1] + hsamp16;
                dcsamp16 = dcres16[i]; dcsamp16 = dcsamp16 < 0 ? dcsamp16 * -1 : dcsamp16; sads16[2] = sads16[2] + dcsamp16;


            end

        end

    end

endmodule

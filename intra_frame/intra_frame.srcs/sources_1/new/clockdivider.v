`timescale 1ns/1ps

module clockdivider (
    input clk,
    input reset,
    input enable,
    output dividedclk);

    reg [7:0] divided;

    initial begin
        divided = 8'b00000000;
    end

    always @(posedge clk) begin
        
        if (enable) begin

            divided <= divided + 1;

            assign dividedclk = divided[4];

        end

    end 

endmodule
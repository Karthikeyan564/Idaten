`timescale 1ns / 1ps

module transformcoder_tb;

    parameter BIT_LENGTH = 15;

    reg clk, enable, reset;
    reg [BIT_LENGTH:0] residuals [15:0];
    wire [BIT_LENGTH:0] processed [15:0];
    
    integer i;
    
    transformcoder #(.BIT_LENGTH(BIT_LENGTH)) utransformcoder (
        .clk(clk),
        .enable(enable),
        .reset(reset),
        .residuals(residuals),
        .processedres(processed),
        .QP(6'd35));
    
    initial begin
    
        enable = 1;
        reset = 0;
        for (i = 0; i < 16; i = i +1) residuals[i] = $urandom%20;
        clk = 0;
        #1 clk = 1;
        #500 clk = 0;
        
    end
    
endmodule

`timescale 1ns / 1ps

module transformcoder_tb;

    parameter BIT_LENGTH = 31;

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
        .QP(6'd5));
    
    initial begin
    
        enable = 1;
        reset = 0;
        //for (i = 0; i < 16; i = i +1) residuals[i] = $urandom%255;
        
        residuals[0] = 32'd0;
        residuals[1] = 32'd0;
        residuals[2] = 32'd0;
        residuals[3] = 32'd0;
        residuals[4] = 32'd0;
        residuals[5] = 32'd0;
        residuals[6] = 32'd0;
        residuals[7] = 32'd0;
        residuals[8] = 32'd10;
        residuals[9] = 32'd10;
        residuals[10] = 32'd10;
        residuals[11] = 32'd10;
        residuals[12] = 32'd10;
        residuals[13] = 32'd10;
        residuals[14] = 32'd10;
        residuals[15] = 32'd10;
        
        
        clk = 0;
        #5 clk = 1;
        forever #10 clk = ~clk;
        
    end
    
endmodule

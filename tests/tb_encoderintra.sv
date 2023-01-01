`timescale 1ns / 1ps

module tb_intraloop #(
    parameter WIDTH = 1280,
    parameter LENGTH = 720
);
    reg clk;
    reg reset;
    reg enable;
    
    wire done_luma4x4, done_chromab8x8, done_chromar8x8;
        
    encoder_intra uencoder_intra (
        .clk(clk), 
        .reset(reset), 
        .enable(enable), 
        .done_luma4x4(done_luma4x4), 
        .done_chromab8x8(done_chromab8x8), 
        .done_chromar8x8(done_chroma8x8));
        
    initial begin
    
        clk = 1;
        enable = 1;
        reset = 0;
                
        forever 
            #5 clk =~ clk;
    
    end
    
endmodule

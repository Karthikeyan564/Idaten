`timescale 1ns / 1ps

module encoder_intra (
    input clk,
    input reset,
    input enable,
    output reg done_luma4x4, done_chromab8x8, done_chromar8x8);
    
    wire fb_luma4x4_e1, fb_chromab8x8_e1, fb_chromar8x8_e1, fb_luma4x4_e2, fb_chromab8x8_e2, fb_chromar8x8_e2;
    reg first_luma4x4_e1, first_chromab8x8_e1, first_chromar8x8_e1, first_luma4x4_e2, first_chromab8x8_e2, first_chromar8x8_e2;
    
    reg [31:0] mbnumber_luma4x4_e1, mbnumber_chromab8x8_e1, mbnumber_chromar8x8_e1, mbnumber_luma4x4_e2, mbnumber_chromab8x8_e2, mbnumber_chromar8x8_e2;
    reg reconstructed_luma [1280*720 - 1: 0];
    reg reconstructed_chb [1280*720 - 1: 0];
    reg reconstructed_chr [280*720 - 1:0];
    
    
    intraloop intraloop_e1 (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .reconstructed_luma(reconstructed_luma),
        .reconstructed_chb(reconstructed_chb),
        .reconstructed_chr(reconstructed_chr),
        .mbnumber_luma4x4(mbnumber_luma4x4_e1),
        .mbnumber_chromab8x8(mbnumber_chromab8x8_e1),
        .mbnumber_chromar8x8(mbnumber_chromar8x8_e1),
        .fb_luma4x4(fb_luma4x4_e1),
        .fb_chromab8x8(fb_chromab8x8_e1),
        .fb_chromar8x8(fb_chromar8x8_e1));
        
    intraloop intraloop_e2 (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .reconstructed_luma(reconstructed_luma),
        .reconstructed_chb(reconstructed_chb),
        .reconstructed_chr(reconstructed_chr),
        .mbnumber_luma4x4(mbnumber_luma4x4_e2),
        .mbnumber_chromab8x8(mbnumber_chromab8x8_e2),
        .mbnumber_chromar8x8(mbnumber_chromar8x8_e2),
        .fb_luma4x4(fb_luma4x4_e2),
        .fb_chromab8x8(fb_chromab8x8_e2),
        .fb_chromar8x8(fb_chromar8x8_e2));
    
    initial begin
        first_luma4x4_e1 = 1;
        first_chromab8x8_e1 = 1;
        first_chromar8x8_e1 = 1;
        first_luma4x4_e2 = 1;
        first_chromab8x8_e2 = 1;
        first_chromar8x8_e2 = 1;
        
        mbnumber_luma4x4_e1 = 32'd0;
        mbnumber_luma4x4_e2 = {16'd0, 16'd4};
        mbnumber_chromab8x8_e1 = 32'd0;
        mbnumber_chromab8x8_e2 = {16'd0, 16'd8};
        mbnumber_chromar8x8_e1 = 32'd0;
        mbnumber_chromar8x8_e2 = {16'd0, 16'd8};
    end
    
    always @ (posedge clk)
    
        if (reset) begin
            first_luma4x4_e1 = 1;
            first_chromab8x8_e1 = 1;
            first_chromar8x8_e1 = 1;
            first_luma4x4_e2 = 1;
            first_chromab8x8_e2 = 1;
            first_chromar8x8_e2 = 1;
            
            mbnumber_luma4x4_e1 = 32'd0;
            mbnumber_luma4x4_e2 = {16'd0, 16'd4};
            mbnumber_chromab8x8_e1 = 32'd0;
            mbnumber_chromab8x8_e2 = {16'd0, 16'd8};
            mbnumber_chromar8x8_e1 = 32'd0;
            mbnumber_chromar8x8_e2 = {16'd0, 16'd8};
        end
    
    always @ (posedge fb_luma4x4_e1) begin
    
        if (first_luma4x4_e1) begin
            mbnumber_luma4x4_e1 = 32'h40000;
            first_luma4x4_e1 = 0;
        end
        else if (mbnumber_luma4x4_e1[15:0] == 16'h4fc) begin
            mbnumber_luma4x4_e1[15:0] = 16'd0;
            
            if (mbnumber_luma4x4_e1[31:16] >= 16'h2cc) done_luma4x4 = 1'd1;
            else mbnumber_luma4x4_e1[31:16] = mbnumber_luma4x4_e1[31:16] + 16'd8;
        end
        else mbnumber_luma4x4_e1[15:0] = mbnumber_luma4x4_e1[15:0] + 16'd4;
        
    end
    
    always @ (posedge fb_luma4x4_e2) begin
    
        if (first_luma4x4_e2) begin
            mbnumber_luma4x4_e2 = 32'h8;
            first_luma4x4_e2 = 0;
        end
        else if (mbnumber_luma4x4_e2[15:0] == 16'h4fc) begin 
            mbnumber_luma4x4_e2[15:0] = 16'd0;
            
            if (mbnumber_luma4x4_e2[31:16] >= 16'h2cc) done_luma4x4 = 1'd1;
            else mbnumber_luma4x4_e2[31:16] = mbnumber_luma4x4_e2[31:16] + 16'd8;
        end
        else mbnumber_luma4x4_e2[15:0] = mbnumber_luma4x4_e2[15:0] + 16'd4;
        
    end
    
    always @ (posedge fb_chromab8x8_e1) begin
    
        if (first_chromab8x8_e1) begin
            mbnumber_chromab8x8_e1 = 32'h80000;
            first_chromab8x8_e1 = 0;
        end
        else if (mbnumber_chromab8x8_e1[15:0] == 16'h4f8) begin
            mbnumber_chromab8x8_e1[15:0] = 16'd0;
            
            if (mbnumber_chromab8x8_e1[31:16] >= 12'h2c8) done_chromab8x8 = 1'd1;
            else mbnumber_chromab8x8_e1[31:16] = mbnumber_chromab8x8_e1[31:16] + 16'd16;
        end
        else mbnumber_chromab8x8_e1[15:0] = mbnumber_chromab8x8_e1[15:0] + 16'd8;
        
    end
    
    always @ (posedge fb_chromab8x8_e2) begin
    
        if (first_chromab8x8_e2) begin
            mbnumber_chromab8x8_e2 = 32'h16;
            first_chromab8x8_e2 = 0;
        end
        else if (mbnumber_chromab8x8_e2[15:0] == 16'h4f8) begin
            mbnumber_chromab8x8_e2[15:0] = 16'd0;
            
            if (mbnumber_chromab8x8_e2[31:16] >= 12'h2c8) done_chromab8x8 = 1'd1;
            else mbnumber_chromab8x8_e2[31:16] = mbnumber_chromab8x8_e2[31:16] + 16'd16;
        end
        else mbnumber_chromab8x8_e2[15:0] = mbnumber_chromab8x8_e2[15:0] + 16'd8;
        
    end
    
    always @ (posedge fb_chromar8x8_e1) begin
    
        if (first_chromar8x8_e1) begin
            mbnumber_chromar8x8_e1 = 32'h80000;
            first_chromar8x8_e1 = 0;
        end
        else if (mbnumber_chromar8x8_e1[15:0] == 16'h4f8) begin
            mbnumber_chromar8x8_e1[15:0] = 16'd0;
            
            if (mbnumber_chromar8x8_e1[31:16] >= 12'h2c8) done_chromar8x8 = 1'd1;
            else mbnumber_chromar8x8_e1[31:16] = mbnumber_chromar8x8_e1[31:16] + 16'd16;
        end
        else mbnumber_chromar8x8_e1[15:0] = mbnumber_chromar8x8_e1[15:0] + 16'd8;
        
    end
    
    always @ (posedge fb_chromar8x8_e2) begin
    
        if (first_chromar8x8_e2) begin
            mbnumber_chromar8x8_e2 = 32'h16;
            first_chromar8x8_e2 = 0;
        end
        else if (mbnumber_chromar8x8_e2[15:0] == 16'h4f8) begin
            mbnumber_chromar8x8_e2[15:0] = 16'd0;
            
            if (mbnumber_chromar8x8_e2[31:16] >= 12'h2c8) done_chromar8x8 = 1'd1;
            else mbnumber_chromar8x8_e2[31:16] = mbnumber_chromar8x8_e2[31:16] + 16'd16;
        end
        else mbnumber_chromar8x8_e2[15:0] = mbnumber_chromar8x8_e2[15:0] + 16'd8;
        
    end
    
endmodule

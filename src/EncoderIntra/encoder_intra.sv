`timescale 1ns / 1ps

module encoder_intra (
    input clk,
    input reset,
    input enable,
    output reg done_luma4x4, done_chromab8x8, done_chromar8x8);
    
    wire fbe1_luma4x4, fbe1_chromab8x8, fbe1_chromar8x8, fbe2_luma4x4, fbe2_chromab8x8, fbe2_chromar8x8;
    reg e1first_luma4x4, e1first_chromab8x8, e1first_chromar8x8, e2first_luma4x4, e2first_chromab8x8, e2first_chromar8x8;
    
    reg [31:0] mbnumber_luma4x4_e1, mbnumber_chromab8x8_e1, mbnumber_chromar8x8_e1, mbnumber_luma4x4_e2, mbnumber_chromab8x8_e2, mbnumber_chromar8x8_e2;
    
    always @ (posedge clk)
    
        if (reset) begin
            e1first_luma4x4 = 1;
            e1first_chromab8x8 = 1;
            e1first_chromar8x8 = 1;
            e2first_luma4x4 = 1;
            e2first_chromab8x8 = 1;
            e2first_chromar8x8 = 1;
            
            mbnumber_luma4x4_e1 = 32'd0;
            mbnumber_luma4x4_e2 = {16'd0, 16'd4};
            mbnumber_chromab8x8_e1 = 32'd0;
            mbnumber_chromab8x8_e2 = {16'd0, 16'd8};
            mbnumber_chromar8x8_e1 = 32'd0;
            mbnumber_chromar8x8_e2 = {16'd0, 16'd8};
        end
    
    always @ (posedge fbe1_luma4x4) begin
    
        if (e1first_luma4x4) begin
            mbnumber_luma4x4_e1 = 32'h40000;
            e1first_luma4x4 = 0;
        end
        else if (mbnumber_luma4x4_e1[15:0] == 16'h4fc) begin
            mbnumber_luma4x4_e1[15:0] = 16'd0;
            
            if (mbnumber_luma4x4_e1[31:16] >= 16'h2cc) done_luma4x4 = 1'd1;
            else mbnumber_luma4x4_e1[31:16] = mbnumber_luma4x4_e1[31:16] + 16'd8;
        end
        else mbnumber_luma4x4_e1[15:0] = mbnumber_luma4x4_e1[15:0] + 16'd4;
        
    end
    
    always @ (posedge fbe2_luma4x4) begin
    
        if (e2first_luma4x4) begin
            mbnumber_luma4x4_e2 = 32'h8;
            e2first_luma4x4 = 0;
        end
        else if (mbnumber_luma4x4_e2[15:0] == 16'h4fc) begin 
            mbnumber_luma4x4_e2[15:0] = 16'd0;
            
            if (mbnumber_luma4x4_e2[31:16] >= 16'h2cc) done_luma4x4 = 1'd1;
            else mbnumber_luma4x4_e2[31:16] = mbnumber_luma4x4_e2[31:16] + 16'd8;
        end
        else mbnumber_luma4x4_e2[15:0] = mbnumber_luma4x4_e2[15:0] + 16'd4;
        
    end
    
    always @ (posedge fbe1_chromab8x8) begin
    
        if (e1first_chromab8x8) begin
            mbnumber_chromab8x8_e1 = 32'h80000;
            e1first_chromab8x8 = 0;
        end
        else if (mbnumber_chromab8x8_e1[15:0] == 16'h4f8) begin
            mbnumber_chromab8x8_e1[15:0] = 16'd0;
            
            if (mbnumber_chromab8x8_e1[31:16] >= 12'h2c8) done_chromab8x8 = 1'd1;
            else mbnumber_chromab8x8_e1[31:16] = mbnumber_chromab8x8_e1[31:16] + 16'd16;
        end
        else mbnumber_chromab8x8_e1[15:0] = mbnumber_chromab8x8_e1[15:0] + 16'd8;
        
    end
    
    always @ (posedge fbe2_chromab8x8) begin
    
        if (e2first_chromab8x8) begin
            mbnumber_chromab8x8_e2 = 32'h16;
            e2first_chromab8x8 = 0;
        end
        else if (mbnumber_chromab8x8_e2[15:0] == 16'h4f8) begin
            mbnumber_chromab8x8_e2[15:0] = 16'd0;
            
            if (mbnumber_chromab8x8_e2[31:16] >= 12'h2c8) done_chromab8x8 = 1'd1;
            else mbnumber_chromab8x8_e2[31:16] = mbnumber_chromab8x8_e2[31:16] + 16'd16;
        end
        else mbnumber_chromab8x8_e2[15:0] = mbnumber_chromab8x8_e2[15:0] + 16'd8;
        
    end
    
    always @ (posedge fbe1_chromar8x8) begin
    
        if (e1first_chromar8x8) begin
            mbnumber_chromar8x8_e1 = 32'h80000;
            e1first_chromar8x8 = 0;
        end
        else if (mbnumber_chromar8x8_e1[15:0] == 16'h4f8) begin
            mbnumber_chromar8x8_e1[15:0] = 16'd0;
            
            if (mbnumber_chromar8x8_e1[31:16] >= 12'h2c8) done_chromar8x8 = 1'd1;
            else mbnumber_chromar8x8_e1[31:16] = mbnumber_chromar8x8_e1[31:16] + 16'd16;
        end
        else mbnumber_chromar8x8_e1[15:0] = mbnumber_chromar8x8_e1[15:0] + 16'd8;
        
    end
    
    always @ (posedge fbe2_chromar8x8) begin
    
        if (e2first_chromar8x8) begin
            mbnumber_chromar8x8_e2 = 32'h16;
            e2first_chromar8x8 = 0;
        end
        else if (mbnumber_chromar8x8_e2[15:0] == 16'h4f8) begin
            mbnumber_chromar8x8_e2[15:0] = 16'd0;
            
            if (mbnumber_chromar8x8_e2[31:16] >= 12'h2c8) done_chromar8x8 = 1'd1;
            else mbnumber_chromar8x8_e2[31:16] = mbnumber_chromar8x8_e2[31:16] + 16'd16;
        end
        else mbnumber_chromar8x8_e2[15:0] = mbnumber_chromar8x8_e2[15:0] + 16'd8;
        
    end
    
endmodule

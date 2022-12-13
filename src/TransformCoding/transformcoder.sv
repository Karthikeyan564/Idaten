`timescale 1ns / 1ps

module transformcoder #(
    parameter BIT_LENGTH = 15,
    parameter QP_BY_6 = 6,
    parameter QP_MOD_6 = 10)(
    input clk,
    input enable,
    input reset,
    input [BIT_LENGTH:0] residuals [15:0],
    input [5:0] QP,
    output reg [BIT_LENGTH:0] processedres [15:0]);
    
    wire [BIT_LENGTH:0] res2tran [15:0];
    wire [BIT_LENGTH:0] tran2quant [15:0];
    wire [BIT_LENGTH:0] quant2tran [15:0];
    wire [BIT_LENGTH:0] tran2res [15:0] = processedres;
    
    tran_4x4 #(.BIT_LENGTH(BIT_LENGTH)) utran_4x4 (
        .clk(clk),
        .enable(enable),
        .reset(reset),
        .residuals(residuals),
        .transformed(res2tran));
    
    quant_4x4 #(.BIT_LENGTH(BIT_LENGTH), .QP_BY_6(QP_BY_6), .QP_MOD_6(QP_MOD_6)) uquant_4x4 (
        .clk(clk),
        .enable(enable),
        .reset(reset),
        .mode(mode),
        .transformed(res2tran),
        .quantized(tran2quant),
        .QP(QP));
        
    invquant_4x4 #(.BIT_LENGTH(BIT_LENGTH), .QP_BY_6(QP_BY_6), .QP_MOD_6(QP_MOD_6)) uinvquant_4x4 (
        .clk(clk),
        .enable(enable),
        .reset(reset),
        .quantized(tran2quant),
        .transformed(quant2tran));
        
    invtran_4x4 #(.BIT_LENGTH(BIT_LENGTH)) uinvtran_4x4 (
        .clk(clk),
        .enable(enable),
        .reset(reset),
        .transformed(quant2tran),
        .residuals(tran2res));
    
endmodule

`timescale 1ns / 1ps

module tb_intrapred;
    reg clk;
    reg reset;
    reg enable;
    reg [12:0] mbnumber;
    
    intrapred dut(.clk(clk), .reset(reset), .enable(enable), .mbnumber(mbnumber));
    
    initial begin
    clk = 0;
    forever #5 clk =~ clk;
    end
    
    initial begin
    enable = 1;
    end
    
    initial begin
    mbnumber = 12'b000000000001;
    end
    
    
    
    
endmodule

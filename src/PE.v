module PE (
    input clk,
    input rst,
    input roll,
    input [7:0] a,
    input [7:0] b,
    output [7:0] c
);

    wire diff;
    assign diff = (a>b)?a-b:b-a;
    assign c = rst & diff;
    
endmodule
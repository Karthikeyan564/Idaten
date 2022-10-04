`timescale 1ns/1ps

module sad #(
    parameter NBLOCKS = 16
)(
    input [7:0] preds [15:0],
    output sadval);

    integer i, val = 0;

    for (i = 0; i < 16; i = i + 1) begin
       val = val + abs(preds[i]); 
    end

endmodule
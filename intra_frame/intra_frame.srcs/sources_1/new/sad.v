`timescale 1ns/1ps

module sad #(
    parameter NBLOCKS = 16
)(
    input [7:0] preds [15:0],
    output sadval);

    initial begin
        integer i, val = 0;

        for (i = 0; i < 16; i = i + 1) begin
            pred = preds[i];
            pred = pred < 0 ? pred * -1 : pred;
            val = val + pred;
        end
    end

endmodule
`timescale 1ns/1ps

module mindex (
    input sads[7:0];
    output optimal);

    initial begin

        integer i;

        assign min = 0;

        for (i = 1; i < 8; i = i + 1) begin

            if (sads[i] < sads[min]) min = i;

        end

        assign optimal = min;

    end

endmodule
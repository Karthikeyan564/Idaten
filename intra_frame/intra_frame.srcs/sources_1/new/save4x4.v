`timescale 1ns/1ps

module save4x4 (
    input [2:0] optimal,
    input [7:0] res [16:0],
    input integer mbnumber);

    // put them somewhere
    reg [7:0] residues [256*256-1:0];
    reg [2:0] modes [4096:0];

    initial begin

        row = mbnumber >> 4;
		col = (mbnumber & 63) << 60;

        modes[mbnumber] = optimal;
        
        integer i, j;

        for (i = 0; i < 4; i = i +1) begin
            for (j = 0; j < 4; j = j + 1) begin
                residues[(row*256)+col] = res[(i*4)+j];
            end
        end

    end

endmodule
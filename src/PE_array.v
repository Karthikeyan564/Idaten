module PE_array (
    input clk,
    input rst,
    input roll,
    input [7:0] cb [4:0][4:0],
    input [7:0] rb [4:0][4:0],
    output [7:0] sad84 [1:0] [3:0],
    output [7:0] sad48 [3:0] [1:0],
    output [7:0] sad88 [1:0] [1:0],
    output [7:0] sadF8 [1:0],
    output [7:0] sad8F[1:0],
    output [7:0] sadFF;
);

    wire [7:0] sadwr [4:0] [4:0];
    wire [7:0] sad84 [1:0] [3:0], sad48 [3:0] [1:0], sad88 [1:0] [1:0], sadF8 [1:0], sad8F[1:0], sadFF;
    genvar i,j;
    generate
        for(i=0;i<4;i++)
        begin
            for (j=0;j<4;j++)
            begin
            PE_block(clk,rst,roll,cb[i*4+3:i*4][j*4+3:j*4],rb[i*4+3:i*4][j*4+3:j*4],sad[i][j]);
            end
        end
        for(i=0;i<2;i++)
        begin
            for (j=0;j<4;j++)
            begin
                assign sad84[i][j]= sadwr[i*2][j] + sadwr[i*2+1][j];
            end
        end
        for(i=0;i<4;i++)
        begin
            for (j=0;j<2;j++)
            begin
                assign sad48[i][j]= sadwr[i][j*2] + sadwr[i][j*2+1];
            end
        end
        for(i=0;i<2;i++)
        begin
            for (j=0;j<2;j++)
            begin
                assign sad88[i][j]= sad84[i][j*2] + sad84[i][j*2+1];
            end
        end
        for (j=0;j<1;j+=2)
        begin
            assign sadF8[i]= sad88[i][j] + sad88[i+1][j];
        end
        for (i=0;i<1;i+=2)
        begin
            assign sad8F[i]= sad88[i][j] + sad88[i][j+1];
        end
        for (i=0;i<1;i+=2)
        begin
            assign sadFF[i]= sad8F[0] + sad8F[1];
        end
    endgenerate
    

endmodule
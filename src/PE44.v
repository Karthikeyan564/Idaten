module PE44 (
    input clk,
    input rst,
    input roll,
    input [7:0] cb [3:0][3:0],
    input [7:0] rb [3:0][3:0],
    output [7:0] sad
);
    genvar i,j;
    wire [7:0] rsad [3:0][3:0], wsad [3:0];
    generate
        for(i=0;i<4;i++)
        begin
            for (j=0;j<4;j++)
            begin
            PE(clk,rst,roll,cb[i][j],rb[i][j],rsad[i][j]);
            assign wsad[i] = rsad[i][0] + rsad[i][1] + rsad[i][2] + rsad[i][3];
            end
        end
        assign sad = wsad[0] + wsad[1] + wsad[2] + wsad[3];
    endgenerate
endmodule
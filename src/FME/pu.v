`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2022 00:43:51
// Design Name: 
// Module Name: pu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module oneDtrans(input [7:0] rc1, rc2, rc3, rc4, output reg [7:0] op1, op2, op3, op4);

wire [7:0] i1, i2, i3, i4;

assign i1 = rc1 + rc4;
assign i2 = rc2 + rc3;
assign i3 = rc2 - rc3;
assign i4 = rc1 - rc4;

always @ rc1
begin
op1 <= i1 + i2;
op2 <= i3 + i4;
op3 <= i1 - i2;
op4 <= i4 - i3;
end

endmodule

module pu(input [15:0][7:0] ref_pix, cur_pix, output [7:0] distortion);



endmodule
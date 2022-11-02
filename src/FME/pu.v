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

module oneDtrans1 (input [7:0] rc1, rc2, rc3, rc4, output reg [11:0] op1, op2, op3, op4);

wire [8:0] i1, i2, i3, i4;

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

module oneDtrans2 (input [11:0] rc1, rc2, rc3, rc4, output reg [14:0] op1, op2, op3, op4);

wire [12:0] i1, i2, i3, i4;

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

module transreg (input [11:0] up, right, out1, input [1:0] sel, output wire [11:0] left, down);

reg [11:0] inter;
assign left = inter;
assign down = inter;

always @ *
begin
case(sel)
         2'b00 : inter <= out1;  
         2'b01 : inter <= up;  
         2'b10 : inter <= right;  
         2'b11 : inter <= 0;
endcase
end

endmodule
 

module pu(input [15:0][7:0] ref_pix, cur_pix, output [7:0] distortion);

oneDtrans1 duta (.rc1(rc1),.rc2(rc2),.rc3(rc3),.rc4(rc4),.op1(op1),.op2(op2),.op3(op3),.op4(op4));
oneDtrans2 dutb (.rc1(rc11),.rc2(rc21),.rc3(rc31),.rc4(rc41),.op1(op11),.op2(op21),.op3(op31),.op4(op41));

wire [15:0][11:0] up, down, left, right;
wire [1:0] sel;

genvar i;
generate
    for (i=0; i<16; i++) begin
    transreg dut1 (.up(up[i]), .down(down[i]), .left(left[i]), .right(right[i]), .sel(sel), .out1(left[i]));
    end
endgenerate


    
endmodule
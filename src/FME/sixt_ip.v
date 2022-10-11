`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2022 11:36:18
// Design Name: 
// Module Name: sixt_ip
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


module sixt_ip(input clk, input [7:0] a,b,c,d,e,f, output reg [7:0] half);

reg [7:0] t1,t2,t3,t4,t5,t6;
wire [7:0] i1, i2, i3, i4, i5, i6, i7;

assign i1 = a+f;
assign i2 = b+e;
assign i3 = c+d;
assign i4 = i2 - (i3 << 2);

always @ *

begin

t1 <= i1;
t2 <= i4;
t3 <= 16;

end

always @ (posedge clk)
begin

assign i5 = t1; 
assign i6 = t2; 
assign i7 = i5 - i6;
assign i8 = i7 - (i6 << 2);


end

endmodule

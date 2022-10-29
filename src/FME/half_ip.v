`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2022 21:39:31
// Design Name: 
// Module Name: half_ip
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

/* int_pix_ind - address of the centre integer pixel
 half - interpolated value*/

module half_ip(input clk, input [7:0] int_pix_ind, input [3:0] cand, output reg [47:0] pixels);

reg [7:0] lut [255:0];
wire [47:0] pixels_int;
reg [7:0] half_int [11:0];

wire [7:0] temp_address;

initial begin
    $readmemh("mbvalues_ref.mem" ,lut); 
end

six_tf dut1 (.clk(clk), .a(pixels_int[7:0]), .b(pixels_int[15:8]), .c(pixels_int[23:16]), .d(pixels_int[31:24]), .e(pixels_int[39:32]), .f(pixels_int[47:40]), .half(half_int[0]));    
six_tf dut2 (.clk(clk), .a(pixels_int[7:0]), .b(pixels_int[15:8]), .c(pixels_int[23:16]), .d(pixels_int[31:24]), .e(pixels_int[39:32]), .f(pixels_int[47:40]), .half(half_int[1]));
six_tf dut3 (.clk(clk), .a(pixels_int[7:0]), .b(pixels_int[15:8]), .c(pixels_int[23:16]), .d(pixels_int[31:24]), .e(pixels_int[39:32]), .f(pixels_int[47:40]), .half(half_int[2]));
six_tf dut4 (.clk(clk), .a(pixels_int[7:0]), .b(pixels_int[15:8]), .c(pixels_int[23:16]), .d(pixels_int[31:24]), .e(pixels_int[39:32]), .f(pixels_int[47:40]), .half(half_int[3]));
six_tf dut5 (.clk(clk), .a(pixels_int[7:0]), .b(pixels_int[15:8]), .c(pixels_int[23:16]), .d(pixels_int[31:24]), .e(pixels_int[39:32]), .f(pixels_int[47:40]), .half(half_int[4]));
six_tf dut6 (.clk(clk), .a(pixels_int[7:0]), .b(pixels_int[15:8]), .c(pixels_int[23:16]), .d(pixels_int[31:24]), .e(pixels_int[39:32]), .f(pixels_int[47:40]), .half(half_int[5]));
six_tf dut7 (.clk(clk), .a(pixels_int[7:0]), .b(pixels_int[15:8]), .c(pixels_int[23:16]), .d(pixels_int[31:24]), .e(pixels_int[39:32]), .f(pixels_int[47:40]), .half(half_int[6]));    
six_tf dut8 (.clk(clk), .a(pixels_int[7:0]), .b(pixels_int[15:8]), .c(pixels_int[23:16]), .d(pixels_int[31:24]), .e(pixels_int[39:32]), .f(pixels_int[47:40]), .half(half_int[7]));
six_tf dut9 (.clk(clk), .a(pixels_int[7:0]), .b(pixels_int[15:8]), .c(pixels_int[23:16]), .d(pixels_int[31:24]), .e(pixels_int[39:32]), .f(pixels_int[47:40]), .half(half_int[8]));
six_tf dut10 (.clk(clk), .a(pixels_int[7:0]), .b(pixels_int[15:8]), .c(pixels_int[23:16]), .d(pixels_int[31:24]), .e(pixels_int[39:32]), .f(pixels_int[47:40]), .half(half_int[9]));
six_tf dut11 (.clk(clk), .a(pixels_int[7:0]), .b(pixels_int[15:8]), .c(pixels_int[23:16]), .d(pixels_int[31:24]), .e(pixels_int[39:32]), .f(pixels_int[47:40]), .half(half_int[10]));
six_tf dut12 (.clk(clk), .a(pixels_int[7:0]), .b(pixels_int[15:8]), .c(pixels_int[23:16]), .d(pixels_int[31:24]), .e(pixels_int[39:32]), .f(pixels_int[47:40]), .half(half_int[11]));

always @ int_pix_ind


begin

half_int[0] <= 

end

always @ (cand)
case (cand)

4'b0001: begin pixels [7:0] <= lut [int_pix_ind]; 
               pixels [15:8] <= lut [int_pix_ind -16];
               pixels [23:16] <= lut [int_pix_ind -32];
               pixels [31:24] <= lut [int_pix_ind -48];
               pixels [39:32] <= lut [int_pix_ind +16];
               pixels [47:40] <= lut [int_pix_ind +32];
               end
4'b0111: begin pixels [7:0] <= lut [int_pix_ind]; 
               pixels [15:8] <= lut [int_pix_ind -16];
               pixels [23:16] <= lut [int_pix_ind -32];
               pixels [31:24] <= lut [int_pix_ind + 48];
               pixels [39:32] <= lut [int_pix_ind +16];
               pixels [47:40] <= lut [int_pix_ind +32];
               end
4'b0011: begin pixels [7:0] <= lut [int_pix_ind]; 
               pixels [15:8] <= lut [int_pix_ind -1];
               pixels [23:16] <= lut [int_pix_ind -2];
               pixels [31:24] <= lut [int_pix_ind -3];
               pixels [39:32] <= lut [int_pix_ind +1];
               pixels [47:40] <= lut [int_pix_ind +2];
               end    
4'b0101: begin pixels [7:0] <= lut [int_pix_ind]; 
               pixels [15:8] <= lut [int_pix_ind -1];
               pixels [23:16] <= lut [int_pix_ind -2];
               pixels [31:24] <= lut [int_pix_ind +3];
               pixels [39:32] <= lut [int_pix_ind +1];
               pixels [47:40] <= lut [int_pix_ind +2];
               end  
4'b0000: begin 

endcase
endmodule

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
 
module counter(cnt,clk,rst,en);
input clk,rst,en;
output [2:0]cnt;

reg [2:0]cnt;
wire [2:0]next_cnt;

assign next_cnt = cnt + 1'b1;  //Just increment by 1

always @ (posedge clk or negedge rst)   
begin
 if(!rst & en)
 begin
 cnt <= 3'b0;
 end
 else if (en)
 begin
 cnt <= next_cnt;
 end
end

endmodule 
 

module half_ip(input clk, rst, input [7:0] int_pix_ind, input [3:0] cand, output reg [47:0] pixels);

reg [7:0] lut [255:0];
reg [47:0] pixels_int;
reg [7:0] half_int [11:0];
reg [7:0] temp_address;
wire [2:0] i;
wire en;

initial begin
    $readmemh("mbvalues_ref.mem" ,lut); 
end

six_tf dut1 (.clk(clk), .a(pixels_int[7:0]), .b(pixels_int[15:8]), .c(pixels_int[23:16]), .d(pixels_int[31:24]), .e(pixels_int[39:32]), .f(pixels_int[47:40]), .half(half_int[0]));    
counter dut2 (.cnt(i), .clk(clk), .rst(rst), .en(en));

always @ i
begin

case(i)
 3'b000 : temp_address <= int_pix_ind;
 3'b001 : temp_address <= int_pix_ind -48;
 3'b010 : temp_address <= int_pix_ind -32;
 3'b011 : temp_address <= int_pix_ind -16;
 3'b100 : temp_address <= int_pix_ind +16;
 3'b101 : temp_address <= int_pix_ind +32;
 default : en <= 1'b0;
endcase


end

always @ temp_address
begin

pixels_int [7:0] <= lut[temp_address - 3];
pixels_int [15:8] <= lut[temp_address - 2];
pixels_int [23:16] <= lut[temp_address - 1];
pixels_int [31:24] <= lut[temp_address];
pixels_int [39:32] <= lut[temp_address+1];
pixels_int [47:40] <= lut[temp_address+2];

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

endcase
endmodule

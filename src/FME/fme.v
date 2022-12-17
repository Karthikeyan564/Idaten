`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2022 00:44:48
// Design Name: 
// Module Name: fme
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


module fme(input clk, rst, input[7:0] pix_pos, output [7:0] quat_val);

reg [8:0][7:0] half, quat ;
reg rst1, rst2;
wire [3:0] best;
wire quat_en;
wire [8:0][7:0] int_pix;

half_ip dutq (.clk(clk), .rst(rst), .int_ind_pix(pix_pos), .half(half));
satd_gen dutw (.clk(clk), .rst1(rst1), .half_quat(half), .cur_pix(cur_pix), .best(best));
quat_ip dute (.en(quat_en), .int_pix(int_pix), .half_cand(half), .best(best), .quat(quat));
satd_gen dutr (.clk(clk), .rst1(rst2), .half_quat(quat), .cur_pix(cur_pix), .best(best));

//state machine to feed signal

endmodule

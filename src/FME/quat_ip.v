`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2022 00:43:28
// Design Name: 
// Module Name: quat_ip
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


module quat_ip(input en, input [8:0][7:0] int_pix, half_cand, input [7:0][7:0] half_pix, input [3:0] best, output reg [8:0][7:0] quat);

reg [8:0][7:0] x, y;

genvar i;
generate
    for (i=0; i<4; i++) begin
        two_tf duty (.x(x[i]), .y(y[i]), .quat(quat[i]));
    end
endgenerate

generate
    for (i=5; i<9; i++) begin
        two_tf duty (.x(x[i]), .y(y[i]), .quat(quat[i]));
    end
endgenerate        

always @ (posedge en)
begin

case(best)
4'b0000: begin 
         x[0] <= int_pix[0]; y[0]<=half_cand[0]; 
         x[1] <= half_pix[0]; y[0]<=half_cand[0]; 
         x[2] <= int_pix[1]; y[0]<=half_cand[0]; 
         x[3] <= half_pix[7]; y[0]<=half_cand[0]; 
         quat[4] <= half_cand[0]; 
         x[5] <= half_cand[1]; y[0]<=half_cand[0]; 
         x[6] <= int_pix[3]; y[0]<=half_cand[0]; 
         x[7] <= half_cand[3]; y[0]<=half_cand[0]; 
         x[8] <= int_pix[4]; y[0]<=half_cand[0]; 
         end

4'b0001:begin 
         x[0] <= int_pix[0]; y[0]<=half_cand[0]; 
         x[1] <= half_pix[0]; y[0]<=half_cand[0]; 
         x[2] <= int_pix[1]; y[0]<=half_cand[0]; 
         x[3] <= half_pix[7]; y[0]<=half_cand[0]; 
         quat[4] <= half_cand[0];
         x[5] <= half_cand[1]; y[0]<=half_cand[0]; 
         x[6] <= int_pix[3]; y[0]<=half_cand[0]; 
         x[7] <= half_cand[3]; y[0]<=half_cand[0]; 
         x[8] <= int_pix[4]; y[0]<=half_cand[0]; 
         end
4'b0010:begin 
         x[0] <= int_pix[0]; y[0]<=half_cand[0]; 
         x[1] <= half_pix[0]; y[0]<=half_cand[0]; 
         x[2] <= int_pix[1]; y[0]<=half_cand[0]; 
         x[3] <= half_pix[7]; y[0]<=half_cand[0]; 
         quat[4] <= half_cand[0]; 
         x[5] <= half_cand[1]; y[0]<=half_cand[0]; 
         x[6] <= int_pix[3]; y[0]<=half_cand[0]; 
         x[7] <= half_cand[3]; y[0]<=half_cand[0]; 
         x[8] <= int_pix[4]; y[0]<=half_cand[0]; 
         end
4'b0011:begin 
         x[0] <= int_pix[0]; y[0]<=half_cand[0]; 
         x[1] <= half_pix[0]; y[0]<=half_cand[0]; 
         x[2] <= int_pix[1]; y[0]<=half_cand[0]; 
         x[3] <= half_pix[7]; y[0]<=half_cand[0]; 
         quat[4] <= half_cand[0]; 
         x[5] <= half_cand[1]; y[0]<=half_cand[0]; 
         x[6] <= int_pix[3]; y[0]<=half_cand[0]; 
         x[7] <= half_cand[3]; y[0]<=half_cand[0]; 
         x[8] <= int_pix[4]; y[0]<=half_cand[0]; 
         end
4'b0100:begin 
         x[0] <= int_pix[0]; y[0]<=half_cand[0]; 
         x[1] <= half_pix[0]; y[0]<=half_cand[0]; 
         x[2] <= int_pix[1]; y[0]<=half_cand[0]; 
         x[3] <= half_pix[7]; y[0]<=half_cand[0]; 
         quat[4] <= half_cand[0]; 
         x[5] <= half_cand[1]; y[0]<=half_cand[0]; 
         x[6] <= int_pix[3]; y[0]<=half_cand[0]; 
         x[7] <= half_cand[3]; y[0]<=half_cand[0]; 
         x[8] <= int_pix[4]; y[0]<=half_cand[0]; 
         end
4'b0101:begin 
         x[0] <= int_pix[0]; y[0]<=half_cand[0]; 
         x[1] <= half_pix[0]; y[0]<=half_cand[0]; 
         x[2] <= int_pix[1]; y[0]<=half_cand[0]; 
         x[3] <= half_pix[7]; y[0]<=half_cand[0]; 
         quat[4] <= half_cand[0]; 
         x[5] <= half_cand[1]; y[0]<=half_cand[0]; 
         x[6] <= int_pix[3]; y[0]<=half_cand[0]; 
         x[7] <= half_cand[3]; y[0]<=half_cand[0]; 
         x[8] <= int_pix[4]; y[0]<=half_cand[0]; 
         end
4'b0110:begin 
         x[0] <= int_pix[0]; y[0]<=half_cand[0]; 
         x[1] <= half_pix[0]; y[0]<=half_cand[0]; 
         x[2] <= int_pix[1]; y[0]<=half_cand[0]; 
         x[3] <= half_pix[7]; y[0]<=half_cand[0]; 
         quat[4] <= half_cand[0]; 
         x[5] <= half_cand[1]; y[0]<=half_cand[0]; 
         x[6] <= int_pix[3]; y[0]<=half_cand[0]; 
         x[7] <= half_cand[3]; y[0]<=half_cand[0]; 
         x[8] <= int_pix[4]; y[0]<=half_cand[0]; 
         end
4'b0111:begin 
         x[0] <= int_pix[0]; y[0]<=half_cand[0]; 
         x[1] <= half_pix[0]; y[0]<=half_cand[0]; 
         x[2] <= int_pix[1]; y[0]<=half_cand[0]; 
         x[3] <= half_pix[7]; y[0]<=half_cand[0]; 
         quat[4] <= half_cand[0]; 
         x[5] <= half_cand[1]; y[0]<=half_cand[0]; 
         x[6] <= int_pix[3]; y[0]<=half_cand[0]; 
         x[7] <= half_cand[3]; y[0]<=half_cand[0]; 
         x[8] <= int_pix[4]; y[0]<=half_cand[0]; 
         end
4'b1000:begin 
         x[0] <= int_pix[0]; y[0]<=half_cand[0]; 
         x[1] <= half_pix[0]; y[0]<=half_cand[0]; 
         x[2] <= int_pix[1]; y[0]<=half_cand[0]; 
         x[3] <= half_pix[7]; y[0]<=half_cand[0]; 
         quat[4] <= half_cand[0]; 
         x[5] <= half_cand[1]; y[0]<=half_cand[0]; 
         x[6] <= int_pix[3]; y[0]<=half_cand[0]; 
         x[7] <= half_cand[3]; y[0]<=half_cand[0]; 
         x[8] <= int_pix[4]; y[0]<=half_cand[0]; 
         end
default:begin 
         x[0] <= int_pix[0]; y[0]<=half_cand[0]; 
         x[1] <= half_pix[0]; y[0]<=half_cand[0]; 
         x[2] <= int_pix[1]; y[0]<=half_cand[0]; 
         x[3] <= half_pix[7]; y[0]<=half_cand[0]; 
         quat[4] <= half_cand[0]; 
         x[5] <= half_cand[1]; y[0]<=half_cand[0]; 
         x[6] <= int_pix[3]; y[0]<=half_cand[0]; 
         x[7] <= half_cand[3]; y[0]<=half_cand[0]; 
         x[8] <= int_pix[4]; y[0]<=half_cand[0]; 
         end
endcase

end

endmodule

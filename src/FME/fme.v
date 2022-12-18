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


module fme(input clk, rst, input[7:0] pix_pos, output reg [7:0] quat_val);

reg [8:0][7:0] half, quat ;
reg rst1, rst2, rst3;
wire [3:0] best;
reg quat_en;
wire [8:0][7:0] int_pix;
reg [7:0] lut [255:0];
reg [3:0] state;
wire done, done1, done2;
parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8;

initial begin
    $readmemh("mbvalues_ref.mem" ,lut); 
end


half_ip dutq (.clk(clk), .rst(rst1), .int_ind_pix(pix_pos), .lut(lut), .half(half), .done(done));
satd_gen dutw (.clk(clk), .rst1(rst2), .half_quat(half), .cur_pix(cur_pix), .best(best), .done(done1));
quat_ip dute (.en(quat_en), .int_pix(int_pix), .half_cand(half), .best(best), .quat(quat));
satd_gen dutr (.clk(clk), .rst1(rst3), .half_quat(quat), .cur_pix(cur_pix), .best(best), .done(done2));

always @ (posedge clk or negedge rst)
begin
if (!rst) begin
case(state)
S0: begin rst1 <= 1; rst2 <= 1; rst3 <= 1;  state<= S1;end
S1: begin rst1 <= 0; state <= S2;end
S2: begin if(done) begin rst1 <= 1; rst2 <= 0; state <= S3; end end
S3: begin if (done1) begin quat_en <= 1; state <= S4; end end
S4: begin quat_en <= 0; rst3 <= 0; state <= S5; end
S5: begin if(done2) begin rst3 <= 1; state <= S6; quat_val <= quat[best];end end
S6: begin state<= S6; end
default: begin state<=S6; end
endcase
end

end


endmodule

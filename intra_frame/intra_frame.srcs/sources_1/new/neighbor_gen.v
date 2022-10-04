`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2022 11:52:35
// Design Name: 
// Module Name: neighbor_gen
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


module neighbor_gen(
    input clk,
    input reset,
    input start_pixel,
    output reg[7:0] A,
    output reg[7:0] B,
    output reg[7:0] C,
    output reg[7:0] D,
    output reg[7:0] E,
    output reg[7:0] F,
    output reg[7:0] G,
    output reg[7:0] H,
    output reg[7:0] I,
    output reg[7:0] J,
    output reg[7:0] K,
    output reg[7:0] L,  
    output reg[7:0] M  
 );
    
    reg [1920*1080 - 1: 0] img_arr [0:7];
    initial begin
    $readmemh("filename.hex",img_arr);
    end
    
    always @(posedge clk, posedge reset, start_pixel) begin
        A <= img_arr[start_pixel-1920*3];
        B <= img_arr[start_pixel-1920*3 + 3];
        C <= img_arr[start_pixel-1920*3 + 6];
        D <= img_arr[start_pixel-1920*3 + 9];
        E <= img_arr[start_pixel-1920*3 + 12];
        F <= img_arr[start_pixel-1920*3 + 15];
        G <= img_arr[start_pixel-1920*3 + 18];
        H <= img_arr[start_pixel-1920*3 + 21];
        I <= img_arr[start_pixel+1920*3 - 3];
        J <= img_arr[start_pixel+1920*6 - 3];
        K <= img_arr[start_pixel+1920*9 - 3];
        L <= img_arr[start_pixel+1920*12 - 3];
        M <= img_arr[start_pixel-1920*3 -3];
    end
        
         //Figure counter logic.
         //Multiple corner cases.
endmodule

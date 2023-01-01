`timescale 1ns/1ps

module saver #(
    parameter BIT_LENGTH = 31,
    parameter WIDTH = 1280,
    parameter LENGTH = 720,
    parameter MB_SIZE_L = 8,
    parameter MB_SIZE_W = 8)(
    input clk,
    input reset,
    input enable,
    input [31:0] mbnumber,
    input signed [7:0] reconst [(MB_SIZE_L*MB_SIZE_W)-1:0],
    output reg fb);

    reg [4:0] i, j;
    
    reg [7:0] reconstructed [(LENGTH*WIDTH)-1:0];
    
    int resi;
    initial for (resi = 0; resi < (LENGTH*WIDTH); resi = resi + 1) reconstructed[resi] = 8'd0;
    
    reg [12:0] row;
    reg [12:0] col;

    always @(posedge clk) begin
        
        if (enable) begin

            row = mbnumber[31:16];
            col = mbnumber[15:0];

            for (i = 0; i < MB_SIZE_L; i = i +1) 
                for (j = 0; j < MB_SIZE_W; j = j + 1) 
                    reconstructed[((row+13'(i))*LENGTH)+(col+13'(j))] = reconst[(i*MB_SIZE_L)+j]; 
            
            fb = 1;
                    
        end

    end
    
    always @ (negedge clk) if (fb) fb = 0;

endmodule
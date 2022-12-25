`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.12.2022 07:24:37
// Design Name: 
// Module Name: extractor_4x4block
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


module extractor_4x4block(
    
    input clk,
    input enable,
    input [255:0] block_16x16 [7:0], //get the 16x16 block
    output reg [15:0] block_4x4 [7:0]
    );
    
    reg [4:0] i,j,k;
    reg block_count;
    reg [4:0] start;
    
    initial begin
        start = 0;
        block_count = 0;
    end
    
    always @(posedge clk) begin
        if (enable) begin
            //extract a block from the starting position
            block_4x4[0] = block_16x16[start];
            block_4x4[1] = block_16x16[start + 1];
            block_4x4[2] = block_16x16[start + 2];
            block_4x4[3] = block_16x16[start + 3];
            block_4x4[4] = block_16x16[start + 16];
            block_4x4[5] = block_16x16[start + 17];
            block_4x4[6] = block_16x16[start + 18];
            block_4x4[7] = block_16x16[start + 19];
            block_4x4[8] = block_16x16[start + 32];
            block_4x4[9] = block_16x16[start + 33];
            block_4x4[10] = block_16x16[start + 34];
            block_4x4[11] = block_16x16[start + 35];
            block_4x4[12] = block_16x16[start + 48];
            block_4x4[13] = block_16x16[start + 49];
            block_4x4[14] = block_16x16[start + 50];
            block_4x4[15] = block_16x16[start + 51];
            
            block_count = block_count+1;
            
            if(block_count == 0)
                start = 0;
 
            else if(block_count == 1)
                start = 4;

            else if(block_count == 2)
                start = 8;

            else if(block_count == 3)
                start = 12;
                
            else if(block_count == 4)
                start = 64;

            else if(block_count == 5)
                start = 68;
            
            else if(block_count == 6)
                start = 72;
                
            else if(block_count == 7)
                start = 76;
                
            else if(block_count == 8)
                start = 128;

            else if(block_count == 9)
                start = 132;
                
            else if(block_count == 10)
                start = 136;
                
            else if(block_count == 11)
                start = 140;

            else if(block_count == 12)
                start = 192;
            
            else if(block_count == 13)
                start = 196;
                
            else if(block_count == 14)
                start = 200;
                
            else if(block_count == 15)
                start = 204;
            
            // change start for the next clock cycle.
            
        end
            
        
    end
endmodule

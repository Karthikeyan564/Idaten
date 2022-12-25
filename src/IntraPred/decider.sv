`timescale 1ns / 1ps

module decider #(
    parameter WIDTH = 1280,
    parameter LENGTH = 720,
    parameter MB_SIZE_L = 8,
    parameter MB_SIZE_W = 8)(
    input clk,
    input reset,
    input enable,
    input [7:0] sads_luma4x4 [15:0][7:0], sads_luma16x16 [2:0], sads_chromab8x8 [2:0], sads_chromar8x8 [2:0],
    output reg [2:0] mode_luma4x4, mode_luma16x16, mode_chromab8x8, mode_chromar8x8);
    
    // Counters
    reg [5:0] i;
    
    reg [10:0] accumulated_sads_luma4x4 [7:0];
    reg [2:0] min_luma4x4, min_luma16x16, min_chromab8x8, min_chromar8x8;
    
    
    always @ (posedge clk) begin
    
        if (enable) begin
            
            case (MB_SIZE_L)
            
                32'd8: begin
                
                     min_chromab8x8 = 0;
                     min_chromar8x8 = 0;
            
                     for (i = 1; i < 3; i = i + 1) begin
                         if (sads_chromab8x8[2'(i)] < sads_chromab8x8[2'(min_chromab8x8)]) min_chromab8x8 = 3'(i);
                         if (sads_chromar8x8[2'(i)] < sads_chromar8x8[2'(min_chromar8x8)]) min_chromar8x8 = 3'(i);
                     end 
                
                end
                
                default: begin
                    
                    for (i = 0; i < 16; i = i + 1) begin
                        accumulated_sads_luma4x4[0] = accumulated_sads_luma4x4[0] + sads_luma4x4[i][0];
                        accumulated_sads_luma4x4[1] = accumulated_sads_luma4x4[1] + sads_luma4x4[i][1];
                        accumulated_sads_luma4x4[2] = accumulated_sads_luma4x4[2] + sads_luma4x4[i][2];
                        accumulated_sads_luma4x4[3] = accumulated_sads_luma4x4[3] + sads_luma4x4[i][3];
                        accumulated_sads_luma4x4[4] = accumulated_sads_luma4x4[4] + sads_luma4x4[i][4];
                        accumulated_sads_luma4x4[5] = accumulated_sads_luma4x4[5] + sads_luma4x4[i][5];
                        accumulated_sads_luma4x4[6] = accumulated_sads_luma4x4[6] + sads_luma4x4[i][6];
                        accumulated_sads_luma4x4[7] = accumulated_sads_luma4x4[7] + sads_luma4x4[i][7]; 
                    end
                    
                    min_luma16x16 = 0;
                    
                    for (i = 1; i < 3; i = i + 1) 
                         if (sads_luma16x16[2'(i)] < sads_luma16x16[2'(min_luma16x16)]) min_luma16x16 = 3'(i);
                
                    min_luma4x4 = 0;
                
                    for (i = 1; i < 3; i = i + 1) 
                         if (accumulated_sads_luma4x4[2'(i)] < accumulated_sads_luma4x4[2'(min_luma4x4)]) min_luma4x4 = 3'(i);
                    
                
                    if (sads_luma16x16[2'(min_luma16x16)] > accumulated_sads_luma4x4[2'(min_luma4x4)]) 
                        min_luma16x16 = 3'd3;
                    
                
                end
            
            endcase
            
        end    
    
    end
    
endmodule

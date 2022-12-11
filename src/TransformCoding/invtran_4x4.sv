`timescale 1ns / 1ps

module invtran_4x4 #(
    parameter BIT_LENGTH = 15)(
    input clk,
    input enable,
    input reset,
    input [BIT_LENGTH : 0] transformed [15:0],
    output reg [BIT_LENGTH : 0] residuals [15:0]);
    
    reg [3:0] i, j;
    reg [BIT_LENGTH:0] intermediate [15:0];
    
    
    always @ (posedge clk) begin
    
        for ( i = 0; i < 4; i = i + 1) begin
            intermediate[0+i] = transformed[0+i] + transformed[4+i] + transformed[8+i] + (transformed[12+i]>>1);
            intermediate[4+i] = transformed[0+i] + (transformed[4+i]>>1) - transformed[8+i] - transformed[12+i];
            intermediate[8+i] = transformed[0+i] - (transformed[4+i]>>1) - transformed[8+i] + transformed[12+i];
            intermediate[12+i] = transformed[0+i] - transformed[4+i] + transformed[8+i] - (transformed[12+i]>>1);
        end
        
        for ( j = 0; j < 4; j = j + 1) begin
            residuals[0+j] = intermediate[0+j] + intermediate[1+j] + intermediate[2+j] + (intermediate[3+j]>>1);
            residuals[1+j] = intermediate[0+j] + (intermediate[1+j]>>1) - intermediate[2+j] - intermediate[3+j];
            residuals[2+j] = intermediate[0+j] - (intermediate[1+j]>>1) - intermediate[2+j] + intermediate[3+j];
            residuals[3+j] = intermediate[0+j] - intermediate[1+j] + intermediate[2+j] - (intermediate[3+j]>>1);
        end
      
    end
    
endmodule

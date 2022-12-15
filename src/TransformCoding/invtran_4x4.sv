`timescale 1ns / 1ps

module invtran_4x4 #(
    parameter BIT_LENGTH = 15)(
    input clk,
    input enable,
    input reset,
    input [BIT_LENGTH : 0] transformed [15:0],
    output reg [BIT_LENGTH : 0] residuals [15:0]);
    
    reg [3:0] i, j, k;
    reg [BIT_LENGTH:0] intermediate [15:0];
    
    
    always @ (posedge clk) begin
    
        for ( i = 0; i < 4; i = i + 1) begin
            intermediate[0+i] = transformed[0+i] + transformed[4+i] + transformed[8+i] + (transformed[12+i]>>1);
            intermediate[4+i] = transformed[0+i] + (transformed[4+i]>>1) - transformed[8+i] - transformed[12+i];
            intermediate[8+i] = transformed[0+i] - (transformed[4+i]>>1) - transformed[8+i] + transformed[12+i];
            intermediate[12+i] = transformed[0+i] - transformed[4+i] + transformed[8+i] - (transformed[12+i]>>1);
        end
        for(k=0; k<16; k++) begin
            if(intermediate[k][31] == 1) 
                intermediate[k] = -intermediate[k];
        end
        for ( j = 0; j < 4; j = j + 1) begin
            residuals[j*4 + 0] = intermediate[0+j] + intermediate[1+j] + intermediate[2+j] + (intermediate[3+j]>>1);
            residuals[j*4 + 1] = intermediate[0+j] + (intermediate[1+j]>>1) - intermediate[2+j] - intermediate[3+j];
            residuals[j*4 + 2] = intermediate[0+j] - (intermediate[1+j]>>1) - intermediate[2+j] + intermediate[3+j];
            residuals[j*4 + 3] = intermediate[0+j] - intermediate[1+j] + intermediate[2+j] - (intermediate[3+j]>>1);
        end
        
        for(k=0; k<16; k++) begin
            if(residuals[k][31] == 1) 
                residuals[k] = -residuals[k];
        end
      
    end
    
endmodule

`timescale 1ns / 1ps

module quant_4x4 #(
    parameter BIT_LENGTH = 15,
    parameter QP_BY_6 = 3,
    parameter QP_MOD_6 = 3,
    parameter QBITS = QP_BY_6 + 15,
    parameter finter = 10,
    parameter fintra = 11)(
    input clk,
    input enable,
    input reset,
    input mode,
    input [BIT_LENGTH : 0] transformed [15:0],
    output reg [BIT_LENGTH : 0] quantized [15:0]);
    
    reg [4:0] i;
    reg [13:0] multfactor;
    
    always @ (posedge clk) begin
    
        for (i = 0; i < 16; i = i+1) begin
        
            if (i == 0 || i == 2 || i == 8 || i == 10) 
                case (QP_MOD_6)
                    3'b000: multfactor <= 13107;
                    3'b001: multfactor <= 11916;
                    3'b010: multfactor <= 10082;
                    3'b011: multfactor <= 9362;
                    3'b100: multfactor <= 8192;
                    3'b101: multfactor <= 7282;
                endcase 
            else if (i == 5 || i == 7 || i == 12 || i == 15) 
                case (QP_MOD_6)
                    3'b000: multfactor <= 5243;
                    3'b001: multfactor <= 4660;
                    3'b010: multfactor <= 4194;
                    3'b011: multfactor <= 3647;
                    3'b100: multfactor <= 3355;
                    3'b101: multfactor <= 2893;
                endcase 
            else 
                case (QP_MOD_6)
                    3'b000: multfactor <= 8066;
                    3'b001: multfactor <= 7490;
                    3'b010: multfactor <= 6554;
                    3'b011: multfactor <= 5825;
                    3'b100: multfactor <= 5243;
                    3'b101: multfactor <= 4559;
                endcase 
                
            // Implement Sign
            quantized[i] <= mode ? (((transformed[i] * multfactor) + fintra) << QBITS) : (((transformed[i] * multfactor) + finter) << QBITS);
            
        end     
       
    end
    
endmodule

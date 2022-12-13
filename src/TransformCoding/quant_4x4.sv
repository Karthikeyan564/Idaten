`timescale 1ns / 1ps

module quant_4x4 #(
    parameter BIT_LENGTH = 15,
    //parameter QP_BY_6 = 3,
    //parameter QP_MOD_6 = 3,
    //parameter QBITS = QP_BY_6 + 15,
    parameter finter = 10,
    parameter fintra = 11)(
    input clk,
    input enable,
    input reset,
    input mode,
    input [BIT_LENGTH : 0] transformed [15:0],
    input [5:0] QP,
    output reg [BIT_LENGTH : 0] quantized [15:0]);
    
    reg [4:0] i;
    reg [13:0] multfactor;
    reg [2:0] QP_MOD_6;
    reg [3:0] QP_BY_6;
    reg [5:0] QBITS;
    
    always @ (posedge clk) begin
        if( QP == 0 || QP == 6 || QP == 12 || QP == 18 || QP == 24 || QP == 30 || QP == 36 || QP == 42 || QP == 48)
        begin 
            QP_MOD_6 <= 3'b000;
        end
    
        else if( QP == 1 || QP == 7 || QP == 13 || QP == 19 || QP == 25 || QP == 31 || QP == 37|| QP == 43 || QP == 49)
        begin 
            QP_MOD_6 <= 3'b001;
        end
        else if( QP == 2 || QP == 8 || QP == 14 || QP == 20 || QP == 26 || QP == 32 || QP == 38 || QP == 44 || QP == 50)
        begin 
            QP_MOD_6 <= 3'b010;
        end
        else if( QP == 3 || QP == 9 || QP == 15 || QP == 21 || QP == 27 || QP == 33 || QP == 39 || QP == 45 || QP == 51)
        begin 
            QP_MOD_6 <= 3'b011;
        end 
        else if( QP ==4 ||QP == 10 || QP == 16 || QP == 22 || QP == 28 || QP == 34 || QP == 40 || QP == 46)
        begin 
            QP_MOD_6 <= 3'b100;
        end
        else if( QP == 5 || QP == 11 || QP == 17 || QP == 23 || QP == 29 || QP == 35 || QP == 41 || QP == 47)
        begin 
            QP_MOD_6 <= 3'b101;
        end
        
        if( QP == 0 || QP == 1 || QP == 2 || QP == 3 || QP == 4 || QP == 5)
        begin 
            QP_BY_6 <= 4'b0000;
        end 
        else if( QP == 6 || QP == 7 || QP == 8 || QP == 9 || QP == 10 || QP == 11)
        begin 
            QP_BY_6 <= 4'b0001;
        end
        else if( QP == 12 || QP == 13 || QP == 14 || QP == 15 || QP == 16 || QP == 17)
        begin 
            QP_BY_6 <= 4'b0010;
        end
        else if( QP == 18 || QP == 19 || QP == 20 || QP == 21 || QP == 22 || QP == 23)
        begin 
            QP_BY_6 <= 4'b0011;
        end
        else if( QP == 24 || QP == 25 || QP == 26 || QP == 27 || QP == 28 || QP == 29)
        begin 
            QP_BY_6 <= 4'b0100;
        end
        else if( QP == 30 || QP == 31 || QP == 32 || QP == 33 || QP == 34 || QP == 35)
        begin 
            QP_BY_6 <= 4'b0101;
        end  
        else if( QP == 36 || QP == 37 || QP == 38 || QP == 39 || QP == 40 || QP == 41)
        begin 
            QP_BY_6 = 4'b0110;
        end
        else if( QP == 42 || QP == 43 || QP == 44 || QP == 45 || QP == 46 || QP == 47)
        begin 
            QP_BY_6 <= 4'b0111;
        end
        else if( QP == 48 || QP == 49 || QP == 50 || QP == 51)
        begin 
            QP_BY_6 <= 4'b1000;
        end
        
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

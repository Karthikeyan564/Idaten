`timescale 1ns / 1ps

module reconst #(
    parameter BIT_LENGTH = 15,
    parameter LENGTH = 720,
    parameter WIDTH = 1280,
    parameter MB_SIZE_L = 16,
    parameter MB_SIZE_W = 16)(
    input clk,
    input reset,
    input enable,
    input [12:0] mbnumber,
    output reg [7:0] mb [MB_SIZE_L*MB_SIZE_W-1:0]);
    
    int resfd;
    
    reg [7:0] residues [(LENGTH*WIDTH)-1:0];
    reg [2:0] modes [(LENGTH/MB_SIZE_L)*(WIDTH/MB_SIZE_W)-1:0];
    
    reg signed [7:0] residue [(MB_SIZE_L*MB_SIZE_W)-1:0];
    reg [7:0] toppixels [(MB_SIZE_W == 4 ? 7 : MB_SIZE_W-1):0];
    reg [7:0] leftpixels [(MB_SIZE_L == 4 ? 4 : MB_SIZE_L-1):0];
    
    reg [7:0] vpred [255:0];
    reg [7:0] hpred [255:0];
    reg [7:0] dcpred [255:0];
    
    reg [15:0] row, col;
    reg [12:0] sum = 0;
	reg [7:0] i, j, k;
	
	reg [BIT_LENGTH:0] K1 = LENGTH/MB_SIZE_L;
	reg [BIT_LENGTH:0] K2 = WIDTH/MB_SIZE_W;
	wire [BIT_LENGTH:0] rowShift, colShift;
	
	case (MB_SIZE_L) 
	       5'd16:      assign rowShift = 4;
	       5'd8:       assign rowShift = 3;
	       5'd4:       assign rowShift = 2;
	       5'd2:       assign rowShift = 1;
	       default:    assign rowShift = 4;
	endcase
	
	case (MB_SIZE_W) 
	       5'd16:      assign colShift = 4;
	       5'd8:       assign colShift = 3;
	       5'd4:       assign colShift = 2;
	       5'd2:       assign colShift = 1;
	       default:    assign colShift = 4;
	endcase
    
    always @ (posedge clk) begin

		if (enable) begin

            row <= (mbnumber%K1) << rowShift;
            col <= (mbnumber%K2) << colShift;

            // Fetch mb
            for (j = 0; j < MB_SIZE_L; j = j + 1) 
                for (k = 0; k < MB_SIZE_W; k = k +1) 
                    residue[(j*MB_SIZE_L) + k] = residues[((row+16'(j))*LENGTH) + (col+16'(k))];
                
            if (MB_SIZE_W == 4) begin
                // Fetch toppixels
                for (j = 0; j < 8; j = j + 1) 
                    toppixels[5'(j)] = (row == 0 ? 128 : (residues[((row)*LENGTH) + (col+16'(j))])); // should not come from the residues, should come from the pred_frame.
                // Fetch leftpixels
                for (i = 0; i < 5; i = i +1) 
                    leftpixels[5'(i)] = ((col == 0) ? 128 : (residues[((row+16'(i))*LENGTH) + (col)])); // same.
            end
            else begin
                 // Fetch toppixels
                for (j = 0; j < MB_SIZE_W; j = j + 1) 
                    toppixels[5'(j)] = (row == 0 ? 128 : (residues[((row)*LENGTH) + (col+16'(j))])); // should not come from the residues, should come from the pred_frame.
                // Fetch leftpixels
                for (i = 0; i < MB_SIZE_L; i = i +1) 
                    leftpixels[5'(i)] = ((col == 0) ? 128 : (residues[((row+16'(i))*LENGTH) + (col)])); // same.
            end
             
            //vertical
            for(i=0; i<16; i=i+1) 
                for(j=0;j<16; j=j+1)
                    vpred[i + 16*j] = toppixels[i];
            //horizontal
            for(i=0; i<16; i=i+1) 
                for(j=0;j<16; j=j+1)
                    hpred[j + 16*i] = leftpixels[i];

            //dc
            sum = 13'b000000000000;
            
            for(i=0;i<16;i=i+1) sum = sum + 13'(toppixels[i]);
            for(i=0;i<16;i=i+1) sum = sum + 13'(leftpixels[i]);
            
            sum = sum >> 5;
             
            for(i=0; i<256; i = i+1) dcpred[i] = 8'(sum);
            
            case (modes[i])
                3'd0: for (i = 0; i <256; i = i + 1) mb[i] = vpred[i] + residue[i];
                3'd1: for (i = 0; i <256; i = i + 1) mb[i] = hpred[i] + residue[i];
                3'd2: for (i = 0; i <256; i = i + 1) mb[i] = dcpred[i] + residue[i];
                default: for (i = 0; i <256; i = i + 1) mb[i] = vpred[i] + residue[i];
            endcase
            
        end

	end
    
endmodule

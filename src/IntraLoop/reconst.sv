`timescale 1ns / 1ps

module reconst #(
    parameter BIT_LENGTH = 15,
    parameter WIDTH = 1280,
    parameter LENGTH = 720,
    parameter MB_SIZE_L = 4,
    parameter MB_SIZE_W = 4)(
    input clk,
    input reset,
    input enable,
    input [31:0] mbnumber,
    input [2:0] mode,
    input signed [7:0] residue [(MB_SIZE_L*MB_SIZE_W)-1:0],
    output reg [7:0] mb [MB_SIZE_L*MB_SIZE_W-1:0]);
        
    reg [7:0] reconstructed [(LENGTH*WIDTH)-1:0];
    
    int resi;
    initial for (resi = 0; resi < (LENGTH*WIDTH); resi = resi + 1) reconstructed[resi] = 8'd0;
    
    reg [7:0] toppixels [(MB_SIZE_W == 4 ? 7 : MB_SIZE_W-1):0];
    reg [7:0] leftpixels [(MB_SIZE_L == 4 ? 4 : MB_SIZE_L-1):0];
    
    reg [7:0] A, B, C, D, E, F, G, H, I, J, K, L, M;
    
//    if (MB_SIZE_L == 4) begin
//        assign A = toppixels[0];
//        assign B = toppixels[1];
//        assign C = toppixels[2];
//        assign D = toppixels[3];
//        assign E = toppixels[4];
//        assign F = toppixels[5];
//        assign G = toppixels[6];
//        assign H = toppixels[7];
//        assign M = leftpixels[0];
//        assign I = leftpixels[1];
//        assign J = leftpixels[2];
//        assign K = leftpixels[3];
//        assign L = leftpixels[4];
//    end

    reg signed [7:0] allpreds [(MB_SIZE_L == 4 ? 7 : 2):0][(MB_SIZE_L*MB_SIZE_W)-1:0];
    
    reg [15:0] row, col;
    reg [12:0] sum = 0;
	reg [8:0] i, j, k;
	    
	reg [BIT_LENGTH:0] K1 = LENGTH/MB_SIZE_L;
	reg [BIT_LENGTH:0] K2 = WIDTH/MB_SIZE_W;
    
    always @ (posedge clk) begin
        
        if (enable) begin
        
            row = mbnumber[31:16];
            col = mbnumber[15:0];
                
            if (MB_SIZE_W == 4) begin
                // Fetch toppixels
                for (j = 0; j < 8; j = j + 1) 
                    toppixels[5'(j)] = ((col == LENGTH-4)  ? 128 : (row == 0 ? 128 : (reconstructed[((row-1)*LENGTH) + (col+16'(j))]))); // should not come from the residues, should come from the pred_frame.
                // Fetch leftpixels
                leftpixels[0] = (row == 0 ? 128 : reconstructed[((row-1)*LENGTH) + (col-1)]);
                for (i = 0; i < 4; i = i + 1) 
                    leftpixels[5'(i)+1] = ((col == 0) ? 128 : (reconstructed[((row+16'(i))*LENGTH) + (col-1)])); // same.
            end
            else begin
                 // Fetch toppixels
                for (j = 0; j < MB_SIZE_W; j = j + 1) 
                    toppixels[5'(j)] = ((col+j >= LENGTH)  ? 128 : (row == 0 ? 128 : (reconstructed[((row-1)*LENGTH) + (col+16'(j))]))); // should not come from the residues, should come from the pred_frame.
                // Fetch leftpixels
                for (i = 0; i < MB_SIZE_L; i = i +1) 
                    leftpixels[5'(i)] = ((col == 0) ? 128 : (reconstructed[((row+16'(i))*LENGTH) + (col)])); // same.
            end
             
            case (MB_SIZE_L)
            
                32'd4:  begin
                
                    A = toppixels[0];
                    B = toppixels[1];
                    C = toppixels[2];
                    D = toppixels[3];
                    E = toppixels[4];
                    F = toppixels[5];
                    G = toppixels[6];
                    H = toppixels[7];
                    M = leftpixels[0];
                    I = leftpixels[1];
                    J = leftpixels[2];
                    K = leftpixels[3];
                    L = leftpixels[4];
                
                    // (4x4) Vertical
                    allpreds[0][0] =I;
                    allpreds[0][1] =J;
                    allpreds[0][2] =K;
                    allpreds[0][3] =L;
                    allpreds[0][4] =I;
                    allpreds[0][5] =J;
                    allpreds[0][6] =K;
                    allpreds[0][7] =L;
                    allpreds[0][8] =I;
                    allpreds[0][9] =J;
                    allpreds[0][10] =K;
                    allpreds[0][11] =L;
                    allpreds[0][12] =I;
                    allpreds[0][13] =J;
                    allpreds[0][14] =K;
                    allpreds[0][15] =L;  
        
                    // (4x4) Horizontal
                    allpreds[1][0] =I;
                    allpreds[1][1] =I;
                    allpreds[1][2] =I;
                    allpreds[1][3] =I;
                    allpreds[1][4] =J;
                    allpreds[1][5] =J;
                    allpreds[1][6] =J;
                    allpreds[1][7] =J;
                    allpreds[1][8] =K;
                    allpreds[1][9] =K;
                    allpreds[1][10] =K;
                    allpreds[1][11] =K;
                    allpreds[1][12] =L;
                    allpreds[1][13] =L;
                    allpreds[1][14] =L;
                    allpreds[1][15] =L;    
        
                    // (4x4) Vertical Left
                    allpreds[2][0] = (A+B+1)>>1; //a
                    allpreds[2][1] = (B+C+1)>>1;//b
                    allpreds[2][2] = (C+D+1)>>1;//c
                    allpreds[2][3] = (D+E+1)>>1;//d
                    allpreds[2][4] = (A+2*B+C)>>2;//e
                    allpreds[2][5] = (B+2*C+D+2)>>2;//f
                    allpreds[2][6] = (C+2*D+E+2)>>2;//g
                    allpreds[2][7] = (D+2*E+F+2)>>2;//h
                    allpreds[2][8] = (E+F+1)>>1;//i
                    allpreds[2][9] = (C+D+1)>>1;//j
                    allpreds[2][10] =(J+I+1)>>1;//k
                    allpreds[2][11] =(J+2*I+M+2)>>2;//l
                    allpreds[2][12] =(B+2*C+D+2)>>2;//m
                    allpreds[2][13] =(C+2*D+E+2)>>2;//n
                    allpreds[2][14] =(D+2*E+F+2)>>2;//o
                    allpreds[2][15] =(E+2*F+G+2)>>2;//p   
        
                    // (4x4) Vertical Right
                    allpreds[3][0] = (M+A+1)>>1; //a
                    allpreds[3][1] = (A+B+1)>>1;//b
                    allpreds[3][2] = (B+C+1)>>1;//c
                    allpreds[3][3] = (C+D+1)>>1;//d
                    allpreds[3][4] = (I+2*M+A+2)>>2;//e
                    allpreds[3][5] = (M+2*A+B+2)>>2;//f
                    allpreds[3][6] = (A+2*B+C+2)>>2;//g
                    allpreds[3][7] = (B+2*C+D+2)>>2;//h
                    allpreds[3][8] = (J+2*I+M+2)>>2;//i
                    allpreds[3][9] = (M+A+1)>>1;//j
                    allpreds[3][10] = (A+B+1)>>1;//k
                    allpreds[3][11] =(B+C+1)>>1;//l
                    allpreds[3][12] =(K+2*J+I+2)>>2;//m
                    allpreds[3][13] =(I+2*M+A+2)>>2;;//n
                    allpreds[3][14] =(M+2*A+B+2)>>2;//o
                    allpreds[3][15] =(A+2*B+C+2)>>2;;//p     
        
                    // (4x4) Horizontal Up
                    allpreds[4][0] = (J+I+1)>>1; //a
                    allpreds[4][1] = (K+2*J+I)>>2;//b
                    allpreds[4][2] = (K+J+1)>>1;//c
                    allpreds[4][3] = (L+2*K+J+2)>>2;//d
                    allpreds[4][4] = (K+J+1)>>1;//e
                    allpreds[4][5] = (L+2*K+J+2)>>2;//f
                    allpreds[4][6] = (L+K+1)>>1;//g
                    allpreds[4][7] = (3*L+J+2)>>2;//h
                    allpreds[4][8] = (L+K+1)>>1;//i
                    allpreds[4][9] = (3*L+J+2)>>2;//j
                    allpreds[4][10] =L;//k
                    allpreds[4][11] =L;//l
                    allpreds[4][12] =L;//m
                    allpreds[4][13] =L;;//n
                    allpreds[4][14] =L;//o
                    allpreds[4][15] =L;//p    
        
                    // (4x4) Horizontal Down
                    allpreds[5][0] = (I+M+1)>>1; //a
                    allpreds[5][1] = (I+2*M+A+2)>>2;//b
                    allpreds[5][2] = (M+2*A+B+2)>>2;//c
                    allpreds[5][3] = (A+2*B+C+2)>>2;//d
                    allpreds[5][4] = (J+I+1)>>1;//e
                    allpreds[5][5] = (J+2*I+M+2)>>2;//f
                    allpreds[5][6] = (I+M+1)>>1;//g
                    allpreds[5][7] = (I+2*M+A+2)>>2;//h
                    allpreds[5][8] = (K+J+1)>>1;//i
                    allpreds[5][9] = (K+2*J+I+2)>>2;//j
                    allpreds[5][10] =(J+I+1)>>1;//k
                    allpreds[5][11] =(J+2*I+M+2)>>2;//l
                    allpreds[5][12] =(L+K+1)>>1;//m
                    allpreds[5][13] =(L+2*K+J+2)>>2;;//n
                    allpreds[5][14] =(K+J+1)>>1;;//o
                    allpreds[5][15] =(K+2*J+I+2)>>2;//p   
        
                    // (4x4) DDL
                    allpreds[6][0] = (A+2*B+C+2)>>2;
                    allpreds[6][1] = (B+2*C+D+2)>>2;
                    allpreds[6][2] = (C+2*D+E+2)>>2;
                    allpreds[6][3] = (D+2*E+F+2)>>2;
                    allpreds[6][4] = (B+2*C+D+2)>>2;
                    allpreds[6][5] = (C+2*D+E+2)>>2;
                    allpreds[6][6] = (D+2*E+F+2)>>2;
                    allpreds[6][7] = (E+2*F+G+2)>>2;
                    allpreds[6][8] = (C+2*D+E+2)>>2;
                    allpreds[6][9] = (D+2*E+F+2)>>2;
                    allpreds[6][10] =(E+2*F+G+2)>>2;
                    allpreds[6][11] =(F+2*G+H+2)>>2;
                    allpreds[6][12] =(D+2*E+F+2)>>2;
                    allpreds[6][13] =(E+2*F+G+2)>>2;
                    allpreds[6][14] =(F+2*G+H+2)>>2;
                    allpreds[6][15] = (G+3*H+2)>>2; 
        
                    // (4x4) DDR
                    allpreds[7][0] = (I+2*M+A+2)>>2; //a
                    allpreds[7][1] = (M+2*A+B+2)>>2;//b
                    allpreds[7][2] = (A+2*B+C+2)>>2;//c
                    allpreds[7][3] = (B+2*C+D+2)>>2;//d
                    allpreds[7][4] = (J+2*I+M+2)>>2;//e
                    allpreds[7][5] = (I+2*M+A+2)>>2;//f
                    allpreds[7][6] = (M+2*A+B+2)>>2;//g
                    allpreds[7][7] = (A+2*B+C+2)>>2;//h
                    allpreds[7][8] = (K+2*J+I+2)>>2;//i
                    allpreds[7][9] = (J+2*I+M+2)>>2;//j
                    allpreds[7][10] =(I+2*M+A+2)>>2;//k
                    allpreds[7][11] =(M+2*A+B+2)>>2;//l
                    allpreds[7][12] =(L+2*K+J+2)>>1;//m
                    allpreds[7][13] =(K+2*J+I+2)>>2;//n
                    allpreds[7][14] =(J+2*I+M+2)>>2;//o
                    allpreds[7][15] =(I+2*M+A+2)>>2;//p
                
                end
                
                default: begin
                
                    // Vertical
                    for (i = 0; i < MB_SIZE_L; i = i + 1) 
                        for (j = 0; j < MB_SIZE_L; j = j + 1)
                            allpreds[0][i + (MB_SIZE_L)*j] = toppixels[i];
                            
                    // Horizontal
                    for(i = 0; i < MB_SIZE_L; i = i + 1) 
                        for(j = 0; j < MB_SIZE_L; j = j + 1)
                            allpreds[1][j + (MB_SIZE_L)*i] = leftpixels[i];
        
                    //dc
                    sum = 13'b000000000000;
                    
                    for (i = 0; i < MB_SIZE_L; i = i + 1) sum = sum + 13'(toppixels[i]);
                    for (i = 0; i < MB_SIZE_L; i = i + 1) sum = sum + 13'(leftpixels[i]);
                    
                    sum = sum >> 5;
                     
                    for (i = 0; i < (MB_SIZE_L*MB_SIZE_W); i = i + 1) allpreds[2][i] = 8'(sum);
                                            
                end
                
            endcase
                
        end
    end
    
    always @ (posedge clk) begin

		if (enable) begin

            for (k = 0; k < (MB_SIZE_L*MB_SIZE_W); k = k + 1)
                mb[5'(k)] = allpreds[mode][5'(k)] + residue[5'(k)];
                
            for (i = 0; i < MB_SIZE_L; i = i +1) 
                for (j = 0; j < MB_SIZE_W; j = j + 1) 
                    reconstructed[((row+13'(i))*LENGTH)+(col+13'(j))] = mb[(i*MB_SIZE_L)+j]; 
                        
        end

	end
    
endmodule

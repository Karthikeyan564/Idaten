`timescale 1ns/1ps

module predadder #(
    parameter WIDTH = 1280,
    parameter LENGTH = 720,
    parameter MB_SIZE_L = 16,
    parameter MB_SIZE_W = 16)(
    input clk,
    input reset,
    input enable,
    input mode,
    input [7:0] toppixels [(MB_SIZE_W == 4 ? 7 : MB_SIZE_W-1):0],
    input [7:0] leftpixels [(MB_SIZE_L == 4 ? 4 : MB_SIZE_L-1):0],
    output reg [7:0] reconst [15:0]);

    // Counters
    reg [6:0] i, j, k;
    reg [12:0] sum;

	// Neighbouring pixels
	reg [7:0] A, B, C, D, E, F, G, H, I, J, K, L, M;
	
	// Preds
	reg [7:0] vpred [(MB_SIZE_L*MB_SIZE_W)-1:0];
	reg [7:0] hpred [(MB_SIZE_L*MB_SIZE_W)-1:0];
	reg [7:0] vlpred [(MB_SIZE_L*MB_SIZE_W)-1:0];
	reg [7:0] vrpred [(MB_SIZE_L*MB_SIZE_W)-1:0];
	reg [7:0] hupred [(MB_SIZE_L*MB_SIZE_W)-1:0];
	reg [7:0] hdpred [(MB_SIZE_L*MB_SIZE_W)-1:0];
	reg [7:0] ddlpred [(MB_SIZE_L*MB_SIZE_W)-1:0];
	reg [7:0] ddrpred [(MB_SIZE_L*MB_SIZE_W)-1:0];
	reg [7:0] dcpred [(MB_SIZE_L*MB_SIZE_W)-1:0];

    always @(posedge clk) begin

        if (enable) begin
            
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
                    vpred[0] =I;
                    vpred[1] =J;
                    vpred[2] =K;
                    vpred[3] =L;
                    vpred[4] =I;
                    vpred[5] =J;
                    vpred[6] =K;
                    vpred[7] =L;
                    vpred[8] =I;
                    vpred[9] =J;
                    vpred[10] =K;
                    vpred[11] =L;
                    vpred[12] =I;
                    vpred[13] =J;
                    vpred[14] =K;
                    vpred[15] =L;  
        
                    // (4x4) Horizontal
                    hpred[0] =I;
                    hpred[1] =I;
                    hpred[2] =I;
                    hpred[3] =I;
                    hpred[4] =J;
                    hpred[5] =J;
                    hpred[6] =J;
                    hpred[7] =J;
                    hpred[8] =K;
                    hpred[9] =K;
                    hpred[10] =K;
                    hpred[11] =K;
                    hpred[12] =L;
                    hpred[13] =L;
                    hpred[14] =L;
                    hpred[15] =L;    
        
                    // (4x4) Vertical Left
                    vlpred[0] = (A+B+1)>>1; //a
                    vlpred[1] = (B+C+1)>>1;//b
                    vlpred[2] = (C+D+1)>>1;//c
                    vlpred[3] = (D+E+1)>>1;//d
                    vlpred[4] = (A+2*B+C)>>2;//e
                    vlpred[5] = (B+2*C+D+2)>>2;//f
                    vlpred[6] = (C+2*D+E+2)>>2;//g
                    vlpred[7] = (D+2*E+F+2)>>2;//h
                    vlpred[8] = (E+F+1)>>1;//i
                    vlpred[9] = (C+D+1)>>1;//j
                    vlpred[10] =(J+I+1)>>1;//k
                    vlpred[11] =(J+2*I+M+2)>>2;//l
                    vlpred[12] =(B+2*C+D+2)>>2;//m
                    vlpred[13] =(C+2*D+E+2)>>2;//n
                    vlpred[14] =(D+2*E+F+2)>>2;//o
                    vlpred[15] =(E+2*F+G+2)>>2;//p   
        
                    // (4x4) Vertical Right
                    vrpred[0] = (M+A+1)>>1; //a
                    vrpred[1] = (A+B+1)>>1;//b
                    vrpred[2] = (B+C+1)>>1;//c
                    vrpred[3] = (C+D+1)>>1;//d
                    vrpred[4] = (I+2*M+A+2)>>2;//e
                    vrpred[5] = (M+2*A+B+2)>>2;//f
                    vrpred[6] = (A+2*B+C+2)>>2;//g
                    vrpred[7] = (B+2*C+D+2)>>2;//h
                    vrpred[8] = (J+2*I+M+2)>>2;//i
                    vrpred[9] = (M+A+1)>>1;//j
                    vrpred[10] = (A+B+1)>>1;//k
                    vrpred[11] =(B+C+1)>>1;//l
                    vrpred[12] =(K+2*J+I+2)>>2;//m
                    vrpred[13] =(I+2*M+A+2)>>2;;//n
                    vrpred[14] =(M+2*A+B+2)>>2;//o
                    vrpred[15] =(A+2*B+C+2)>>2;;//p     
        
                    // (4x4) Horizontal Up
                    hupred[0] = (J+I+1)>>1; //a
                    hupred[1] = (K+2*J+I)>>2;//b
                    hupred[2] = (K+J+1)>>1;//c
                    hupred[3] = (L+2*K+J+2)>>2;//d
                    hupred[4] = (K+J+1)>>1;//e
                    hupred[5] = (L+2*K+J+2)>>2;//f
                    hupred[6] = (L+K+1)>>1;//g
                    hupred[7] = (3*L+J+2)>>2;//h
                    hupred[8] = (L+K+1)>>1;//i
                    hupred[9] = (3*L+J+2)>>2;//j
                    hupred[10] =L;//k
                    hupred[11] =L;//l
                    hupred[12] =L;//m
                    hupred[13] =L;;//n
                    hupred[14] =L;//o
                    hupred[15] =L;//p    
        
                    // (4x4) Horizontal Down
                    hdpred[0] = (I+M+1)>>1; //a
                    hdpred[1] = (I+2*M+A+2)>>2;//b
                    hdpred[2] = (M+2*A+B+2)>>2;//c
                    hdpred[3] = (A+2*B+C+2)>>2;//d
                    hdpred[4] = (J+I+1)>>1;//e
                    hdpred[5] = (J+2*I+M+2)>>2;//f
                    hdpred[6] = (I+M+1)>>1;//g
                    hdpred[7] = (I+2*M+A+2)>>2;//h
                    hdpred[8] = (K+J+1)>>1;//i
                    hdpred[9] = (K+2*J+I+2)>>2;//j
                    hdpred[10] =(J+I+1)>>1;//k
                    hdpred[11] =(J+2*I+M+2)>>2;//l
                    hdpred[12] =(L+K+1)>>1;//m
                    hdpred[13] =(L+2*K+J+2)>>2;;//n
                    hdpred[14] =(K+J+1)>>1;;//o
                    hdpred[15] =(K+2*J+I+2)>>2;//p   
        
                    // (4x4) DDL
                    ddlpred[0] = (A+2*B+C+2)>>2;
                    ddlpred[1] = (B+2*C+D+2)>>2;
                    ddlpred[2] = (C+2*D+E+2)>>2;
                    ddlpred[3] = (D+2*E+F+2)>>2;
                    ddlpred[4] = (B+2*C+D+2)>>2;
                    ddlpred[5] = (C+2*D+E+2)>>2;
                    ddlpred[6] = (D+2*E+F+2)>>2;
                    ddlpred[7] = (E+2*F+G+2)>>2;
                    ddlpred[8] = (C+2*D+E+2)>>2;
                    ddlpred[9] = (D+2*E+F+2)>>2;
                    ddlpred[10] =(E+2*F+G+2)>>2;
                    ddlpred[11] =(F+2*G+H+2)>>2;
                    ddlpred[12] =(D+2*E+F+2)>>2;
                    ddlpred[13] =(E+2*F+G+2)>>2;
                    ddlpred[14] =(F+2*G+H+2)>>2;
                    ddlpred[15] = (G+3*H+2)>>2; 
        
                    // (4x4) DDR
                    ddrpred[0] = (I+2*M+A+2)>>2; //a
                    ddrpred[1] = (M+2*A+B+2)>>2;//b
                    ddrpred[2] = (A+2*B+C+2)>>2;//c
                    ddrpred[3] = (B+2*C+D+2)>>2;//d
                    ddrpred[4] = (J+2*I+M+2)>>2;//e
                    ddrpred[5] = (I+2*M+A+2)>>2;//f
                    ddrpred[6] = (M+2*A+B+2)>>2;//g
                    ddrpred[7] = (A+2*B+C+2)>>2;//h
                    ddrpred[8] = (K+2*J+I+2)>>2;//i
                    ddrpred[9] = (J+2*I+M+2)>>2;//j
                    ddrpred[10] =(I+2*M+A+2)>>2;//k
                    ddrpred[11] =(M+2*A+B+2)>>2;//l
                    ddrpred[12] =(L+2*K+J+2)>>1;//m
                    ddrpred[13] =(K+2*J+I+2)>>2;//n
                    ddrpred[14] =(J+2*I+M+2)>>2;//o
                    ddrpred[15] =(I+2*M+A+2)>>2;//p
                
                end
                
                default: begin
                
                    // Vertical
                    for (i = 0; i < MB_SIZE_L; i = i + 1) 
                        for (j = 0; j < MB_SIZE_L; j = j + 1)
                            vpred[i + (MB_SIZE_L)*j] = toppixels[i];
                            
                    // Horizontal
                    for(i = 0; i < MB_SIZE_L; i = i + 1) 
                        for(j = 0; j < MB_SIZE_L; j = j + 1)
                            hpred[j + (MB_SIZE_L)*i] = leftpixels[i];
        
                    //dc
                    sum = 13'b000000000000;
                    
                    for (i = 0; i < MB_SIZE_L; i = i + 1) sum = sum + 13'(toppixels[i]);
                    for (i = 0; i < MB_SIZE_L; i = i + 1) sum = sum + 13'(leftpixels[i]);
                    
                    sum = sum >> 5;
                     
                    for (i = 0; i < (MB_SIZE_L*MB_SIZE_W); i = i + 1) vlpred[i] = 8'(sum);
                                            
                end
                
            endcase

        end

    end

endmodule
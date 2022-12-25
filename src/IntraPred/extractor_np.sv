`timescale 1ns/1ps

module extractor_np #(
    parameter BIT_LENGTH = 15,
    parameter WIDTH = 1280,
    parameter LENGTH = 720,
    parameter MB_SIZE_L = 16,
    parameter MB_SIZE_W = 16)(
    input clk,
    input reset,
    input enable,
    input [31:0] mbnumber,
    output reg [7:0] toppixels [(MB_SIZE_W == 4 ? 7 : MB_SIZE_W-1):0],
    output reg [7:0] leftpixels [(MB_SIZE_L == 4 ? 4 : MB_SIZE_L-1):0]);
            
    reg [7:0] image [(LENGTH*WIDTH)-1:0];
    
    initial begin
		$readmemh("output.mem", image);
	end

    reg [15:0] row, col;
	reg [7:0] i, j, k;
    
    always @ (posedge clk) begin

		if (enable) begin

            row = mbnumber[31:16];
            col = mbnumber[15:0];
                
            if (MB_SIZE_W == 4) begin
                // Fetch toppixels
                for (j = 0; j < 8; j = j + 1) 
                    toppixels[5'(j)] = ((col == LENGTH-4)  ? 128 : (row == 0 ? 128 : (uintraloop.ureconst.reconstructed[((row-1)*LENGTH) + (col+16'(j))]))); // should not come from the residues, should come from the pred_frame.
                // Fetch leftpixels
                leftpixels[0] = (row == 0 ? 128 : uintraloop.ureconst.reconstructed[((row-1)*LENGTH) + (col-1)]);
                for (i = 0; i < 4; i = i + 1) 
                    leftpixels[5'(i)+1] = ((col == 0) ? 128 : (uintraloop.ureconst.reconstructed[((row+16'(i))*LENGTH) + (col-1)])); // same.
            end
            else begin
                 // Fetch toppixels
                for (j = 0; j < MB_SIZE_W; j = j + 1) 
                    toppixels[5'(j)] = ((col == LENGTH-4)  ? 128 : (row == 0 ? 128 : (uintraloop.ureconst.reconstructed[((row-1)*LENGTH) + (col+16'(j))]))); // should not come from the residues, should come from the pred_frame.
                // Fetch leftpixels
                for (i = 0; i < MB_SIZE_L; i = i +1) 
                    leftpixels[5'(i)] = ((col == 0) ? 128 : (uintraloop.ureconst.reconstructed[((row+16'(i))*LENGTH) + (col-1)])); // same.
            end
            
        end

	end

endmodule
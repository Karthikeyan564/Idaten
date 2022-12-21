`timescale 1ns/1ps

module extractor #(
    parameter BIT_LENGTH = 15,
    parameter WIDTH = 720,
    parameter LENGTH = 1280,
    parameter MB_SIZE_L = 16,
    parameter MB_SIZE_W = 16)(
    input clk,
    input reset,
    input enable,
    input [12:0] mbnumber,
    output reg [7:0] mb [MB_SIZE_L*MB_SIZE_W-1:0],
    output reg [7:0] toppixels [(MB_SIZE_W == 4 ? 7 : MB_SIZE_W-1):0],
    output reg [7:0] leftpixels [(MB_SIZE_L == 4 ? 4 : MB_SIZE_L-1):0]);
    
    reg [7:0] image [LENGTH*WIDTH-1 : 0];

    initial begin
		$readmemh("output.mem", image);
	end

    reg [15:0] row, col;
	reg [7:0] i, j, k;
	
	reg [BIT_LENGTH:0] K1 = LENGTH/MB_SIZE_L;
	reg [BIT_LENGTH:0] K2 = WIDTH/MB_SIZE_W;
	reg [BIT_LENGTH:0] rowShift, colShift;
	
    initial begin
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
	end
    
    always @ (posedge clk) begin

		if (enable) begin

            row <= (mbnumber%K1) << rowShift;
            col <= (mbnumber%K2) << colShift;

            // Fetch mb
            for (j = 0; j < MB_SIZE_L; j = j + 1) 
                for (k = 0; k < MB_SIZE_W; k = k +1) 
                    mb[(j*MB_SIZE_L) + k] = image[((row+16'(j))*LENGTH) + (col+16'(k))];
                
            if (MB_SIZE_W == 4) begin
                // Fetch toppixels
                for (j = 0; j < 8; j = j + 1) 
                    toppixels[5'(j)] = (row == 0 ? 128 : (image[((row)*LENGTH) + (col+16'(j))])); // should not come from the image, should come from the pred_frame.
                // Fetch leftpixels
                for (i = 0; i < 5; i = i +1) 
                    leftpixels[5'(i)] = ((col == 0) ? 128 : (image[((row+16'(i))*LENGTH) + (col)])); // same.
            end
            else begin
                 // Fetch toppixels
                for (j = 0; j < MB_SIZE_W; j = j + 1) 
                    toppixels[5'(j)] = (row == 0 ? 128 : (image[((row)*LENGTH) + (col+16'(j))])); // should not come from the image, should come from the pred_frame.
                // Fetch leftpixels
                for (i = 0; i < MB_SIZE_L; i = i +1) 
                    leftpixels[5'(i)] = ((col == 0) ? 128 : (image[((row+16'(i))*LENGTH) + (col)])); // same.
            end
            
        end

	end

endmodule
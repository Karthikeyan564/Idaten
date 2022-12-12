`timescale 1ns/1ps

module extractor_luma16x16 #(
    parameter BIT_LENGTH = 15,
    parameter LENGTH = 1280,
    parameter WIDTH = 720,
    parameter MB_SIZE_L = 16,
    parameter MB_SIZE_W = 16)(
    input clk,
    input reset,
    input enable,
    input [12:0] mbnumber,
    output reg [7:0] mb [MB_SIZE_L*MB_SIZE_W-1:0],
    output reg [7:0] toppixels [MB_SIZE_W-1:0],
    output reg [7:0] leftpixels [MB_SIZE_L-1:0]);
    
    reg [7:0] image [LENGTH*WIDTH-1 : 0];
    reg [7:0] mbintermediate [MB_SIZE_L*MB_SIZE_W-1:0];

    initial begin
		$readmemh("output.mem", image);
	end

    reg [15:0] row, col;
	reg [7:0] i, j, k;
	
	reg [BIT_LENGTH:0] K1 = LENGTH/MB_SIZE_L;
	reg [BIT_LENGTH:0] K2 = WIDTH/MB_SIZE_W;
	wire [BIT_LENGTH:0] rowShift, colShift;
	
	case (MB_SIZE_L) 
	
	       5'b10000:   assign rowShift = 4;
	       5'b01000:   assign rowShift = 3;
	       5'b00100:   assign rowShift = 2;
	       default:    assign rowShift = 4;
	       
	endcase
	
	case (MB_SIZE_W) 
	
	       5'b10000:   assign colShift = 4;
	       5'b01000:   assign colShift = 3;
	       5'b00100:   assign colShift = 2;
	       default:    assign colShift = 4;
	       
	endcase
	
    
    always @ (posedge clk) begin

		if (enable) begin

            mb <= mbintermediate;

            row <= (mbnumber%K1) << rowShift;
            col <= (mbnumber%K2) << colShift;

            // Fetch mb
            for (j = 0; j < MB_SIZE_L; j = j + 1) begin
                for (k = 0; k < MB_SIZE_W; k = k +1) begin
                    mbintermediate[(j*MB_SIZE_L) + k] = image[((row+16'(j))*LENGTH) + (col+16'(k))];
                end
            end
            
            // Fetch toppixels
            for (j = 0; j < MB_SIZE_W; j = j + 1) begin
                toppixels[5'(j)] = (row == 0 ? 128 : (image[((row-1)*LENGTH) + (col+16'(j))])); // should not come from the image, should come from the pred_frame.
            end

            // Fetch leftpixels
            for (i = 0; i < MB_SIZE_L; i = i +1) begin
                leftpixels[5'(i)] = ((col == 0) ? 128 : (image[((row+16'(i))*LENGTH) + (col-1)])); // same.
            end
            
        end

	end

endmodule
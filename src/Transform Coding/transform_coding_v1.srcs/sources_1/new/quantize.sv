`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2022 19:52:59
// Design Name: 
// Module Name: quantize
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module quantize(
    input [31:0] transf [15:0],
    input clk,
    input en3,
    output reg [31:0] quant [15:0]
    );
    
    reg [5:0] qp;
    reg [31:0] mult [15:0]; //change bits later to save design
    reg [31:0] qpsum ;
    
     //use for quantization parameter 0
     initial begin
        $readmemh("quantparam0.mem",mult);
        
     end
     integer i;
     always @(posedge clk)
     if(en3==1) begin
        begin
            for(i=0;i<16;i=i+1) begin
                quant[i] = (transf[i]*mult[i])>>(15);
             end
        end 
      end    
       
            
        
endmodule

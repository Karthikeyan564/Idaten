module comparator(input clk, input en, input [8:0][15:0] distort, output reg [3:0] best, output reg done);


wire [3:0] a,b,c,d,e,f,g,h;

assign a = distort[0] <= distort[1] ? 0: 1;
assign b = distort[2] <= distort[3] ? 2: 3;
assign c = distort[4] <= distort[5] ? 4: 5;
assign d = distort[6] <= distort[7] ? 6: 7;
assign e = distort[a] <= distort[b] ? a : b;
assign f = distort[c] <= distort[d] ? c : d;
assign g = distort[e] <= distort[f] ? e : f;
assign h = distort[g] <= distort[8] ? g : 8;

always @ (posedge clk)
begin
if(en)
begin
    best <= h;
    done <= 1;
end
else 
    done <= 0;

end
endmodule
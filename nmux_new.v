module nmux_new
(input [31:0] a,b,
input s,
output [31:0] y);
assign y=(s==1)?a:b;
endmodule

module dff_as_bm
(input d,clk,rst,
output reg q,qb);
always @ (posedge clk)
begin
if (rst)
begin
q<=0;
qb<=0;
end
else
q<=d;
qb<=~q;
end
endmodule

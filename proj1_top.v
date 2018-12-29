module proj1_top
(input clk1,clk2,rst1,rst2,en_ex,
input [31:0] src1,src2,imm,mem_read,
input [6:0] cntrl_in,
output [31:0] aluout,
output carry,mem_wr_en,mem_write_out);

wire [31:0] w1,w2;
wire [2:0] w3,w4;
wire [4:0] w5;
wire w6,w7;
/*output reg [31:0] aluin1,aluin2,
output reg [2:0] op,opsel,
output reg [4:0] shift_nos,
output reg en_ar,en_sh*/

wire [31:0] w8,w9;
wire w100,w101;
/*output reg carry,
output reg [31:0] aluout_ar
output reg [31:0] aluout_sh*/
wire w11,w12,w13;
prepros p1 (.clk1(clk1),.carry(w13),.rst1(rst1),.en_ex(en_ex),.src1(src1),.src2(src2),.imm(imm),.cntrl_in(cntrl_in),.mem_read(mem_read),.aluin1(w1),.aluin2(w2),.op(w3),.opsel(w4),.shift_nos(w5),.en_ar(w6),.en_sh(w7),.mem_wr_en(mem_wr_en),.mem_write_out(mem_write_out));
ar_alu a1 (.clk2(clk2),.rst2(rst2),.aluin1(w1),.aluin2(w2),.aluop(w3),.alusel(w4),.shift_nos(w5),.en_ar(w6),.carry(w100),.aluout_ar(w8));
shift_alu s1(.clk2(clk2),.rst2(rst2),.in(w1),.en_sh(w7),.shift(w3),.shift_op(w4),.shift_nos(w5),.aluout_sh(w9),.carry(w101));
dff_as_bm d1 (.clk(clk2),.rst(rst2),.d(w6),.q(w11),.qb());
nmux_new n1 (.a(w9),.b(w8),.s(w11),.y(aluout));
mux2to1_bm m1 (.a(w100),.b(w101),.s(w11),.y(w12));
mux2to1_bm m2 (.a(w12),.b(w13),.s(w6|w7),.y(carry));
//assign aluout=(w11==1'b1)?w9:w8;
//assign carry=w10;
endmodule 
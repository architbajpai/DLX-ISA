`include "packet_dlx.sv"
`include "packet_prepros.sv"
`include "generator_dlx.sv"
`include "driver_dlx.sv"
`include "intf_dlx.sv"
`include "intf_prepros.sv"

`include "prepros.v"
`include "ar_alu.v"
`include "shift_alu.v"
`include "dff_as_bm.v"
`include "nmux_new.v"
`include "mux2to1_bm.v"
`include "proj1_top.v"

`include "coverage_dlx.sv"
//`include "coverage_prepros.sv"
`include "monitor_dlx.sv"
`include "scoreboard_dlx.sv"
`include "environment_dlx.sv"
`include "test_dlx.sv"

module top_dlx;
reg clk,rst;
initial 
clk=1'b0;
always #5 clk=~clk;

initial begin
rst=1'b1;
#10 rst=1'b0;
//#100 rst=1'b1;
//#100 rst=1'b0;
end

intf_dlx i(clk,rst);

proj1_top dut (.clk1(clk),.clk2(clk),.rst1(rst),.rst2(rst),.en_ex(i.en_ex),.src1(i.src1),.src2(i.src2),.imm(i.imm),.mem_read(i.mem_read),
.cntrl_in(i.cntrl_in),.aluout(i.aluout),.carry(i.carry),.mem_wr_en(i.mem_wr_en),.mem_write_out(i.mem_write_out));


intf_prepros fi(.clk(clk),.rst(rst),.en_ex(dut.p1.en_ex),.src1(dut.p1.src1),.src2(dut.p1.src2),.imm(dut.p1.imm),.mem_read(dut.p1.mem_read),
.cntrl_in(dut.p1.cntrl_in),.aluin1(dut.p1.aluin1),.aluin2(dut.p1.aluin2),.op(dut.p1.op),.opsel(dut.p1.opsel),.shift_nos(dut.p1.shift_nos),
.en_ar(dut.p1.en_ar),.en_sh(dut.p1.en_sh),.carry(dut.p1.carry),.mem_wr_en(dut.p1.mem_wr_en),.mem_write_out(dut.p1.mem_write_out));

test_dlx t1 (fi,i);
endmodule
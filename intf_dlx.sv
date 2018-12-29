interface intf_dlx (input bit clk,rst);
logic [31:0] src1,src2,imm,mem_read;
logic en_ex;
logic [6:0] cntrl_in;
logic mem_wr_en,mem_write_out,carry;
logic [31:0] aluout;

endinterface

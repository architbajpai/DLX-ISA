interface intf_prepros (input bit clk,rst,
input logic en_ex,
input logic [6:0] cntrl_in,
input logic [31:0] src1,src2,imm,mem_read,
input logic [31:0] aluin1,aluin2,
input logic [2:0] op,opsel,
input logic [4:0] shift_nos,
input logic en_ar,en_sh,mem_wr_en,mem_write_out,carry  );

endinterface
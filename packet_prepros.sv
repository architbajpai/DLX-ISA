class packet_prepros;
logic [31:0] src1,src2,imm,mem_read;
logic en_ex;
logic [6:0] cntrl_in;
bit rst;

logic aluin1,aluin2;
logic [2:0] op,opsel;
logic [4:0] shift_nos;
logic en_ar,en_sh,mem_wr_en,mem_write_out,carry;

/*function void pre_randomize();
$display("INPACKdlx cntrl_in:%b	 imm:%h  mem_read:%h  en_ex:%b",cntrl_in,imm,mem_read,en_ex);
endfunction

function void post_randomize();
$display("INPACKdlx cntrl_in:%b	 imm:%h  mem_read:%h  en_ex:%b",cntrl_in,imm,mem_read,en_ex);
endfunction*/
endclass
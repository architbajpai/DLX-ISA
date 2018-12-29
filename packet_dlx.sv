class packet_dlx;
rand logic [31:0] src1,src2,imm,mem_read;
rand logic en_ex;
rand logic [6:0] cntrl_in;
bit rst;
logic mem_wr_en,mem_write_out,carry;
logic [31:0] aluout;

//constraint c1 { src1>32'd0; src1<32'd100; src2>32'd0; src2<32'd100; imm>32'd0; imm<32'd100; mem_read>32'd0; mem_read<32'd100;} 


function void pre_randomize();
$display("INPACKdlx cntrl_in:%b	 imm:%h  mem_read:%h  en_ex:%b",cntrl_in,imm,mem_read,en_ex);
endfunction

function void post_randomize();
$display("INPACKdlx cntrl_in:%b	 imm:%h  mem_read:%h  en_ex:%b",cntrl_in,imm,mem_read,en_ex);
endfunction
endclass
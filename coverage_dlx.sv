class coverage_dlx;
virtual intf_dlx i;
covergroup cg @ (i.clk,i.rst);
sr1: coverpoint i.src1 {bins ii={[32'h00000000:32'hffffffff]};}
sr2: coverpoint i.src2 {bins dd={[32'h00000000:32'hffffffff]};} 
im: coverpoint i.imm {bins aa={[32'h00000000:32'hffffffff]};}
md: coverpoint i.mem_read {bins ddd={[32'h00000000:32'hffffffff]};}
mdwren: coverpoint i.mem_wr_en {bins mdw={[1'b0:1'b1]};} 
mdwo: coverpoint i.mem_write_out{bins mddw={[1'b0:1'b1]};}  
ao: coverpoint i.aluout {bins dddd={[32'h00000000:32'hffffffff]};}
c: coverpoint i.carry{bins cc={[1'b0:1'b1]};}  
excn: cross i.en_ex,i.cntrl_in;

endgroup

function new (virtual intf_dlx i);
this.i=i;
cg=new();
endfunction
task sample;
cg.sample;
endtask
endclass
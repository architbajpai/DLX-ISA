class driver_dlx;
packet_dlx pkt;
mailbox #(packet_dlx) gen_drv;
virtual intf_dlx i;

function new (mailbox #(packet_dlx) gen_drv, virtual intf_dlx i);
this.gen_drv=gen_drv;
this.i=i;
endfunction

task run;
pkt=new();
gen_drv.get(pkt);
i.en_ex=pkt.en_ex;
i.src1=pkt.src1;
i.src2=pkt.src2;
i.imm=pkt.imm;
i.cntrl_in=pkt.cntrl_in;
i.mem_read=pkt.mem_read;

endtask
endclass
class monitor_dlx;
mailbox #(packet_prepros) mon_sb;
packet_dlx pkt;
packet_prepros fpkt;
virtual intf_dlx i;
virtual intf_prepros fi;
function new (mailbox #(packet_prepros) mon_sb,virtual intf_prepros fi,virtual intf_dlx i); //mailbox #(packet_fetch) mon_sb
this.mon_sb=mon_sb;
this.i=i;
this.fi=fi;
endfunction

task run;
pkt=new(); fpkt=new();
pkt.en_ex=i.en_ex;
pkt.src1=i.src1;
pkt.src2=i.src2;
pkt.imm=i.imm;
pkt.cntrl_in=i.cntrl_in;
pkt.mem_read=i.mem_read;
pkt.mem_wr_en=i.mem_wr_en;
pkt.mem_write_out=i.mem_write_out;
pkt.carry=i.carry;
pkt.aluout=i.aluout;

fpkt.en_ex=fi.en_ex;
fpkt.src1=fi.src1;
fpkt.src2=fi.src2;
fpkt.imm=fi.imm;
fpkt.cntrl_in=fi.cntrl_in;
fpkt.mem_read=fi.mem_read;
fpkt.mem_wr_en=fi.mem_wr_en;
fpkt.mem_write_out=fi.mem_write_out;
fpkt.aluin1=fi.aluin1;
fpkt.aluin2=fi.aluin2;
fpkt.op=fi.op;
fpkt.opsel=fi.opsel;
fpkt.shift_nos=fi.shift_nos;
fpkt.en_ar=fi.en_ar;
fpkt.en_sh=fi.en_sh;
fpkt.mem_wr_en=fi.mem_wr_en;
fpkt.mem_write_out=fi.mem_write_out;
fpkt.carry=fi.carry;
mon_sb.put(fpkt);

endtask
endclass
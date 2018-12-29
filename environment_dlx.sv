class environment_dlx;
mailbox #(packet_dlx) gen_drv;
mailbox #(packet_prepros) mon_sb;
virtual intf_dlx i;
virtual intf_prepros fi;
generator_dlx g1;
driver_dlx d1;
monitor_dlx m1;
scoreboard_dlx s1;
coverage_dlx c1;
//coverage_prepros c2;
function new (virtual intf_prepros fi, virtual intf_dlx i);
this.i=i;
this.fi=fi;
endfunction

function build();
gen_drv=new();
mon_sb=new();

g1=new(gen_drv);
d1=new(gen_drv,i);
m1=new(mon_sb,fi,i);
s1=new(mon_sb);
c1=new(i);
//c2=new(fi);
endfunction

task run;
g1.run; d1.run; m1.run; s1.run; c1.sample; //c2.sample;
endtask
endclass
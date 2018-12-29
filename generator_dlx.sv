class generator_dlx;
packet_dlx pkt;
mailbox #(packet_dlx) gen_drv;
function new (mailbox #(packet_dlx) gen_drv);
this.gen_drv=gen_drv;
endfunction
task run;
pkt=new();
assert (pkt.randomize())
begin
$display("success");
gen_drv.put(pkt);
end
else
$error("randomization failed");
endtask
endclass
module test_dlx ( intf_prepros fi,intf_dlx i);
environment_dlx en;
initial begin
en=new(fi,i);
en.build();
repeat(1000)
begin
#10 en.run();
end
end
endmodule
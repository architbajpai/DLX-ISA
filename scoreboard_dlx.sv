`define CLK_PERIOD 10
`define REGISTER_WIDTH 32
`define INSTR_WIDTH 32
`define IMMEDIATE_WIDTH 16
`define MEM_READ 3'b101
`define MEM_WRITE 3'b100
`define ARITH_LOGIC 3'b001
`define SHIFT_REG 3'b000


class scoreboard_dlx;
packet_prepros fpkt;
mailbox #(packet_prepros) mon_sb;
reg en_ar,en_sh,mem_wr_en,mem_write_out,carry,ir,y;
reg [31:0] aluin1,aluin2;
reg [4:0] shift_nos;
reg [2:0] op,opsel;
reg [31:0] temp;

function new (mailbox #(packet_prepros) mon_sb);
this.mon_sb=mon_sb;
endfunction

task run;
mon_sb.get(fpkt);

begin
	if (fpkt.rst)
	begin
	en_ar=1'b0;
	en_sh=1'b0;
	aluin1={32{1'b0}};
	aluin2={32{1'b0}};
	shift_nos=5'b0;
	end
	
	else if (fpkt.en_ex==1'b1)
	begin
	case (fpkt.en_ex)
	1'b0: begin
		aluin1=fpkt.aluin1;
		aluin2=fpkt.aluin2;
		shift_nos=0;
		en_ar=1'b0;
		en_sh=1'b0;
		temp=fpkt.mem_read;
		end
	
	1'b1: begin 
	aluin1=fpkt.src1;
		begin					//aluin2
		  if (fpkt.opsel==`ARITH_LOGIC)
		  begin
		  if (ir)
		  aluin2=fpkt.imm;
		  else
		  aluin2=fpkt.src2;
		  end
		  
		  else if (opsel==`MEM_READ)
		  begin
		  if (ir)
		  aluin2=fpkt.mem_read;
		  else
		  aluin2=fpkt.aluin2;
		  end
		
		 else
		 aluin2=fpkt.aluin2;
	      end

		begin					//shift_nos
			if (fpkt.opsel==`SHIFT_REG)
			begin
			if (fpkt.imm[2])
			shift_nos=fpkt.src2[4:0];
			else
			shift_nos=fpkt.imm[10:6];
			end
			
			else
			shift_nos=0;
		end

		begin				//en_ar
			if (fpkt.opsel==`ARITH_LOGIC)
			en_ar=1'b1;
			else if (fpkt.opsel==`MEM_READ)
			begin
			if (ir)
			en_ar=1'b1;
			else
			en_ar=1'b0;
			end
			else
			en_ar=1'b0;
		end

		begin
		if (!(opsel==`SHIFT_REG))
		en_sh=1'b1;
		else
		en_sh=1'b0;
		end
		  
	end
	
	endcase
end

begin
	if (fpkt.rst)
	begin
	carry=0;
	mem_wr_en=0;
	mem_write_out=0;
	end
	else if (fpkt.en_ex==1)
	begin
	if (!fpkt.mem_read)
	carry=0;
	else
	begin
		if (fpkt.opsel==`MEM_WRITE&&ir==1)
		y=1;
		else
		y=0;
		case(y)
		1'b0: mem_wr_en=1'b0;
		1'b1: mem_wr_en=1'b1;
		endcase

	mem_write_out=temp[0];
	temp=temp>>1;
	end
	end
	else
	begin
	carry=fpkt.carry;
	mem_wr_en=fpkt.mem_wr_en;
	mem_write_out=fpkt.mem_write_out;
	end
end
end

begin
	if (fpkt.rst)
	begin 
	op=3'b000;
	opsel=3'b000;
	ir=1'b0;
	end
	
	else if (fpkt.en_ex)
	begin
	op=fpkt.cntrl_in[6:4];
	ir=fpkt.cntrl_in[3];
	opsel=fpkt.cntrl_in[2:0];
	end

	else
	begin
	op=fpkt.op;
	ir=fpkt.cntrl_in[3];
	opsel=fpkt.opsel;
	end

end
assert (en_ar==fpkt.en_ar&&en_sh==fpkt.en_sh)
$display("scoreboard assertion passed");
else
$display("scoreboard assertion failed");
endtask
endclass
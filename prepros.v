`define CLK_PERIOD 10
`define REGISTER_WIDTH 32
`define INSTR_WIDTH 32
`define IMMEDIATE_WIDTH 16
`define MEM_READ 3'b101
`define MEM_WRITE 3'b100
`define ARITH_LOGIC 3'b001
`define SHIFT_REG 3'b000


module prepros
(input clk1,rst1,en_ex,
input [31:0] src1,src2,imm,mem_read,
input [6:0] cntrl_in,
output reg [31:0] aluin1,aluin2,
output reg [2:0] op,opsel,
output reg [4:0] shift_nos,
output reg en_ar,en_sh,mem_wr_en,mem_write_out,carry);
reg imm_regn,y;
reg [31:0] temp;
always @ (posedge clk1)
begin
	if (rst1)
	begin
	en_ar<=1'b0;
	en_sh<=1'b0;
	//mem_wr_en<=1'b0;
	//mem_write_out<=1'b0;
	aluin1<={32{1'b0}};
	aluin2<={32{1'b0}};
	shift_nos<=5'b0;
	//carry<=0;
	end
	
	else if (en_ex==1'b1)
	begin
	case (en_ex)
	1'b0: begin
	aluin1<=aluin1;
	aluin2<=aluin2;
	shift_nos<=0;
	en_ar<=1'b0;
	en_sh<=1'b0;
	temp<=mem_read;
	end
	
	1'b1: begin 
	aluin1<=src1;
		begin					//aluin2
		  if (opsel==`ARITH_LOGIC)
		  begin
		  if (imm_regn)
		  aluin2<=imm;
		  else
		  aluin2<=src2;
		  end
		  
		  else if (opsel==`MEM_READ)
		  begin
		  if (imm_regn)
		  aluin2<=mem_read;
		  else
		  aluin2<=aluin2;
		  end
		
		 else
		 aluin2<=aluin2;
	      end

		begin					//shift_nos
			if (opsel==`SHIFT_REG)
			begin
			if (imm[2])
			shift_nos<=src2[4:0];
			else
			shift_nos<=imm[10:6];
			end
			
			else
			shift_nos<=0;
		end

		begin				//en_ar
			if (opsel==`ARITH_LOGIC)
			en_ar<=1'b1;
			else if (opsel==`MEM_READ)
			begin
			if (imm_regn)
			en_ar<=1'b1;
			else
			en_ar<=1'b0;
			end
			else
			en_ar<=1'b0;
		end

		begin
		if (!(opsel==`SHIFT_REG))
		en_sh<=1'b1;
		else
		en_sh<=1'b0;
		end
		  
	end
	
	endcase
	end

begin
if (rst1)
begin
carry<=0;
mem_wr_en<=0;
mem_write_out<=0;
end
else if (en_ex==1)
begin
if (!mem_read)
carry<=0;
//y<=(opsel == `MEM_WRITE) &&(imm_regn == 1);
else
begin
	case(y<=(opsel == `MEM_WRITE) &&(imm_regn == 1))
	1'b0: mem_wr_en<=1'b0;
	1'b1: mem_wr_en<=1'b1;
	endcase

mem_write_out<=temp[0];
temp<=temp>>1;
end
end
else
begin
carry<=carry;
mem_wr_en<=mem_wr_en;
mem_write_out<=mem_write_out;
end
end
end

always @ (posedge clk1)
begin
	if (rst1)
	begin 
	op<=3'b000;
	opsel<=3'b000;
	imm_regn<=1'b0;
	end
	
	else if (en_ex)
	begin
	op<=cntrl_in[6:4];
	imm_regn<=cntrl_in[3];
	opsel<=cntrl_in[2:0];
	end

	else
	begin
	op<=op;
	imm_regn<=imm_regn;
	opsel<=opsel;
	end

end

/*always @ (posedge clk1)
begin
if (rst1)
begin
carry<=0;
mem_wr_en<=0;
mem_write_out<=0;
end

else if (!mem_read)
carry<=0;
//y<=(opsel == `MEM_WRITE) &&(imm_regn == 1);
else
begin
	case(y<=(opsel == `MEM_WRITE) &&(imm_regn == 1))
	1'b0: mem_wr_en<=1'b0;
	1'b1: mem_wr_en<=1'b1;
	endcase

mem_write_out<=temp[0];
temp<=temp>>1;
end
end*/
endmodule



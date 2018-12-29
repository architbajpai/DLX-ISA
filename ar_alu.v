`define LOADBYTE 3'b000
`define LOADBYTEU 3'b100
`define LOADHALF 3'b001
`define LOADHALFU 3'b101
`define LOADWORD 3'b011

`define ADD 3'b000
`define HADD 3'b001
`define SUB 3'b010
`define NOT 3'b011
`define AND 3'b100
`define OR 3'b101
`define XOR 3'b110
`define LHG 3'b111

`define ARITH_LOGIC 3'b001
`define MEM_READ 3'b101

module ar_alu
(input clk2, rst2, en_ar,
input [31:0] aluin1,aluin2,
input [2:0] aluop,alusel,
input [4:0] shift_nos,
output reg carry,
output reg [31:0] aluout_ar);

reg [16:0] htemp;
reg [31:0] a1,b1,s1;
reg [31:0] c1,d1,s2;
always @ (posedge clk2)
begin
	if (rst2)
	begin
	carry<=0;
	aluout_ar<=0;
	end

	else if (en_ar==1)
	begin
	if (alusel==`ARITH_LOGIC)
		begin
			case(aluop)
			`ADD: begin
				aluout_ar<=add(aluin1,aluin2);
				end
			
			`HADD: begin
				htemp<=aluin1[15:0]+aluin2[15:0];
				carry<=htemp[16];
				aluout_ar<={f1(htemp[15]),htemp[15:0]};
				end
			`SUB:begin
				aluout_ar<=sub(aluin1,aluin2);
				end
			`NOT: begin
				aluout_ar<=~aluin2;
				carry<=0;
				end
			`AND: begin
				aluout_ar<=aluin1&aluin2;
				carry<=0;
				end
			`OR: begin
				aluout_ar<=aluin1|aluin2;
				carry<=0;
				end
			`XOR: begin
				aluout_ar<=aluin1^aluin2;
				carry<=0;
				end
			`LHG: begin
				aluout_ar<={aluin2[15:0],f1(0)};
				carry<=0;
				end
			endcase
		end


	else if (alusel==`MEM_READ)
	begin
		case(aluop)
		`LOADBYTE:
		begin 
			aluout_ar<={f2(aluin2[7]),aluin2[7:0]};
			carry<=0;
		end
	       `LOADBYTEU:
		begin 
			aluout_ar<={f2(0),aluin2[7:0]};
			carry<=0;
		end
		`LOADHALF:
		begin 
			aluout_ar<={f1(aluin2[7]),aluin2[15:0]};
			carry<=0;
		end
		`LOADHALFU:
		begin 
			aluout_ar<={f1(0),aluin2[15:0]};
			carry<=0;
		end
		`LOADWORD:
		begin
			aluout_ar<=aluin2;
			carry<=0;
		end
		default:
		begin
			aluout_ar<=aluin2;
			carry<=0;
		end	
		endcase
	end

	else
		begin
			aluout_ar<=aluout_ar;
			carry<=carry;
		end
end
else 
begin
aluout_ar<=aluout_ar;
carry<=carry;
end
end
function [15:0] f1
(input s);
f1={16{s}};
endfunction

function [24:0] f2
(input y);
f2={25{y}};
endfunction

function [31:0] add
(input [31:0] a,b);
begin

a1=~a;
a1=a1+1;
b1=~b;
b1=b1+1;
s1=a1+b1;
s1=~s1;
add=s1+1;
end
endfunction

function [31:0] sub
(input [31:0] c,d);
begin

c1=~c;
c1=c1+1;
d1=~d;
d1=d1+1;
s2=c1-d1;
s2=~s2;
sub=s2+1;
end
endfunction

endmodule
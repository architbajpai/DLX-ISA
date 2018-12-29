`define SHLEFTLOG 3'b000
`define SHLEFTART 3'b001
`define SHRGHTLOG 3'b010
`define SHRGHTART 3'b011

module shift_alu
(input clk2, rst2, en_sh,
input [31:0] in,
input [2:0] shift,shift_op,
input [4:0] shift_nos,
output reg [31:0] aluout_sh,
output reg carry);
reg s;
//reg [7:0] sh=8'b00000000;
reg [31:0] a,b;

always @ (posedge clk2)
begin
	if (rst2)
	begin
	aluout_sh<=0;
	carry<=0;
	//a<=in;
	end
	
	else if (en_sh)
	begin
	s<=in[31];
		case (shift_op)
		`SHLEFTLOG: begin 
				a<=in<<shift;
				carry<=0;
				end
		`SHLEFTART:begin
				a<=in<<shift;
				if (s)
				carry<=1;
				else
				carry<=0;
				end 
		`SHRGHTLOG: begin 
				a<=in>>shift; 
				carry<=0;
				end
		`SHRGHTART: begin
				//a<={shift{in[31]},in[31-shift:0]
				
				carry<=0;
				b<=in>>shift;
				if (s)
				begin
				a<={sh(shift),b[23:0]};
				end
				else
				a<=b;
				//a<={shift{1'b0},b[31-shift:0]};
			    end
			//default: aluout_sh<=a;
		endcase
	aluout_sh<=a;
	end

	else
	aluout_sh<=aluout_sh;
end

function [7:0] sh
				(input [2:0] shift);
				case(shift)
				3'b000:sh=8'b00000000;
				3'b001:sh=8'b11000000;
				3'b010:sh=8'b11100000;
				3'b011:sh=8'b11110000;
				3'b100:sh=8'b11111000;
				3'b101:sh=8'b11111100;
				3'b110:sh=8'b11111110;
				3'b111:sh=8'b11111111;
				endcase
				endfunction

endmodule

				

	


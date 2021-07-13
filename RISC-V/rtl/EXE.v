`timescale 1ns / 1ps

module EXE(
input [31:0] rda_EX,
input [31:0] rdb_EX,
input [31:0] imm_EX,
input 		 ALUsrc, //control
input [1:0]	 ALUOP,
input funct7,
input [2:0]	funct3,
//forwarding part
input forwardA,forwardB,
input [31:0]	wdata_WB,

output wire[31:0] alu_result

	
);




reg 	[31:0] a ;
reg 	[31:0] b ;
wire	[3:0] operation;

alu_32bit alu_32bit(
.alu_src1(a),		//
.alu_src2(b),		//
.alu_control(operation),
//output
.alu_result(alu_result)
);

alu_control alu_control(
.instr_30(funct7), //Instruction[30]
.func3(funct3), //Instruction[14:12]
.ALUOP(ALUOP), //from control
//output
.ALU_control(operation)
);


always@(*)
begin
		
		case(forwardA)
		1'b0:a <= rda_EX;
		1'b1:a <= wdata_WB;	
	 default:a <= rda_EX;		
		endcase

		
		
		case (ALUsrc)
		1'b0:
		begin
			case(forwardB)
				1'b0:b <= rdb_EX;
				1'b1:b <= wdata_WB;
			 default:b <= rdb_EX;
			endcase
		end	
			
		1'b1:b <= imm_EX;
	 default:b <= 32'd0	;
				endcase
		
		

	
	
end
endmodule
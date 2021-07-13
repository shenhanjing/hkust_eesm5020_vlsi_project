`timescale 1ns / 1ps

module DEC(
input 			clk,
input	[31:0] 	instr,
input 			regwrite_WB, 		//reg_write enable
input 	[4:0] 	wa_WB,				//write adddress
input 	[31:0] 	wdata,				//write	data


//EX_REG_input_wire-------------------------------------------------

	//register_file_output 
output wire 	[31:0]	rda,rdb, 
	//immediate_generator_output_
output wire 	[31:0]	imm,
	//1_control_signal_output
output wire			ALUsrc,	   //EX signal
output wire			[1:0] ALUOP,//EX signal
output wire			regwrite,memtoreg, 		   //WB signal
output wire			memread,memwrite,branch,   //MEM signal
	// from ID_REG propagate to EX_REG_
output wire			[4:0]	wa, 	
output wire         [2:0]	funct3,
output wire         		funct7,
	// from ID_REG propagate to EX_REG_for forwarding
output wire			[4:0]	ra1, 
output wire			[4:0]	ra2


//----------------------------------------------------------------
);
// from ID_REG propagate to EX_REG_
assign 	wa 		= 	instr[11:7];
assign 	funct3	=	instr[14:12];
assign	funct7 	=  	instr[30];
assign 	ra1 	= 	instr[19:15];
assign 	ra2 	= 	instr[24:20];
// register file----------------------------------------
regfile regfile (
//input
	.clk(clk), 
	.ra1(ra1),
	.ra2(ra2),
	//
	.wa(wa_WB),
	.en_write(regwrite_WB),
	.wdata(wdata),
	
//output
	.rd1(rda),
	.rd2(rdb)
);
//------------------------------------------------------------

//immediate_generator----------------------------------------
ImmGen ImmGen(
.instr(instr),
//output
.imm_out(imm)

);
//------------------------------------------------------------

//control signal genrator---------------------------------

control control(

.opcode(instr[6:0]),
//output

.ALUsrc(ALUsrc),.ALUOP(ALUOP),			//EX signal
 	
.regwrite(regwrite),.memtoreg(memtoreg),  //WB signal

.memread(memread),.memwrite(memwrite),.branch(branch)	 //MEM signal


);

//------------------------------------------------------------

endmodule



/*module control (
input wire [6:0] instr,
output reg			ALUsrc,ALUOP1,ALUOP0, 		   //EX signal
output reg			regwrite,memtoreg,  		   //WB signal
output reg			memread,memwrite,branch	   	   //MEM signal
);


always@(*)
    begin

        case (instr[6:0])
		7'b0110011:      //R
			begin
			regwrite <= 1'b1;
			memtoreg <= 1'b0;
			ALUsrc	 <= 1'b0;
			ALUOP1	 <= 1'b1;
			ALUOP0	 <= 1'b0;
			end
		7'b0010011: 		//IMM
			begin		
			regwrite <= 1'b1;
			memtoreg <= 1'b0;
			ALUsrc	 <= 1'b1;
			ALUOP1	 <= 1'b1; 
			ALUOP0	 <= 1'b1;
			end
		
		default : 
			begin
			regwrite <= 1'b0;
			memtoreg <= 1'b0;
			ALUsrc   <= 1'b0;
			ALUOP1   <= 1'b0;
			ALUOP0   <= 1'b0;
			end
			
        endcase
		
	end
endmodule */
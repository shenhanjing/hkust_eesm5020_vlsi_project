`timescale 1ns / 1ps
/*`include "../rtl/REG_WB.v"
`include "../rtl/REG_ID.v"
`include "../rtl/REG_EX.v"
`include "../rtl/regfile.v"
`include "../rtl/ImmGen.v"
`include "../rtl/control.v"
`include "../rtl/alu_32bit.v"
`include "../rtl/alu_control.v" */


module RISC_V(
	input wire	[31:0]	in,		// instruction in
	input wire clk,
	output  [31:0] alu_output_data
);

//-------------------------------------------------------------
//1. REG_output wire----ID_block_input_wire-----------------
 wire 	[31:0] 	instr;
//-------------------------------------------------------------





//-------------------------------------------------------------
//2.EX_REG_input_wire------------------------------------------

	//register_file_output & immediate_generator_output_
 wire 	[31:0]	rda,rdb,imm; 	
	// ID_REG propagate to EX_REG
 wire  	[4:0]	wa;		//	write address
 wire 			funct7;		//  for 2_control
 wire 	[2:0]	funct3;		//	for 2_control
	//1_control_signal_output
 wire			ALUsrc; 		   //EX signal
 wire	[1:0]	ALUOP; 		   //EX signal
 wire			memread,memwrite,branch;	   //MEM signal
 wire			regwrite,memtoreg;  		   //WB signal
wire	[4:0]	ra1; 
wire	[4:0]	ra2;

// EX REG_output_wire----------------
	// read_data_a_in_EX, read_data_b_in_EX, _immediate_number
wire  	[31:0]	rda_EX,rdb_EX,imm_EX;	
	// ID_REG propagate to EX_REG
wire  	[4:0] 	wa_EX; 					
wire  		 	funct7_EX;
wire  	[2:0] 	funct3_EX; 
	// Control signal in EX
wire  			ALUsrc_EX;	
wire  	[1:0]	ALUOP_EX;	
wire 			memread_EX,memwrite_EX,branch_EX; 
wire  			regwrite_EX,memtoreg_EX;	  	
wire  	[4:0]	ra1_EX;
wire  	[4:0]	ra2_EX;

//----------------------------------------------------------------

reg 	[31:0] a ;
reg 	[31:0] b ;
wire	[3:0] operation;



//forwarding unit output to EXE input
wire forwardA ;
wire forwardB ;
//

//-------------------------------------------------------------
//3. WB_REG_input_wire---------------------------

wire [31:0]	alu_result;
//WB_REG_output_wire---------------------------
wire  	[4:0] 	wa_WB; 	
wire	[31:0]	wdata_WB;
wire  			regwrite_WB,memtoreg_WB;
 //--------------------------------------------------------------

assign alu_output_data = wdata_WB;
assign 	wa 		= 	instr[11:7];
assign 	funct3	=	instr[14:12];
assign	funct7 	=  	instr[30];
assign 	ra1 	= 	instr[19:15];
assign 	ra2 	= 	instr[24:20];


//ID_REG_out-----------------------------------------------------
REG_ID REG_ID (
	.clk(clk),
	.in(in),
	//output
	.instr(instr)
);
//-------------------------------------------------------------


// register file----------------------------------------
regfile regfile (
//input
	.clk(clk), 
	.ra1(ra1),
	.ra2(ra2),
	//
	.wa(wa_WB),
	.en_write(regwrite_WB),
	.wdata(wdata_WB),
	
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







//EX_REG----------------------------------
REG_EX REG_EX(
	//input-----------------------------------
	.clk(clk),
		//register_file_output a,b & immediate_generator_output_
	.rda(rda),.rdb(rdb),.imm(imm),
		// ID_REG propagate to EX_REG
	.funct7(funct7), .funct3(funct3),
	.wa(wa), 
		//1_control_signal_output
			//EX signal
	.ALUsrc(ALUsrc), .ALUOP(ALUOP), 
			//MEM signal
	.memread(memread), .memwrite(memwrite), .branch(branch),	
			//WB signal
	.regwrite(regwrite), .memtoreg(memtoreg),
	.ra1(ra1),
	.ra2(ra2),

	//output--------------------
	.rda_EX(rda_EX), .rdb_EX(rdb_EX), .imm_EX(imm_EX),
	.funct7_EX(funct7_EX), .funct3_EX(funct3_EX),
	.wa_EX(wa_EX), 
	//control
		//EX
	.ALUsrc_EX(ALUsrc_EX),.ALUOP_EX(ALUOP_EX), 	
		//MEM
	.memread_EX(memread_EX),.memwrite_EX(memwrite_EX),.branch_EX(branch_EX),
			//WB
	.regwrite_EX(regwrite_EX),.memtoreg_EX(memtoreg_EX),	 
	
	.ra1_EX(ra1_EX),
	.ra2_EX(ra2_EX)
);
//-------------------------------------------------------------



alu_32bit alu_32bit(
.alu_src1(a),		//
.alu_src2(b),		//
.alu_control(operation),
//output
.alu_result(alu_result)
);

alu_control alu_control(
.instr_30(funct7_EX), //Instruction[30]
.func3(funct3_EX), //Instruction[14:12]
.ALUOP(ALUOP_EX), //from control
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

		
		
		case (ALUsrc_EX)
		1'b0:
		begin
			case(forwardB)
				1'b0:b <= rdb_EX;
				1'b1:b <= wdata_WB;
			 default:b <= rdb_EX;
			endcase
		end	
			
		1'b1:b <= imm_EX;
	 default:b <= rdb_EX	;
				endcase

end






//-WB_REG------------------------------------------------------------
REG_WB REG_WB(
//input
.clk(clk),
.wdata(alu_result),
//	REG_EX propagate to REG_WB
.wa(wa_EX),
		//WB
.regwrite(regwrite_EX),
.memtoreg(memtoreg_EX),	


//output
//TO register file........
.wa_WB(wa_WB),
.wdata_WB(wdata_WB),
.regwrite_WB(regwrite_WB),
//.........................
.memtoreg_WB(memtoreg_WB)
);


//-------------------------------------------------------------

Forward Forward(
//input
.regwrite_WB(regwrite_WB),
.wa_WB(wa_WB) ,	
.ra1_EX(ra1_EX),
.ra2_EX(ra2_EX),

//output
.forwardA(forwardA),
.forwardB(forwardB)
);



endmodule


module Forward(
input wire		regwrite_WB,
input wire [4:0] wa_WB,
input wire [4:0]ra1_EX,
input wire [4:0]ra2_EX,
	
output wire forwardA,forwardB

);

assign forwardA = ((wa_WB == ra1_EX)&(regwrite_WB)&(wa_WB != 5'b0));
assign forwardB = ((wa_WB == ra2_EX)&(regwrite_WB)&(wa_WB != 5'b0));


endmodule





/*module control(
    input wire [6:0]	opcode, //Instruction[6:0]

    output reg ALUsrc, //Selects the second source operand for the ALU (0-Immediate; 1-rs2).
    output reg [1:0] ALUOP, //Either specifies the ALU operation to be performed or specifies that the operation should be determined from the function bits.
	output reg			regwrite,memtoreg,  		   //WB signal
    //memtoreg: Selects the source value for the register write as either the ALU result or memory.
    //regwrite: Asserted if a result needs to be written to a register.
	output reg			memread,memwrite,branch	   	//MEM signal---will not be used in this project
);

always@(*) begin

        case (opcode[6:0])
		7'b0110011:      //R-type opcode
			begin
			regwrite <= 1'b1;
			memtoreg <= 1'b0;
			ALUsrc	 <= 1'b0; //select rs2
			ALUOP 	 <= 2'b10;//
			
			memread  <=  1'b0;
			memwrite <=  1'b0;
			branch   <=  1'b0;
			end
		7'b0010011: 	//Imm -type opcode
			begin		
			regwrite <= 1'b1;
			memtoreg <= 1'b0;
			ALUsrc	 <= 1'b1;	//select Imm
			ALUOP 	 <= 2'b11;
			
		    memread  <=  1'b0;
			memwrite <=  1'b0;
			branch   <=  1'b0;
			end
		7'b0110111: 	//LUI
			begin		
			regwrite <= 1'b1;
			memtoreg <= 1'b0;
			ALUsrc	 <= 1'b1;	//select Imm
			ALUOP 	 <= 2'b01;
			
		    memread  <=  1'b0;
			memwrite <=  1'b0;
			branch   <=  1'b0;			
			
			end
		
		default : 
			begin
			regwrite <= 1'b0;
			memtoreg <= 1'b0;
			ALUsrc   <= 1'b0;
			ALUOP = 2'b00;
		    memread  <=  1'b0;
			memwrite <=  1'b0;
			branch   <=  1'b0;			
			
			
			end
			
        endcase


end

endmodule
*/






/*//decoding part----------------------------------------------
DEC DEC(
//input
	.clk(clk),
	//FROM REG_ID
	.instr(instr),
	//FROM REG_WB
	.regwrite_WB(regwrite_WB),
	.wa_WB(wa_WB),		
	.wdata(wdata_WB),
	
//output
		//register_file_output a,b & immediate_generator_output_
	.rda(rda),.rdb(rdb),.imm(imm),
		//1_control_signal_output		
	.ALUsrc(ALUsrc), .ALUOP(ALUOP), 		//EX signal		
	.memread(memread), .memwrite(memwrite), .branch(branch), //MEM signal
	.regwrite(regwrite), .memtoreg(memtoreg),			//WB signal
	
	.funct7(funct7), .funct3(funct3),
	.wa(wa),
	.ra1(ra1),
	.ra2(ra2)
	
	
);
//-------------------------------------------------------------
*/














/*//execution part----------------------------
EXE EXE(
//input
		// data
	.rda_EX(rda_EX),.rdb_EX(rdb_EX),.imm_EX(imm_EX),
		// data_select_signal
	.ALUsrc(ALUsrc_EX),	
		//for generate 2L_control
	.ALUOP(ALUOP_EX),	
	.funct7(funct7_EX), .funct3(funct3_EX),
		//forwarding part
	.forwardA(forwardA),.forwardB(forwardB),
	.wdata_WB(wdata_WB),
	
//output
	.alu_result(alu_result)
	
);
//-------------------------------------------------------------
*/
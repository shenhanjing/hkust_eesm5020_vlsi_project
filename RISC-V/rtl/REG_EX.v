`timescale 1ns / 1ps

module REG_EX(
input wire 	clk,
input wire	[31:0]	rda,rdb,imm,					// 
input wire  [4:0]	wa, 							//writeaddress
input wire 			funct7,
input wire 	[2:0]	funct3,
input wire			ALUsrc, 		   //EX signal
input wire	[1:0]	ALUOP, 		   		//EX signal
input wire			regwrite,branch,	  		   //WB signal
input wire			memread,memwrite,memtoreg,	   //WB signal
	// from ID_REG propagate to EX_REG_for forwarding
input wire			[4:0]	ra1, 
input wire			[4:0]	ra2,


output reg  [31:0] 	rda_EX,rdb_EX,imm_EX,
output reg  [4:0]	wa_EX,
output reg			funct7_EX,
output reg  [2:0]	funct3_EX,
output reg  		ALUsrc_EX, 		//EX signal store in REG_EX
output reg  [1:0]	ALUOP_EX, 		//EX signal store in REG_EX
output reg  		regwrite_EX,branch_EX,	  		    //WB signal	store in REG_EX
output reg  		memread_EX,memwrite_EX,memtoreg_EX,  //WB signal store in REG_EX
output reg  [4:0]	ra1_EX,
output reg  [4:0]	ra2_EX
);


always@(posedge clk)
begin

rda_EX	<=	rda		;		
rdb_EX	<=	rdb		;
imm_EX	<=	imm		;
wa_EX   <=   wa     ;
funct7_EX    <=   funct7    	;
funct3_EX    <=   funct3     	;

//control signal..................................//
//EX signal store in REG_EX....................
ALUsrc_EX		<=	ALUsrc	;
ALUOP_EX       <=	ALUOP	;

//.........................................

//WB signal	store in REG_EX........................   
regwrite_EX 	<=  regwrite ;
branch_EX  		<=  branch   ;	
//.........................................

//WB signal store in REG_EX..................

memread_EX	<=	memread		;
memwrite_EX <=	memwrite	;
memtoreg_EX	<=	memtoreg    ;
//.........................................	

ra1_EX	<=  ra1 ;
ra2_EX	<=  ra2 ;	

end


endmodule
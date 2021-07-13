// =============================================================================
// Filename: control.v
// -----------------------------------------------------------------------------
// This file implements the control model.
// =============================================================================

module control(
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
			ALUOP    <= 2'b00;
		    memread  <=  1'b0;
			memwrite <=  1'b0;
			branch   <=  1'b0;			
			
			
			end
			
        endcase


end

endmodule




 /*   if(opcode==7'b0110011) begin //R-type
        ALUsrc = 0; //rs2
        ALUOP = 2'b10;
    end
    else if(opcode==7'b0010011) begin //I-type except CSRRW and CSRRWI
        ALUsrc = 1; //Imm
        ALUOP = 2'b11;
    end
    else if(opcode==7'b1110011) begin //CSRRW and CSRRWI
        ALUsrc = 0; //Imm
        ALUOP = 2'b00;
    end
    else begin //other situation
        ALUsrc = 0;
        ALUOP = 2'b00;
    end
	*/

// =============================================================================
// Filename: alu_control.v
// -----------------------------------------------------------------------------
// This file implements a ALU control.
// =============================================================================

module alu_control(
    input wire          instr_30, //Instruction[30]
    input wire [2:0]    func3, //Instruction[14:12]
    input wire [1:0]    ALUOP, //from control

    output reg [3:0]    ALU_control
);

always@(*) begin
    if(ALUOP==2'b10) begin //R-type
        case(func3)
            3'b000:ALU_control = instr_30 ? 4'b0110 : 4'b0010; //ADD and SUB
            3'b001:ALU_control = 4'b1000; //SLL
            3'b010:ALU_control = 4'b1100; //SLT
            3'b011:ALU_control = 4'b1101; //SLTU
            3'b100:ALU_control = 4'b0011; //XOR
            3'b101:ALU_control = instr_30 ? 4'b1011:4'b1010   ; //1011:SRA  1010:SRL  
            3'b110:ALU_control = 4'b0001; //OR
            3'b111:ALU_control = 4'b0000; //AND
            default: ALU_control = 4'b1111; //ERROR
        endcase
    end
    else if(ALUOP==2'b11) begin //I-type except CSRRW and CSRRWI
        case(func3)
            3'b000:ALU_control = 4'b0010; //ADDI
            3'b001:ALU_control = 4'b1000; //SLLI
            3'b010:ALU_control = 4'b1100; //SLTI
            3'b011:ALU_control = 4'b1101; //SLTIU
            3'b100:ALU_control = 4'b0011; //XORI
            3'b101:ALU_control = instr_30 ? 4'b1011:4'b1010 ; //1011:SRAI  1010:SRLI  
            3'b110:ALU_control = 4'b0001; //ORI
            3'b111:ALU_control = 4'b0000; //ANDI
           default:ALU_control = 4'b1111; //ERROR
        endcase
    end
    else if(ALUOP==2'b01) begin
        ALU_control = 4'b1110; //LUI
    end
    else if(ALUOP==2'b00) begin //CSRRW and CSRRWI
        case(func3)
            3'b001:ALU_control =  4'b1111    ; //CSRRW -先设置为 error
            3'b101:ALU_control =  4'b1111      ; //CSRRWI -先设置为 error
        endcase
    end
    else begin
        
    end
end

endmodule
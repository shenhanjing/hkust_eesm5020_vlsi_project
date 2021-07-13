`timescale 1ns / 1ps

module ImmGen(
input [31:0] instr,
output reg[31:0] imm_out

);

always@(*)
begin
        case (instr[6:0])
		7'b0010011: 
			begin						
			if(instr[14:12]==3'b101) begin    //for imm shift
				imm_out[5:0] <= instr[25:20];
				imm_out[31:6] <= 26'd0;
			end
			else begin							// for imm number operation
				imm_out[11:0] <= instr[31:20];
				if(instr[31])
				imm_out[31:12] <= 20'hfffff;	   // minus 
				else
				imm_out[31:12] <= 20'd0;
			end
		end
		7'b0110111:
		begin
			imm_out[19:0] <= instr[31:12];
			imm_out[31:20] <= 12'd0;
		end
		
        default : 
		begin
			imm_out[31:0] <= 32'd0;
		end	
        endcase
		
		
end
endmodule
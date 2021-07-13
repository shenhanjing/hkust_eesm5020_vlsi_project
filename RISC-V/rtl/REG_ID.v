`timescale 1ns / 1ps

module REG_ID(
input wire clk,
input wire	[31:0]	in,		
output reg [31:0] instr 

);

always@(posedge clk)
begin
	instr  <= in;
end


endmodule
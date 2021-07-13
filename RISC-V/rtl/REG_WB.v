`timescale 1ns / 1ps

module REG_WB(
input wire clk,
input wire	[31:0]	wdata,		
input wire	[4:0]	wa,
input wire			regwrite,memtoreg,



output reg	[31:0]	wdata_WB,
output reg	[4:0]	wa_WB,
output reg 			regwrite_WB,memtoreg_WB

);

always@(posedge clk)
begin
	wdata_WB  		<= 	wdata;
	wa_WB			<=	wa        ;
	regwrite_WB		<=	regwrite  ;
	memtoreg_WB 	<=	memtoreg  ;
end


endmodule
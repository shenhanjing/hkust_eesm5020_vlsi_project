// =============================================================================
// Filename: fir_16tap_tb.v
// Author: SHEN Hanjing
// Email: hshenag@connect.ust.hk
// Affiliation: Hong Kong University of Science and Technology
// -----------------------------------------------------------------------------
// This file exports the testbench for fir_16tap.
// =============================================================================

`timescale 1 ns / 1 ps

module fir_16tap_tb;

// ----------------------------------
// Local parameter declaration
// ----------------------------------
localparam CLK_PERIOD = 200.0;  // clock period: 200ns

// ----------------------------------
// Interface of the module
// ----------------------------------
reg clk, rst;
reg [15:0] xin;
wire [35:0] yout;

// ----------------------------------
// Instantiate the module
// ----------------------------------
fir_16tap uut (
	.clk		(clk),
	.rst		(rst),

	.xin		(xin),

	.yout		(yout)
);

// ----------------------------------
// Clock generation
// ----------------------------------
initial begin
  clk = 1'b0;
  forever #(CLK_PERIOD/2.0) clk = ~clk;
end

// ----------------------------------
// Input stimulus
// ----------------------------------
initial begin
	// Reset
	rst		= 1'b1;
	xin		= 16'd0;
	#(2*CLK_PERIOD) rst = 1'b0;

	// Input stimulus
	#CLK_PERIOD; xin = 16'd0;
	#CLK_PERIOD; xin = 16'd1;
	#CLK_PERIOD; xin = 16'd2;
	#CLK_PERIOD; xin = 16'd3;
	#CLK_PERIOD; xin = 16'd4;
	#CLK_PERIOD; xin = 16'd5;
	#CLK_PERIOD; xin = 16'd6;
	#CLK_PERIOD; xin = 16'd7;
	#CLK_PERIOD; xin = 16'd8;
	#CLK_PERIOD; xin = 16'd9;
	#CLK_PERIOD; xin = 16'd10;
	#CLK_PERIOD; xin = 16'd11;
	#CLK_PERIOD; xin = 16'd12;
	#CLK_PERIOD; xin = 16'd13;
	#CLK_PERIOD; xin = 16'd14;
	#CLK_PERIOD; xin = 16'd15;

	// Finish the testbench
	#(CLK_PERIOD*2);
	$finish;
end

endmodule

// =============================================================================
// Filename: fir_16tap.v
// -----------------------------------------------------------------------------
// This file implements a simple 16-tap FIR filter.
// =============================================================================

// ----------------------------------------------------
// Part I: 16-tap FIR filter
// ----------------------------------------------------
module fir_16tap (
	input wire				clk,          // system clock
	input wire              rst,          // system reset (active high)

	input wire signed	[15:0]		xin,		// input signal

	output wire signed	[35:0]		yout		// output signal
);

//use "wire" to define internal signals
wire signed [15:0]	x_n0,x_n1,x_n2,x_n3,x_n4,x_n5,x_n6,x_n7,x_n8,x_n9,x_n10,x_n11,x_n12,x_n13,x_n14,x_n15;
wire signed [31:0]	y0,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15;
wire signed [15:0] a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15;

assign	a0 = 16'd0;			// coefficient a0
assign	a1 = 16'd1;			// coefficient a1
assign	a2 = 16'd2;			// coefficient a2
assign	a3 = 16'd3;			// coefficient a3
assign	a4 = 16'd4;			// coefficient a4
assign	a5 = 16'd5;			// coefficient a5
assign	a6 = 16'd6;			// coefficient a6
assign	a7 = 16'd7;			// coefficient a7
assign	a8 = 16'd8;			// coefficient a8
assign	a9 = 16'd9;			// coefficient a9
assign	a10 = 16'd10;			// coefficient a10
assign	a11 = 16'd11;			// coefficient a11
assign	a12 = 16'd12;			// coefficient a12
assign	a13 = 16'd13;			// coefficient a13
assign	a14 = 16'd14;			// coefficient a14
assign	a15 = 16'd15;			// coefficient a15

assign x_n0=xin;
dff dff1(.rst(rst),.clk(clk),.d(x_n0[15:0]),.q(x_n1[15:0]));
dff dff2(.rst(rst),.clk(clk),.d(x_n1[15:0]),.q(x_n2[15:0]));
dff dff3(.rst(rst),.clk(clk),.d(x_n2[15:0]),.q(x_n3[15:0]));
dff dff4(.rst(rst),.clk(clk),.d(x_n3[15:0]),.q(x_n4[15:0]));
dff dff5(.rst(rst),.clk(clk),.d(x_n4[15:0]),.q(x_n5[15:0]));
dff dff6(.rst(rst),.clk(clk),.d(x_n5[15:0]),.q(x_n6[15:0]));
dff dff7(.rst(rst),.clk(clk),.d(x_n6[15:0]),.q(x_n7[15:0]));
dff dff8(.rst(rst),.clk(clk),.d(x_n7[15:0]),.q(x_n8[15:0]));
dff dff9(.rst(rst),.clk(clk),.d(x_n8[15:0]),.q(x_n9[15:0]));
dff dff10(.rst(rst),.clk(clk),.d(x_n9[15:0]),.q(x_n10[15:0]));
dff dff11(.rst(rst),.clk(clk),.d(x_n10[15:0]),.q(x_n11[15:0]));
dff dff12(.rst(rst),.clk(clk),.d(x_n11[15:0]),.q(x_n12[15:0]));
dff dff13(.rst(rst),.clk(clk),.d(x_n12[15:0]),.q(x_n13[15:0]));
dff dff14(.rst(rst),.clk(clk),.d(x_n13[15:0]),.q(x_n14[15:0]));
dff dff15(.rst(rst),.clk(clk),.d(x_n14[15:0]),.q(x_n15[15:0]));

assign y0=x_n0*a0;
assign y1=x_n1*a1;
assign y2=x_n2*a2;
assign y3=x_n3*a3;
assign y4=x_n4*a4;
assign y5=x_n5*a5;
assign y6=x_n6*a6;
assign y7=x_n7*a7;
assign y8=x_n8*a8;
assign y9=x_n9*a9;
assign y10=x_n10*a10;
assign y11=x_n11*a11;
assign y12=x_n12*a12;
assign y13=x_n13*a13;
assign y14=x_n14*a14;
assign y15=x_n15*a15;
assign yout=y0+y1+y2+y3+y4+y5+y6+y7+y8+y9+y10+y11+y12+y13+y14+y15;

endmodule

// ----------------------------------------------------

// ----------------------------------------------------
// Part II:  DFF - the delay element. It be a D flip flop controlled by the clock signal.
// ----------------------------------------------------
module dff (
	input		rst,		//reset Signal (active high)
	input		clk,		//clock
	input		[15:0]		d,
	output reg	[15:0] 		q
);  
  
always @ (posedge clk) begin
	if (rst)
		q <= 0;  
    else
		q <= d;
end

endmodule  
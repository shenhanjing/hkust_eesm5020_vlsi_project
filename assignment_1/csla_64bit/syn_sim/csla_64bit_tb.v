// =============================================================================
// Filename: csla_64bit_tb.v
// -----------------------------------------------------------------------------
// This file exports the testbench for csla_64bit.
// =============================================================================

`timescale 1 ns / 1 ps

module csla_64bit_tb;

// ----------------------------------
// Interface of the module
// ----------------------------------
reg		[63:0]	a, b;
reg 			cin;
wire 	[63:0]	sum;
wire			cout;

// ----------------------------------
// Instantiate the module
// ----------------------------------
csla_64bit uut (
	.a(a),
	.b(b), 
	.cin(cin), 
	.sum(sum),
	.cout(cout)
);

initial begin
  $sdf_annotate("csla_64bit.sdf", uut);
end
// ----------------------------------
// Input stimulus
// ----------------------------------
initial begin
	// // Input stimulus 1: 10+35+0
	// a    = 64'd10;
	// b    = 64'd35;
	// cin  = 1'b0;
	// #10;
	// $display("%0d + %0d + %0d: sum = %0d, cout = %0d, This should be 45.", a, b, cin, sum, cout);

	// // Input stimulus 2: 23+132+1
	// a    = 64'd23;
	// b    = 64'd132;
	// cin  = 1'b1;
	// #10;
	// $display("%0d + %0d + %0d: sum = %0d, cout = %0d, This should be 156.", a, b, cin, sum, cout);

	// // Input stimulus 3: 3846+9654+0
	// a    = 64'd3846;
	// b    = 64'd9654;
	// cin  = 1'b0;
	// #10;
	// $display("%0d + %0d + %0d: sum = %0d, cout = %0d, This should be 13500.", a, b, cin, sum, cout);

	// // Input stimulus 4: 866945+3324752+1
	// a    = 64'd866945;
	// b    = 64'd3324752;
	// cin  = 1'b1;
	// #10;
	// $display("%0d + %0d + %0d: sum = %0d, cout = %0d, This should be 4191698.", a, b, cin, sum, cout);

	// // Input stimulus 5: 6223372036854775808‬+38701384792384+1
	// a    = 64'd6223372036854775808;
	// b    = 64'd38701384792384;
	// cin  = 1'b1;
	// #10;
	// $display("%0d + %0d + %0d: sum = %0d, cout = %0d, This should be 6223410738239568193.", a, b, cin, sum, cout);

	// Input stimulus 6: 145+8554+0
	a    = 64'd145;
	b    = 64'd8554;
	cin  = 1'b0;
	#10;
	$display("%0d + %0d + %0d: sum = %0d, cout = %0d, This should be 8699.", a, b, cin, sum, cout);

	// Input stimulus 7: 5476543+45634245667+1
	a    = 64'd5476543;
	b    = 64'd45634245667;
	cin  = 1'b1;
	#10;
	$display("%0d + %0d + %0d: sum = %0d, cout = %0d, This should be 45639722211.", a, b, cin, sum, cout);

	// Input stimulus 8: 45+34685+0
	a    = 64'd45;
	b    = 64'd34685;
	cin  = 1'b0;
	#10;
	$display("%0d + %0d + %0d: sum = %0d, cout = %0d, This should be 34730.", a, b, cin, sum, cout);

	$finish;
end

endmodule

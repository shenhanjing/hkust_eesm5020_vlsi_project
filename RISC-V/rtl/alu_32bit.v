// =============================================================================
// Filename: alu_32bit.v
// -----------------------------------------------------------------------------
// This file implements a 32-bit ALU.
// =============================================================================

// ----------------------------------------------------
// Part I: 32-bit ALU
// ----------------------------------------------------
module alu_32bit (
	input wire  [31:0]	alu_src1,		// the first operand
	input wire  [31:0]	alu_src2,		// the second operand
	input wire [3:0]	alu_control,	//0000-AND; 0001-OR; 0010-ADD; 0011-XOR; 0110-sub; 1000-SLL ; 1010-SRL; 1011-SRA; 1100-SLT; 1101-SLTU;1110-lui

	output reg [31:0]	alu_result		// ALU result
);

	wire alu_add = (alu_control==4'b0010) ? 1'b1 : 1'b0 ;

	wire [31:0] add_sub_result; //加减结果，减法用加法来实现
	wire [31:0] slt_result;     //
	wire [31:0] sltu_result;    //
	wire [31:0] and_result;
	wire [31:0] or_result;
	wire [31:0] xor_result;
	wire [31:0] sll_result;
	wire [31:0] srl_result;
	wire [31:0] sra_result;
	wire [31:0] lui_result;

	wire signed [31:0] temp_src1;   //带符号数的临时变量
    assign temp_src1 = alu_src1;    //方便后面对alu_src1进行算数右移

	wire [31:0] adder_operand1;
    wire [31:0] adder_operand2;
    wire        adder_cin     ;
    wire [31:0] adder_result  ;
    wire        adder_cout    ;
    assign adder_operand1 = alu_src1; 
    assign adder_operand2 = alu_add ? alu_src2 : ~alu_src2; 
    assign adder_cin      = ~alu_add;  
    adder adder_module(
    .a		(adder_operand1),
    .b		(adder_operand2),
    .cin	(adder_cin     ),
    .sum	(adder_result  ),
    .cout	(adder_cout    )
    );
	
	assign add_sub_result = adder_result;
	assign and_result = alu_src1 & alu_src2;
	assign or_result  = alu_src1 | alu_src2;
	assign xor_result = alu_src1 ^ alu_src2;
	assign sll_result = alu_src1 << alu_src2;       //逻辑左移
    assign srl_result = alu_src1 >> alu_src2;       //逻辑右移
    assign slt_result = adder_result[31] ? 1'b1 : 1'b0;   // 带符号数小于置位
    assign sltu_result = adder_cout ? 1'b0 : 1'b1;     //无符号数小于置位
    assign sra_result = temp_src1 >>> alu_src2;     //算数右移
	assign lui_result = {alu_src2[19:0], 12'd0};

	always@(*)
	begin
		case (alu_control)
			4'b0000: alu_result <= and_result;
			4'b0001: alu_result <= or_result;
			4'b0010: alu_result <= add_sub_result;
			4'b0011: alu_result <= xor_result;
			4'b0110: alu_result <= add_sub_result;
			4'b1000: alu_result <= sll_result;
			4'b1010: alu_result <= srl_result;
			4'b1011: alu_result <= sra_result;
			4'b1100: alu_result <= slt_result;
			4'b1101: alu_result <= sltu_result;
			4'b1110: alu_result <= lui_result;
			default: alu_result <= 32'd0;
		endcase
	end

endmodule
// ----------------------------------------------------


// ----------------------------------------------------
// Part II: 32-bit Square Root CSL adder
// ----------------------------------------------------
module adder (
	input wire	[31:0]	a,		// operator 1
	input wire	[31:0]	b, 		// operator 2
	input wire			cin, 	// carry in

	output wire	[31:0]	sum,	// sum
	output wire			cout	// carry out
);

	 //use "wire" to define internal signals
wire [9:0] mid_c;  //guessed carries out
wire [63:0] mid_sum;   // guessed sum
wire [5:0] selected_c; // selected carries out
wire [31:0] selected_sum; // selected sum


bitNRCAdder #(.N(3)) RCadder1_i1(.add1(a[2:0]),.add2(b[2:0]),.cin(cin),.result(mid_sum[2:0]),.cout(selected_c[0]));

bitNRCAdder #(.N(4)) RCadder1_i2(.add1(a[6:3]),.add2(b[6:3]),.cin(1'b0),.result(mid_sum[9:6]),.cout(mid_c[0]));
bitNRCAdder #(.N(4)) RCadder2_i2(.add1(a[6:3]),.add2(b[6:3]),.cin(1'b1),.result(mid_sum[13:10]),.cout(mid_c[1]));
bitNmux #(.N(4)) bit5mux_i2(.in0({mid_sum[9:6],mid_c[0]}),.in1({mid_sum[13:10],mid_c[1]}),.sel(selected_c[0]),.ou1({selected_sum[6:3],selected_c[1]}));

bitNRCAdder #(.N(5)) RCadder1_i3(.add1(a[11:7]),.add2(b[11:7]),.cin(1'b0),.result(mid_sum[18:14]),.cout(mid_c[2]));
bitNRCAdder #(.N(5)) RCadder2_i3(.add1(a[11:7]),.add2(b[11:7]),.cin(1'b1),.result(mid_sum[23:19]),.cout(mid_c[3]));
bitNmux #(.N(5)) bit5mux_i3(.in0({mid_sum[18:14],mid_c[2]}),.in1({mid_sum[23:19],mid_c[3]}),.sel(selected_c[1]),.ou1({selected_sum[11:7],selected_c[2]}));

bitNRCAdder #(.N(6)) RCadder1_i4(.add1(a[17:12]),.add2(b[17:12]),.cin(1'b0),.result(mid_sum[29:24]),.cout(mid_c[4]));
bitNRCAdder #(.N(6)) RCadder2_i4(.add1(a[17:12]),.add2(b[17:12]),.cin(1'b1),.result(mid_sum[35:30]),.cout(mid_c[5]));
bitNmux #(.N(6)) bit5mux_i4(.in0({mid_sum[29:24],mid_c[4]}),.in1({mid_sum[35:30],mid_c[5]}),.sel(selected_c[2]),.ou1({selected_sum[17:12],selected_c[3]}));

bitNRCAdder #(.N(7)) RCadder1_i5(.add1(a[24:18]),.add2(b[24:18]),.cin(1'b0),.result(mid_sum[42:36]),.cout(mid_c[6]));
bitNRCAdder #(.N(7)) RCadder2_i5(.add1(a[24:18]),.add2(b[24:18]),.cin(1'b1),.result(mid_sum[49:43]),.cout(mid_c[7]));
bitNmux #(.N(7)) bit5mux_i5(.in0({mid_sum[42:36],mid_c[6]}),.in1({mid_sum[49:43],mid_c[7]}),.sel(selected_c[3]),.ou1({selected_sum[24:18],selected_c[4]}));

bitNRCAdder #(.N(7)) RCadder1_i6(.add1(a[31:25]),.add2(b[31:25]),.cin(1'b0),.result(mid_sum[56:50]),.cout(mid_c[8]));
bitNRCAdder #(.N(7)) RCadder2_i6(.add1(a[31:25]),.add2(b[31:25]),.cin(1'b1),.result(mid_sum[63:57]),.cout(mid_c[9]));
bitNmux #(.N(7)) bit5mux_i6(.in0({mid_sum[56:50],mid_c[8]}),.in1({mid_sum[63:57],mid_c[9]}),.sel(selected_c[4]),.ou1({selected_sum[31:25],selected_c[5]}));

assign cout = selected_c[5];
assign sum = {selected_sum[31:3],mid_sum[2:0]};

endmodule

// ----------------------------------------------------
// Part III: N-bit Ripple Carry Adder by generator
// ----------------------------------------------------
module bitNRCAdder#(parameter N = 4) (

  input wire  [N-1:0]         add1,     //adder1
  input wire  [N-1:0]         add2,      //adder2
  input wire cin,                       //carry input

  output wire  [N-1:0]         result,     //sum
  output wire              cout     //carry output
);

wire [N-1:0] p,g; //internal variables
wire [N:0] c_mid; //carry

assign p = add1^add2;
assign g = add1&add2;

generate
	genvar i;
	for(i=0;i<N;i=i+1) begin: block
	bit1adder bit1adder_module(.g(g[i]),.p(p[i]),.cin(c_mid[i]),.sum(result[i]),.count(c_mid[i+1]));
	end
endgenerate
assign c_mid[0] = cin;
assign cout = c_mid[N];

endmodule
// ----------------------------------------------------
// Part IV: N-bit multiplexer
// ----------------------------------------------------
module bitNmux#(parameter N = 5) (
input wire [N:0] in1,in0, // 2-way inputs
input wire sel,             // select

output reg [N:0] ou1      //outputs
    );
always@(*) begin
case (sel)
	1'b0:ou1 = in0;
	1'b1:ou1 = in1;
endcase
end

endmodule
// ----------------------------------------------------
// Part V: 1-bit Full Adder
// ----------------------------------------------------
module bit1adder(
input wire g,  // generate
input wire p,  // propagate
input wire cin,  // carry in

output wire sum, // sum
output wire count // carry out
    );

assign sum = p^cin;
assign count = g|(cin&p);

endmodule

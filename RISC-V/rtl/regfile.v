module regfile(
input clk, 
input [4:0] ra1,ra2, 
input en_write, 
input [4:0] wa,//write adddress
input [31:0] wdata,

output reg[31:0] rd1,rd2 // 
);

// Register file storage  for behavior
	reg [31:0]  reg_r0_q; 
    reg [31:0]  reg_r1_q;
    reg [31:0]  reg_r2_q;
    reg [31:0]  reg_r3_q;
    reg [31:0]  reg_r4_q;
    reg [31:0]  reg_r5_q;
    reg [31:0]  reg_r6_q;
    reg [31:0]  reg_r7_q;
    reg [31:0]  reg_r8_q;
    reg [31:0]  reg_r9_q;
    reg [31:0] reg_r10_q;
    reg [31:0] reg_r11_q;
    reg [31:0] reg_r12_q;
    reg [31:0] reg_r13_q;
    reg [31:0] reg_r14_q;
    reg [31:0] reg_r15_q;
    reg [31:0] reg_r16_q;
    reg [31:0] reg_r17_q;
    reg [31:0] reg_r18_q;
    reg [31:0] reg_r19_q;
    reg [31:0] reg_r20_q;
    reg [31:0] reg_r21_q;
    reg [31:0] reg_r22_q;
    reg [31:0] reg_r23_q;
    reg [31:0] reg_r24_q;
    reg [31:0] reg_r25_q;
    reg [31:0] reg_r26_q;
    reg [31:0] reg_r27_q;
    reg [31:0] reg_r28_q;
    reg [31:0] reg_r29_q;
    reg [31:0] reg_r30_q;
    reg [31:0] reg_r31_q;
					   
    // Simulation friendly names
	//assign x0_zero_w = 32'b0;
	//wire [31:0] x0_zero_w = 32'b0;
	wire [31:0] x0_zero_w = 32'b0 ;
	wire [31:0] x1_ra_w   = reg_r1_q;
	wire [31:0] x2_sp_w   = reg_r2_q;
	wire [31:0] x3_gp_w   = reg_r3_q;
	wire [31:0] x4_tp_w   = reg_r4_q;
	wire [31:0] x5_t0_w   = reg_r5_q;
	wire [31:0] x6_t1_w   = reg_r6_q;
	wire [31:0] x7_t2_w   = reg_r7_q;
	wire [31:0] x8_s0_w   = reg_r8_q;
	wire [31:0] x9_s1_w   = reg_r9_q;
	wire [31:0] x10_a0_w  = reg_r10_q;
	wire [31:0] x11_a1_w  = reg_r11_q;
	wire [31:0] x12_a2_w  = reg_r12_q;
	wire [31:0] x13_a3_w  = reg_r13_q;
	wire [31:0] x14_a4_w  = reg_r14_q;
	wire [31:0] x15_a5_w  = reg_r15_q;
	wire [31:0] x16_a6_w  = reg_r16_q;
	wire [31:0] x17_a7_w  = reg_r17_q;
	wire [31:0] x18_s2_w  = reg_r18_q;
	wire [31:0] x19_s3_w  = reg_r19_q;
	wire [31:0] x20_s4_w  = reg_r20_q;
	wire [31:0] x21_s5_w  = reg_r21_q;
	wire [31:0] x22_s6_w  = reg_r22_q;
	wire [31:0] x23_s7_w  = reg_r23_q;
	wire [31:0] x24_s8_w  = reg_r24_q;
	wire [31:0] x25_s9_w  = reg_r25_q;
	wire [31:0] x26_s10_w = reg_r26_q;
	wire [31:0] x27_s11_w = reg_r27_q;
	wire [31:0] x28_t3_w  = reg_r28_q;
	wire [31:0] x29_t4_w  = reg_r29_q;
	wire [31:0] x30_t5_w  = reg_r30_q;
	wire [31:0] x31_t6_w  = reg_r31_q;

	
    always@(*)
    begin
        case (ra1)
		5'd0:  rd1 <= x0_zero_w ;
        5'd1:  rd1 <= x1_ra_w   ;
        5'd2:  rd1 <= x2_sp_w   ;
        5'd3:  rd1 <= x3_gp_w   ;
        5'd4:  rd1 <= x4_tp_w   ;
        5'd5:  rd1 <= x5_t0_w   ;
        5'd6:  rd1 <= x6_t1_w   ;
        5'd7:  rd1 <= x7_t2_w   ;
        5'd8:  rd1 <= x8_s0_w   ;
        5'd9:  rd1 <= x9_s1_w   ;
        5'd10: rd1 <= x10_a0_w  ;
        5'd11: rd1 <= x11_a1_w  ;
        5'd12: rd1 <= x12_a2_w  ;
        5'd13: rd1 <= x13_a3_w  ;
        5'd14: rd1 <= x14_a4_w  ;
        5'd15: rd1 <= x15_a5_w  ;
        5'd16: rd1 <= x16_a6_w  ;
        5'd17: rd1 <= x17_a7_w  ;
        5'd18: rd1 <= x18_s2_w  ;
        5'd19: rd1 <= x19_s3_w  ;
        5'd20: rd1 <= x20_s4_w  ;
        5'd21: rd1 <= x21_s5_w  ;
        5'd22: rd1 <= x22_s6_w  ;
        5'd23: rd1 <= x23_s7_w  ;
        5'd24: rd1 <= x24_s8_w  ;
        5'd25: rd1 <= x25_s9_w  ;
        5'd26: rd1 <= x26_s10_w ;
        5'd27: rd1 <= x27_s11_w ;
        5'd28: rd1 <= x28_t3_w  ;
        5'd29: rd1 <= x29_t4_w  ;
        5'd30: rd1 <= x30_t5_w  ;
        5'd31: rd1 <= x31_t6_w  ;
     default : rd1 <= 32'h00000000;
        endcase

        case (ra2)
		5'd0:  rd2 <= x0_zero_w ;
        5'd1:  rd2 <= x1_ra_w   ;
        5'd2:  rd2 <= x2_sp_w   ;
        5'd3:  rd2 <= x3_gp_w   ;
        5'd4:  rd2 <= x4_tp_w   ;
        5'd5:  rd2 <= x5_t0_w   ;
        5'd6:  rd2 <= x6_t1_w   ;
        5'd7:  rd2 <= x7_t2_w   ;
        5'd8:  rd2 <= x8_s0_w   ;
        5'd9:  rd2 <= x9_s1_w   ;
        5'd10: rd2 <= x10_a0_w  ;
        5'd11: rd2 <= x11_a1_w  ;
        5'd12: rd2 <= x12_a2_w  ;
        5'd13: rd2 <= x13_a3_w  ;
        5'd14: rd2 <= x14_a4_w  ;
        5'd15: rd2 <= x15_a5_w  ;
        5'd16: rd2 <= x16_a6_w  ;
        5'd17: rd2 <= x17_a7_w  ;
        5'd18: rd2 <= x18_s2_w  ;
        5'd19: rd2 <= x19_s3_w  ;
        5'd20: rd2 <= x20_s4_w  ;
        5'd21: rd2 <= x21_s5_w  ;
        5'd22: rd2 <= x22_s6_w  ;
        5'd23: rd2 <= x23_s7_w  ;
        5'd24: rd2 <= x24_s8_w  ;
        5'd25: rd2 <= x25_s9_w  ;
        5'd26: rd2 <= x26_s10_w ;
        5'd27: rd2 <= x27_s11_w ;
        5'd28: rd2 <= x28_t3_w  ;
        5'd29: rd2 <= x29_t4_w  ;
        5'd30: rd2 <= x30_t5_w  ;
        5'd31: rd2 <= x31_t6_w  ;
     default : rd2 <= 32'h00000000;
        endcase
    end

	

    always@(negedge clk)
    begin
	if(en_write)
		case (wa)
		5'd0:	reg_r0_q  <= 32'b0;
        5'd1:   reg_r1_q  <= wdata ;
        5'd2:   reg_r2_q  <= wdata ;
        5'd3:   reg_r3_q  <= wdata ;
        5'd4:   reg_r4_q  <= wdata ;
        5'd5:   reg_r5_q  <= wdata ;
        5'd6:   reg_r6_q  <= wdata ;
        5'd7:   reg_r7_q  <= wdata ;
        5'd8:   reg_r8_q  <= wdata ;
        5'd9:   reg_r9_q  <= wdata ;
        5'd10:  reg_r10_q <= wdata ;
        5'd11:  reg_r11_q <= wdata ;
        5'd12:  reg_r12_q <= wdata ;
        5'd13:  reg_r13_q <= wdata ;
        5'd14:  reg_r14_q <= wdata ;
        5'd15:  reg_r15_q <= wdata ;
        5'd16:  reg_r16_q <= wdata ;
        5'd17:  reg_r17_q <= wdata ;
        5'd18:  reg_r18_q <= wdata ;
        5'd19:  reg_r19_q <= wdata ;
        5'd20:  reg_r20_q <= wdata ;
        5'd21:  reg_r21_q <= wdata ;
        5'd22:  reg_r22_q <= wdata ;
        5'd23:  reg_r23_q <= wdata ;
        5'd24:  reg_r24_q <= wdata ;
        5'd25:  reg_r25_q <= wdata ;
        5'd26:  reg_r26_q <= wdata ;
        5'd27:  reg_r27_q <= wdata ;
        5'd28:  reg_r28_q <= wdata ;
        5'd29:  reg_r29_q <= wdata ;
        5'd30:  reg_r30_q <= wdata ;
        5'd31:  reg_r31_q <= wdata ;
		endcase				     
	end

endmodule	

/*=32'd0 
  =32'd1 
  =32'd2 
  =32'd3 
  =32'd4 
  =32'd5 
  =32'd6 
  =32'd7 
  =32'd8 
  =32'd9 
  =32'd10
  =32'd11
  =32'd12
  =32'd13
  =32'd14
  =32'd15
  =32'd16
  =32'd17
  =32'd18
  =32'd19
  =32'd20
  =32'd21
  =32'd22
  =32'd23
  =32'd24
  =32'd25
  =32'd26
  =32'd27
  =32'd28
  =32'd29
  =32'd30
  =32'd31
  */
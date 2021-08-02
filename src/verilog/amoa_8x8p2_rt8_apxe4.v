`timescale 1ns/1ps

module amoa_8x8p2_rt8_apxe4 (
input clk,
input rst_n,
// input of ApxRT
input [7:0] x0,
input [7:0] x1,
input [7:0] x2,
input [7:0] x3,
input [7:0] x4,
input [7:0] x5,
input [7:0] x6,
input [7:0] x7,
output reg [10:0] summ,
output stall
);

wire [9:0] summ_rt;
wire [9:0] carry_rt;
wire [7:0] ed_rt;

wire [2:0] U7_ecv1,U6_ecv1,U5_ecv1,U4_ecv1,U3_ecv1,U2_ecv1,U1_ecv1,U0_ecv1;

rt8_apxe4 U0[7:0] (
	.x1(x0),
	.x2(x1), 
	.x3(x2), 
	.x4(x3), 
	.x5(x4), 
	.x6(x5), 
	.x7(x6), 
	.x8(x7), 
	.carry_in1({U6_cout1,U5_cout1,U4_cout1,U3_cout1,U2_cout1,U1_cout1,U0_cout1,1'b0}), 
	.carry_in2({U6_cout2,U5_cout2,U4_cout2,U3_cout2,U2_cout2,U1_cout2,U0_cout2,1'b0}), 
	.ein1({U5_eout1,U4_eout1,U3_eout1,U2_eout1,U1_eout1,U0_eout1,1'b0,1'b0}), 
	.ein2({U5_eout2,U4_eout2,U3_eout2,U2_eout2,U1_eout2,U0_eout2,1'b0,1'b0}), 
	.ein3({U5_eout3,U4_eout3,U3_eout3,U2_eout3,U1_eout3,U0_eout3,1'b0,1'b0}), 
	.carry_out1({U7_cout1,U6_cout1,U5_cout1,U4_cout1,U3_cout1,U2_cout1,U1_cout1,U0_cout1}), 
	.carry_out2({U7_cout2,U6_cout2,U5_cout2,U4_cout2,U3_cout2,U2_cout2,U1_cout2,U0_cout2}), 
	.eout1({U7_eout1,U6_eout1,U5_eout1,U4_eout1,U3_eout1,U2_eout1,U1_eout1,U0_eout1}), 
	.eout2({U7_eout2,U6_eout2,U5_eout2,U4_eout2,U3_eout2,U2_eout2,U1_eout2,U0_eout2}), 
	.eout3({U7_eout3,U6_eout3,U5_eout3,U4_eout3,U3_eout3,U2_eout3,U1_eout3,U0_eout3}), 
//	.ecv({U7_ecv1,U6_ecv1,U5_ecv1,U4_ecv1,U3_ecv1,U2_ecv1,U1_ecv1,U0_ecv1}), 
//	.ed({U7_ed1,U6_ed1,U5_ed1,U4_ed1,U3_ed1,U2_ed1,U1_ed1,U0_ed1}), 
	.ed(ed_rt),
	.summ(summ_rt[7:0]),
	.carry(carry_rt[7:0])
	 );

//assign stall = |ed_rt;

//cprs_4_2_mfa Ucprs1 (.x1(U7_cout1), .x2(U7_cout2), .x3(U6_eout1), .x4(U6_eout2), .cin(U6_eout3), .cout(Ucprs1_cout), .carry(carry_rt[8]), .summ(summ_rt[8]));
//cprs_3_2_mfa Ucprs2 (.x2(Ucprs1_cout), .x3(U7_eout1), .x4(U7_eout2), .cin(U7_eout3), .cout(cout_rt), .carry(carry_rt[9]), .summ(summ_rt[9]));

//reg [9:0] summ_rt_r1;
//reg [9:0] carry_rt_r1;
//reg [7:0] ed_r1;
//reg cout_rt_r1;
////reg [10:0] summ;
//
//always @ (posedge clk or negedge rst_n) begin
//	if (rst_n == 1'b0) begin
//		summ_rt_r1	<= 10'b0;
//		carry_rt_r1	<= 10'b0;
//		cout_rt_r1	<= 1'b0;
//		ed_r1	<= 8'b0;
//	end else begin
//		summ_rt_r1	<= summ_rt;
//		carry_rt_r1	<= carry_rt;
//		cout_rt_r1	<= cout_rt;
//		ed_r1	<= ed_rt;
//	end
//end
//
//always @ (posedge clk or negedge rst_n) begin
//	if (rst_n == 1'b0) begin
//		summ	<= 11'b0;
//	end else begin
//		summ	<= {cout_rt_r1,summ_rt_r1} + {carry_rt_r1,1'b0} + {ed_r1,2'b0};
//	end
//end
//
reg [8:0] summ_rt_r1;
reg [8:0] carry_rt_r1;
reg [7:0] ed_r1;
//reg [10:0] summ;

always @ (posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		summ_rt_r1	<= 9'b0;
		carry_rt_r1	<= 9'b0;
		ed_r1	<= 8'b0;
	end else begin
		summ_rt_r1	<= summ_rt;
		carry_rt_r1	<= carry_rt;
		ed_r1	<= ed_rt;
	end
end

always @ (posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		summ	<= 11'b0;
	end else begin
		summ	<= summ_rt_r1 + {carry_rt_r1,1'b0};
	end
end

endmodule

module rt8_apxe4 (
input x1,
input x2,
input x3,
input x4,
input x5,
input x6,
input x7,
input x8,
input carry_in1,
input carry_in2,
input ein1,
input ein2,
input ein3,
output carry_out1,
output carry_out2,
output eout1,
output eout2,
output eout3,
//output [2:0] ecv,
output ed,
output summ,
output carry
);


wire U0_sum, U1_sum;

cprs_4_2_apxe4 U0 (.x1(x1), .x2(x2), .x3(x3), .x4(x4), .carry(carry_out1), .summ(U0_sum), .err(eout1));
cprs_4_2_apxe4 U1 (.x1(x5), .x2(x6), .x3(x7), .x4(x8), .carry(carry_out2), .summ(U1_sum), .err(eout2));

assign c0 = carry_in1 | ein1;
assign c1 = carry_in2 | ein2;
assign e0 = carry_in1 & ein1;
assign e1 = carry_in2 & ein2;
cprs_4_2_apxe4 U2 (.x1(U0_sum), .x2(U1_sum), .x3(c0), .x4(c1), .carry(carry), .summ(summ), .err(eout3));
//assign ecv = {e0,e1,ein3};
assign ed = e0 | e1 | ein3;


endmodule

module cprs_4_2_apxe4 (
input x1,
input x2,
input x3,
input x4,
output carry,
output summ,
output err
);

// apx1, ED=1
//assign err = x1 & x2 & x3 & x4;
//assign summ = (x1 ^ x2 ^ x3 ^ x4) | err;
//assign carry = ((x1 ^ x2) & (x3 ^ x4)) | ((x1 & x2) ^ (x3 & x4)) | err;


// apxe4, ED=4
wire x1_xor_x2 ,x3_xor_x4 ,x1_and_x2 ,x3_and_x4, x1_or_x2, x3_or_x4 ;
assign x1_or_x2 = x1 | x2;
assign x3_or_x4 = x3 | x4;
assign x1_and_x2 = x1 & x2;
assign x3_and_x4 = x3 & x4;
assign x1_xor_x2 = x1 ^ x2;
assign x3_xor_x4 = x3 ^ x4;

assign summ		= x1_xor_x2 ^ x3_xor_x4;
//assign carry	= (x1_xor_x2 & x3_or_x4) | (~x1_or_x2 & x3_and_x4) | (x1_and_x2 & ~x3_and_x4);
//assign carry	= (x1_xor_x2 & x3_or_x4) | ~x1&~x2&x3&x4 + x1&x2&~(x3&x4);
assign carry	= (x1_xor_x2 & x3_or_x4) | (x3_and_x4 ? ~x1_or_x2 : x1_and_x2);
assign err		= x1_and_x2 & x3_and_x4;

endmodule

module cprs_4_2_mfa (
input x1,
input x2,
input x3,
input x4,
input cin,
output cout,
output carry,
output summ
);

wire xor234;

//assign {cout,s} = x1 + x2 + x3;
//assign {carry,summ} = cin + x4 + s;
assign xor234 = x2 ^ x3 ^ x4;
assign cout = !(!(x2&x3) & !(x3&x4) & !(x2&x4));

// in1, cin, t1
assign summ = x1 ^ cin ^ xor234;
assign carry = !(!(x1&cin) & !(x1&xor234) & !(cin&xor234));

endmodule

module cprs_3_2_mfa (
input x2,
input x3,
input x4,
input cin,
output cout,
output carry,
output summ
);

wire xor234;

//assign {cout,s} = x1 + x2 + x3;
//assign {carry,summ} = cin + x4 + s;
assign xor234 = x2 ^ x3 ^ x4;
assign cout = !(!(x2&x3) & !(x3&x4) & !(x2&x4));

assign carry = cin & xor234;
assign summ = cin ^ xor234;

endmodule

`timescale 1ns/1ps

module moa_8x8p2_rt8_mfa42 (
input clk,
input rst_n,
input [7:0] x0,
input [7:0] x1,
input [7:0] x2,
input [7:0] x3,
input [7:0] x4,
input [7:0] x5,
input [7:0] x6,
input [7:0] x7,
output reg [10:0] summ
);

wire [8:0] summ_rt;
wire [8:0] carry_rt;

rt8_mfa42 U0[7:0] (
//	.clk(clk),
//	.rst_n(rst_n),
	.x1(x0),
	.x2(x1), 
	.x3(x2), 
	.x4(x3), 
	.x5(x4), 
	.x6(x5), 
	.x7(x6), 
	.x8(x7), 
	.cin1({U6_cout1,U5_cout1,U4_cout1,U3_cout1,U2_cout1,U1_cout1,U0_cout1,1'b0}), 
	.cin2({U6_cout2,U5_cout2,U4_cout2,U3_cout2,U2_cout2,U1_cout2,U0_cout2,1'b0}), 
	.cin3({U6_cout3,U5_cout3,U4_cout3,U3_cout3,U2_cout3,U1_cout3,U0_cout3,1'b0}), 
	.carry_in1({U6_carry_out1,U5_carry_out1,U4_carry_out1,U3_carry_out1,U2_carry_out1,U1_carry_out1,U0_carry_out1,1'b0}), 
	.carry_in2({U6_carry_out2,U5_carry_out2,U4_carry_out2,U3_carry_out2,U2_carry_out2,U1_carry_out2,U0_carry_out2,1'b0}), 
	.cout1({U7_cout1,U6_cout1,U5_cout1,U4_cout1,U3_cout1,U2_cout1,U1_cout1,U0_cout1}), 
	.cout2({U7_cout2,U6_cout2,U5_cout2,U4_cout2,U3_cout2,U2_cout2,U1_cout2,U0_cout2}), 
	.cout3({U7_cout3,U6_cout3,U5_cout3,U4_cout3,U3_cout3,U2_cout3,U1_cout3,U0_cout3}), 
	.carry_out1({U7_carry_out1,U6_carry_out1,U5_carry_out1,U4_carry_out1,U3_carry_out1,U2_carry_out1,U1_carry_out1,U0_carry_out1}), 
	.carry_out2({U7_carry_out2,U6_carry_out2,U5_carry_out2,U4_carry_out2,U3_carry_out2,U2_carry_out2,U1_carry_out2,U0_carry_out2}), 
	.summ(summ_rt[7:0]),
	.carry(carry_rt[7:0])
	 );

cprs_4_2_mfa U1 (.x1(U7_cout1), .x2(U7_cout2), .x3(U7_carry_out1), .x4(U7_carry_out2), .cin(U7_cout3), .cout(cout_rt), .carry(carry_rt[8]), .summ(summ_rt[8]));

reg [8:0] summ_rt_r1;
reg [8:0] carry_rt_r1;
reg cout_rt_r1;
//reg [10:0] summ;

always @ (posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		summ_rt_r1	<= 9'b0;
		carry_rt_r1	<= 9'b0;
		cout_rt_r1	<= 1'b0;
	end else begin
		summ_rt_r1	<= summ_rt;
		carry_rt_r1	<= carry_rt;
		cout_rt_r1	<= cout_rt;
	end
end

always @ (posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		summ	<= 11'b0;
	end else begin
		summ	<= {cout_rt_r1,summ_rt_r1} + {carry_rt_r1,1'b0};
	end
end

endmodule

module rt8_mfa42 (
//input clk,
//input rst_n,
// input of RT
input x1,
input x2,
input x3,
input x4,
input x5,
input x6,
input x7,
input x8,
input cin1,
input cin2,
input cin3,
input carry_in1,
input carry_in2,
output cout1,
output cout2,
output cout3,
output carry_out1,
output carry_out2,
output summ,
output carry
);


wire U0_sum, U1_sum;

cprs_4_2_mfa U0 (.x1(x1), .x2(x2), .x3(x3), .x4(x4), .cin(cin1), .cout(cout1), .carry(carry_out1), .summ(U0_sum));
cprs_4_2_mfa U1 (.x1(x5), .x2(x6), .x3(x7), .x4(x8), .cin(cin2), .cout(cout2), .carry(carry_out2), .summ(U1_sum));
cprs_4_2_mfa U2 (.x1(U0_sum), .x2(U1_sum), .x3(carry_in1), .x4(carry_in2), .cin(cin3), .cout(cout3), .carry(carry), .summ(summ));

//reg carry_r,sum_r;

//always @ (posedge clk or negedge rst_n) begin
//	if (rst_n == 1'b0) begin
//		carry_r	<= 1'b0;
//		sum_r	<= 1'b0;
//	end else begin
//		carry_r	<= carry;
//		sum_r	<= summ;
//	end
//end

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

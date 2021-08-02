`timescale 1ns/1ps

module amoa_8x8p2_rt8_apx1 (
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

wire [8:0] summ_rt;
wire [8:0] carry_rt;

rt8_apx1 U0[7:0] (
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
	.carry_out1({U7_cout1,U6_cout1,U5_cout1,U4_cout1,U3_cout1,U2_cout1,U1_cout1,U0_cout1}), 
	.carry_out2({U7_cout2,U6_cout2,U5_cout2,U4_cout2,U3_cout2,U2_cout2,U1_cout2,U0_cout2}), 
	.summ(summ_rt[7:0]),
	.carry(carry_rt[7:0]),
	.error(error_rt),
	.ecv()
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

module rt8_apx1 (
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
output carry_out1,
output carry_out2,
output summ,
output carry,
output error,
output [2:0] ecv
);


wire U0_sum, U1_sum;

cprs_4_2_apx1 U0 (.x1(x1), .x2(x2), .x3(x3), .x4(x4), .carry(carry_out1), .summ(U0_sum), .err(U0_err));
cprs_4_2_apx1 U1 (.x1(x5), .x2(x6), .x3(x7), .x4(x8), .carry(carry_out2), .summ(U1_sum), .err(U1_err));

assign c0 = carry_in1 | U0_err;
assign c1 = carry_in2 | U1_err;
assign e0 = carry_in1 & U0_err;
assign e1 = carry_in2 & U1_err;
cprs_4_2_apx1 U2 (.x1(U0_sum), .x2(U1_sum), .x3(c0), .x4(c1), .carry(carry), .summ(summ), .err(U2_err));

assign error = e0 | e1 | U2_err;
assign ecv = e0 + e1 + U2_err;

endmodule

module cprs_4_2_apx1 (
input x1,
input x2,
input x3,
input x4,
output carry,
output summ,
output err
);

assign err = x1 & x2 & x3 & x4;
assign summ = (x1 ^ x2 ^ x3 ^ x4) | err;
assign carry = ((x1 ^ x2) & (x3 ^ x4)) | ((x1 & x2) ^ (x3 & x4)) | err;


endmodule


`timescale 1ns/1ps
module rt8_apxoa (
input clk,
input rst_n,
// input of ApxRT
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
output cout1,
output cout2,
output sum_r,
output carry_r,
output [2:0] U_err,
output error_r,
output error
);


wire U0_sum, U1_sum;
wire U0_err, U1_err, U2_err;

cprs_4_2_apxoa U0 (.x1(x1), .x2(x2), .x3(x3), .x4(x4), .carry(cout1), .summ(U0_sum), .err(U0_err));
cprs_4_2_apxoa U1 (.x1(x5), .x2(x6), .x3(x7), .x4(x8), .carry(cout2), .summ(U1_sum), .err(U1_err));
cprs_4_2_apxoa U2 (.x1(U0_sum), .x2(U1_sum), .x3(cin1), .x4(cin2), .carry(carry), .summ(summ), .err(U2_err));

assign error = U0_err | U1_err | U2_err;
assign U_err = {U0_err, U1_err , U2_err};

reg carry_r,sum_r,error_r;

always @ (posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		carry_r	<= 1'b0;
		sum_r	<= 1'b0;
		error_r <= 1'b0;
	end else begin
		carry_r	<= carry;
		sum_r	<= summ;
		error_r <= error;
	end
end

endmodule

module cprs_4_2_apxoa (
input x1,
input x2,
input x3,
input x4,
output carry,
output summ,
output err
);

//wire x1_xor_x2 ,x3_xor_x4 ,x1_and_x2 ,x3_and_x4 ;
assign xx1 = x1 | x2;
assign xx2 = x3 | x4;
assign xx3 = x1 & x2;
assign xx4 = x3 & x4;

assign x1_xor_x2 = xx1 ^ xx2;
//assign x3_xor_x4 = x3 ^ x4;

assign x1_or_x2  = xx1 | xx2;
assign x3_or_x4  = xx3 | xx4;
assign x1_and_x2 = xx1 & xx2;
assign x3_and_x4 = xx3 & xx4;

//assign err = x1 & x2 & x3 & x4;
//assign summ = (x1 ^ x2 ^ x3 ^ x4) | err;
//assign carry = ((x1 ^ x2) & (x3 ^ x4)) | ((x1 & x2) ^ (x3 & x4)) | err;
//
assign summ		= x1_xor_x2 ^ x3_or_x4;
assign carry	= (x1_or_x2 & x3_or_x4) | x1_and_x2;
assign err		= x3_and_x4;

endmodule

`timescale 1ns/1ps

module rt8_mfa42 (
input clk,
input rst_n,
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
output sum_r,
output carry_r
);


wire U0_sum, U1_sum;

cprs_4_2_mfa U0 (.x1(x1), .x2(x2), .x3(x3), .x4(x4), .cin(cin1), .cout(cout1), .carry(carry_out1), .summ(U0_sum));
cprs_4_2_mfa U1 (.x1(x5), .x2(x6), .x3(x7), .x4(x8), .cin(cin2), .cout(cout2), .carry(carry_out2), .summ(U1_sum));
cprs_4_2_mfa U2 (.x1(U0_sum), .x2(U1_sum), .x3(carry_in1), .x4(carry_in2), .cin(cin3), .cout(cout3), .carry(carry), .summ(summ));

reg carry_r,sum_r;

always @ (posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		carry_r	<= 1'b0;
		sum_r	<= 1'b0;
	end else begin
		carry_r	<= carry;
		sum_r	<= summ;
	end
end

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


module ec_8 (
input [2:0] err_in,
input cin,
input carry_in,
output cout,
output carry_out,
output sout
);

wire summ;
cprs_3_2 U0 (.in(err_in), .out({carry_out,summ}));
assign {cout,sout} = summ + cin + carry_in;

endmodule

module cprs_3_2 (
in,
out
);
input [2:0] in;
output [1:0] out;

assign in0_xor_in1	= in[0] ^ in[1];
assign in0_and_in1	= in[0] & in[1];
assign out[1] = in0_xor_in1 & in[2] | in0_and_in1;
assign out[0] = in0_xor_in1 ^ in[2];

endmodule

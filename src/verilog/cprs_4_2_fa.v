module cprs_4_2_fa(
input x1,
input x2,
input x3,
input x4,
input cin,
output cout,
output carry,
output sum
);

wire s;

assign {cout,s} = x1 + x2 + x3;
assign {carry,sum} = cin + x4 + s;

endmodule

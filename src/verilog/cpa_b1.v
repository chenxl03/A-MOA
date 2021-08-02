module cpa_b1(
input x1,
input x2,
input ed,
input ec,
input stall,
input cin,
output cout,
output carry,
output summ
);

wire s1;
assign {cout,s1} = x1+x2;
assign {carry,summ} = ((stall == 1'b1) ? ec : ed) + s1 + cin;


endmodule

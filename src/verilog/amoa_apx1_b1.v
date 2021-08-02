module amoa_apx1_b1(
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
input cin1_apxrt,
input cin2_apxrt,
// input of EC8
// input err, U_err
input cin_ec,
input carryin_ec,
// input of CPA
input stall,
//output of apxRT
output cout1_apxrt,
output cout2_apxrt,
//output sum_r,
//output carry_r,
//output [2:0] U_err,
output error
);


endmodule

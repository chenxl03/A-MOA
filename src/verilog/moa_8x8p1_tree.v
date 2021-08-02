`timescale 1ns / 1ps
module moa_8x8p1_tree (
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

wire [10:0] sum_f;
assign sum_f = x0 + x1 + x2 + x3 +
               x4 + x5 + x6 + x7 ;

always @ (posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		summ <= 11'b0;
	end else begin
		summ <= sum_f;
	end
end

endmodule


module cpa3_b10 (
input clk,
input rst_n,
input [7:0] in1,
input [7:0] in2,
input [8:0] in3,
output reg [9:0] summ
);

always @ (posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		summ	<= 10'b0;
	end else begin
		summ	<= in1 + in2 + in3;
	end
end

endmodule

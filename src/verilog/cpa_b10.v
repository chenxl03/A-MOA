module cpa_b10 (
input clk,
input rst_n,
input [9:0] in1,
input [9:0] in2,
output reg [10:0] summ
);

always @ (posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		summ	<= 11'b0;
	end else begin
		summ	<= in1 + in2;
	end
end

endmodule

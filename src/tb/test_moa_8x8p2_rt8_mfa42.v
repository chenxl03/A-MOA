`timescale 1ns / 1ps

module test_moa_8x8p2_rt8_mfa42;

reg clk;
reg rst_n;
reg [7:0] x0;
reg [7:0] x1;
reg [7:0] x2;
reg [7:0] x3;
reg [7:0] x4;
reg [7:0] x5;
reg [7:0] x6;
reg [7:0] x7;
reg [7:0] counter;

wire [10:0] summ;
moa_8x8p2_rt8_mfa42 U0 (
 .clk(clk),
 .rst_n(rst_n),
 .x0(x0),
 .x1(x1),
 .x2(x2),
 .x3(x3),
 .x4(x4),
 .x5(x5),
 .x6(x6),
 .x7(x7),
 .summ(summ)
);

// clock
always #5 clk = ~clk;
// reset
initial begin
clk=0;
rst_n=0;
#8;
rst_n=1;
#2000;
$finish();
end

// dump
`ifdef DUMP
initial begin
	$dumpfile("test.dump");
	$dumpvars(0,test_moa_8x8p2_rt8_mfa42);
end
`endif


// stimulus
always @ (posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
	counter <= 8'd0;
	x0 <= 8'd0;
	x1 <= 8'd0;
	x2 <= 8'd0;
	x3 <= 8'd0;
	x4 <= 8'd0;
	x5 <= 8'd0;
	x6 <= 8'd0;
	x7 <= 8'd0;
	end else begin
	counter <= counter + 1'b1;
	x0 <= counter + 1;
	x1 <= counter + 2;
	x2 <= counter + 3;
	x3 <= counter + 4;
	x4 <= counter + 4;
	x5 <= counter + 3;
	x6 <= counter + 2;
	x7 <= counter + 1;
	end
end

// check
always @(posedge clk) begin
	if (rst_n == 1'b1) begin
		$display("counter:%d summ:%d x0:%d\n",counter,summ,x0);
		//if (summ != (counter-1)*8) begin
		//$display("ERROR: summ %d != (counter-1)*8 %d:%d, arrival at %t",summ,(counter-1)*8,counter,$time);
		//end
	end
end

endmodule

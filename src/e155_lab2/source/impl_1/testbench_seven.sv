
`timescale 1ns/1ns
`default_nettype none
`define N_TV 16
module testbench_seven();
	logic clk, reset;
	logic [3:0]s;
	logic [2:0] led, led_expected;
	logic [6:0] seg, seg_expected;
	logic [31:0] vectornum, errors;
	logic [13:0] testvectors[10000:0];
	
	seven_seg_display dut(s, seg);
	
	//// Generate clock.
	always
		begin
			clk=1; #5;
			clk=0; #5;
		end
		
	initial
		begin
			//// Load vectors stored as 0s and 1s (binary) in .tv file.
			$readmemb("e155_lab1.tv", testvectors, 0, `N_TV - 1);
			vectornum=0;
			errors=0;
			reset=1; #22;
			reset=0;
		end
	//// Apply test vectors on rising edge of clk.
	always @(posedge clk)
		begin
			#1; {s,led_expected,seg_expected} = testvectors[vectornum];
			
		end
	//// Check results on falling edge of clk.
	always @(negedge clk)
		if (~reset) begin
			if (seg !== seg_expected) begin
				$display("Error: inputs = %b", s);
				$display(" outputs = %b  ( %b expected)", seg, seg_expected);
				errors = errors + 1;
			end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 14'bx) begin

				$display("%d tests completed with %d errors", vectornum,
				errors);
				$stop;
			end
		end
// In summary, new inputs are applied on the positive clock edge and the
// outputs are checked against the expected outputs on the negative clock
// edge. Errors are reported simultaneously. The process repeats until there
// are no more valid test vectors in the testvectors arrays. At the end of

// simulation, the module prints the total number of test vectors applied and
// the total number of errors detected.
endmodule
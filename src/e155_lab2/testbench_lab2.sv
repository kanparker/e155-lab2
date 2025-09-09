/*
Title: Test Bench for Lab 2 Top Module
Author: Kanoa Parker
Email: kanparker@hmc.edu
Date: 9/9/2025
Description: Test bench to test op module
*/
`timescale 1ns/1ns
`default_nettype none
`define N_TV 16
module testbench_lab2();
	logic clk, reset;
	logic [31:0] testnumb,errors;
	logic [7:0] s_input;
	logic [3:0]ssd_input; 
	logic [3:0]s1;
	logic [3:0]s2;
	logic [6:0]seg; 
	logic [6:0]seg_expected;
	logic [4:0]led;
	logic gate1, gate2;
	
	// instantiate device under test
	top dut(s1, s2,seg,led,gate1,gate2,clk);
	seven_seg_display ssd(ssd_input,seg_expected);
	
	// at start of test, load vectors and pulse reset
	initial
		begin
			vectornum = 1; errors = 0; reset = 1; #22; reset = 0;
			s_input = 8'b00000000;
		end
		
		// apply test vectors on rising edge of clk
	always @(posedge clk)
		begin
			//assign values to swithces and apply value to ssd input
			#1;
			assign s1 = s_input[7:4];
			assign s2 = s_input[3:0];
			assign ssd_input = s1;
			//check values against what should be expected
			#1;
			assert(gate1 ==1'b1) else begin
					$display("Error: inputs = %b", {s_input});
					$display(" outputs = %b (%b expected)", gate1, "1");
					errors = errors + 1;
				end;
			
			assert(gate2==1'b0) else begin
					$display("Error: inputs = %b", {s_input});
					$display(" outputs = %b (%b expected)",gate2, "0");
					errors = errors + 1;
				end;
			
			assert(led == s1+s2)else begin
					$display("Error: inputs = %b", {s_input});
					$display(" outputs = %b (%b expected)",led, s1+s2);
					errors = errors + 1;
				end
			
			
			assert(seg_expected == seg)else begin
					$display("Error: inputs = %b", {s_input});
					$display(" outputs = %b (%b expected)",seg, seg_expected);
					errors = errors + 1;
				end
			
		end


	always @(negedge clk)
		if (~reset) begin // skip during reset
			//apply values to s1 and s2 and apply s2 to ssd input
			#1;
			assign s1 = s_input[7:4];
			assign s2 = s_input[3:0];
			assign ssd_input = s2;
			//check values
			#1;
			assert(gate2 ==1'b1) else begin
					$display("Error: inputs = %b", {s_input});
					$display(" outputs = %b (%b expected)", gate2, "1");
					errors = errors + 1;
				end;
			
			assert(gate1==1'b0) else begin
					$display("Error: inputs = %b", {s_input});
					$display(" outputs = %b (%b expected)",gate1, "0");
					errors = errors + 1;
				end;
			
			assert(led == s1+s2)else begin
					$display("Error: inputs = %b", {s_input});
					$display(" outputs = %b (%b expected)",led, s1+s2);
					errors = errors + 1;
				end
			
			
			assert(seg_expected == seg)else begin
					$display("Error: inputs = %b", {s_input});
					$display(" outputs = %b (%b expected)",seg, seg_expected);
					errors = errors + 1;
				end
			//checks to see if we have gone through all possible inputs if so end
			if (s_input == 8'b11111111) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
			//increment input and test number
			assign s_input = s_input + 8'b00000001;
			assign testnumb = testnumb +1;
		
			
		end
		
		
		
		
		

endmodule 

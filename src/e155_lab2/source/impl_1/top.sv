/*
Title: top module for lab 2
Author: Kanoa Parker
Email: kanparker@g.hmc.edu
Date: 9/9/2024
Description: Top module for lab 2. Takes in inputs of 2 sets of 4 switches, s1 and s2. Outputs the sum of s1 and s2 as led. Using a time multiplexer the mux choses either to output either s1 or s2 as seg using seven_seg_display module. gate1 and gate1 go to transistor gates which control which set of leds get turned on.
*/
module top(
	input logic [3:0]s1,
	input logic [3:0]s2,
	output logic [6:0]seg, 
	output logic [4:0]led,
	output logic gate1, gate2,
	output logic clk
);
	//s1 is inputs of one set of 4 dip swithces
	//s2 is inputs of other set of 4 dip switches
	//seg is the output to drive seven segment display
	// gate1 and gate2 go to base of BJT to control power to seven segment display
	// clk is output used for testing
	
	//sev_seg_in is the input to seven_seg_display module
	logic [3:0]sev_seg_in;
	
	//sev_seg_out is the output of seven_seg_display module
	logic [6:0]sev_seg_out;

	//instancing seven_seg_display
	seven_seg_display seven_seg_counter(sev_seg_in,seg);
	//instancing clock divider
	clock_divider slow_clock(clk);
	
	//muxing between s1 and s2
	always_comb
		case(clk)
			1'b1: begin
					sev_seg_in = s1[3:0]; 
					gate1 = 1'b1;
					gate2 =1'b0;
				end
			1'b0: begin
					sev_seg_in = s2[3:0];
					gate1 = 1'b0;
					gate2 = 1'b1;
				end
		endcase
	//sum of s1 and s2 to led	
		assign led = s1 + s2;
		
endmodule
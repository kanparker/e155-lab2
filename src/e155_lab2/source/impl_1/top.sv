module top(
	input logic [3:0]s1,
	input logic [3:0]s2,
	output logic [6:0]seg, 
	output logic [4:0]led,
	output logic gate1, gate2,
	output logic clk
);

	logic [3:0]sev_seg_in;
	logic [6:0]sev_seg_out;

	
	seven_seg_display seven_seg_counter(sev_seg_in,seg);
	clock_divider slow_clock(clk);
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
		
		assign led = s1 + s2;
		
endmodule
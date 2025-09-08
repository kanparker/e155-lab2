module clock_divider(
	output clk
);
	
	logic int_osc;
	logic pulse;
	logic led_state = 0;
	logic [31:0] counter = 0;
	logic [31:0] P;
	
	assign P = 32'b00000000000000010101111110010000;
	
	// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	// Simple clock divider
	always_ff @(posedge int_osc)
		begin
			counter <= counter + P;
		end
	assign clk = counter[31];
		
endmodule
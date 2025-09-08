module seven_seg_display(
	input 	logic	[3:0]s,
	output 	logic [6:0]seg
);

	logic A,B,C,D;
	
	assign A = s[3];
	assign B = s[2];
	assign C = s[1];
	assign D = s[0];
	
	/*
	assign seg[6] = (~A&~C)&(B^D) | A&(~B&C&D | B&~C);
	assign seg[5] = D&~(A^C) | B&(C&~D | A&~C&~D);
	assign seg[4] = ~A&~B&C&~D | (A&B)&( ~C&~D | C);
	assign seg[3] = (~A&D)& ~(B^C) | (A&~B)&(C^D) | B&( ~(A|C|D) | A&C&D);
	assign seg[2] = (~A&~B&D) | (~A&B&~C) | (~A&B&C&D) | (A&~B&~C&D);
	assign seg[1] = (~(A|B|C) & D) | (~A&~B&C) | (~A&B&C&D) | (A&B&~C);
	assign seg[0] = ~(A|B|C|D) | (~A&~B&~C&D) | (~A&B&C&D);
	*/
	
	always_comb
		case(s[3:0])
			/// 0
			4'b0000: seg[6:0] = 7'b0000001;
			/// 1
			4'b0001: seg[6:0] = 7'b1001111;
			/// 2
			4'b0010: seg[6:0] = 7'b0010010;
			/// 3
			4'b0011:seg[6:0] = 7'b0000110;
			/// 4
			4'b0100:seg[6:0] = 7'b1001100;
			/// 5
			4'b0101:seg[6:0] = 7'b0100100;
			/// 6
			4'b0110:seg[6:0] = 7'b0100000;
			/// 7
			4'b0111:seg[6:0] = 7'b0001111;
			/// 8
			4'b1000:seg[6:0] = 7'b0000000;
			/// 9
			4'b1001:seg[6:0] = 7'b0001100;
			/// A
			4'b1010:seg[6:0] = 7'b0001000;
			/// B
			4'b1011:seg[6:0] = 7'b1100000;
			/// C
			4'b1100:seg[6:0] = 7'b0110001;
			/// D
			4'b1101:seg[6:0] = 7'b1000010;
			/// E
			4'b1110:seg[6:0] = 7'b0110000;
			/// F
			4'b1111:seg[6:0] = 7'b0111000;
		endcase
			
	

endmodule

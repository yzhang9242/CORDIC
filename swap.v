always @(posedge clk) begin
	temp = b;
	b = a;
	a = temp;
end

always @(posedge clk) begin
	a <= b;
	b <= a;
end

// flip-flop with a positive-edge clock
module ff(clk, d, q);
	input clk;
	input d;
	output q;
	reg q;

	always @(posedge clk) begin
		q <= d;
	end
endmodule

// flip-flop with neg-edge clock and asyn clear
module ff_na(clk, d, q, clr);
	input clk;
	input d;
	input clr;
	output q;
	
	reg q;

	always @(negedge clk or posedge clr) begin
		if (clr)
			q <= 0;
		else
			q <= d;
	end
endmodule



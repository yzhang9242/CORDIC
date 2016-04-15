// Testbench for CORDIC
`timescale 1ns/1ps

module CORDIC_tb();
	reg rst;
	reg [15 : 0] x_in, y_in, z_in;
	wire [15 : 0] x_out, y_out;

	// Set simulation time
	initial begin
		#100;
	end

	// Generate reset signal
	initial begin
		rst = 0;
		#10 rst = 1;
	end

	// Generate input data
	always @(rst) begin
		if (rst == 0) begin
			x_in = 0;
			y_in = 0;
			z_in = 0;
		end
		else begin
			x_in = 700;
			y_in = 1100;
			z_in = 9472;
		end
	end

	// Instantiate DUT
	cordic_nppl dut(
			.real_in(x_in),
			.img_in(y_in),
			.theta_in(z_in),
			.real_out(x_out),
			.img_out(y_out));

	// Monitor output data
	initial begin
		$monitor("%d, %d\n", x_out, y_out);
	end

endmodule

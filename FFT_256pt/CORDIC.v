// non-pipeline CORDIC module
module cordic_nppl (real_out, img_out, real_in, img_in, theta_in);
	input signed [15 : 0] real_in;
	input signed [15 : 0] img_in;
	input signed [15 : 0] theta_in;
	output signed [15 : 0] real_out;
	output signed [15 : 0] img_out;
	
	wire [15 : 0] x_pass[0 : 16];
	wire [15 : 0] y_pass[0 : 16];
	wire [15 : 0] z_pass[0 : 16];

	// Define rotation angle in each iteration
	wire [15 : 0] rota [0 : 15];
	assign rota[0] = 11520;
	assign rota[1] = 6801;
	assign rota[2] = 3593;
	assign rota[3] = 1824;
	assign rota[4] = 915;
	assign rota[5] = 458;
	assign rota[6] = 229;
	assign rota[7] = 115;
	assign rota[8] = 57;
	assign rota[9] = 29;
	assign rota[10] = 14;
	assign rota[11] = 7;
	assign rota[12] = 4;
	assign rota[13] = 2;
	assign rota[14] = 1;
	assign rota[15] = 0;

	// CORDIC iteration
	task cordic_iter;
		input signed [15 : 0] x_in, y_in, z_in;
		input integer index;
		output signed [15 : 0] x_out, y_out, z_out;
		begin
			if (z_in[15]) begin
				x_out = x_in + (y_in >>> index);
				y_out = y_in - (x_in >>> index);
				z_out = z_in + rota[index];
			end
			else begin
				x_out = x_in - (y_in >>> index);
				y_out = y_in + (x_in >>> index);
				z_out = z_in - rota[index];
			end
		end
	endtask

	// non-pipelined CORDIC
	assign x_pass[0] = real_in;
	assign y_pass[0] = img_in;
	assign z_pass[0] = theta_in;

	genvar i;
	generate
		for (i = 0; i < 17; i = i + 1) begin : iter_gen
			cordic_iter(x_pass[i], y_pass[i], z_pass[i], i, x_pass[i + 1], y_pass[i + 1], z_pass[i + 1]);
		end
	endgenerate

	assign real_out = x_pass[16];
	assign img_out = y_pass[16];

endmodule

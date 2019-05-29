module phy_tx(
    input reset_L,
    input clk_8f,
    input enable,
    input valid_data_0,
    input valid_data_1,
    input [7:0]data_in_0,
    input [7:0]data_in_1,
    output reg tx_out_0_cond,
    output reg tx_out_1_cond);

reg[7:0]        data_reg_0;
reg[7:0]        data_reg_1;
reg             valid_reg_0;
reg             valid_reg_1;

//Wires
/*AUTOREG*/
/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire [7:0]		data_mux;		// From mux0 of mux.v
wire [7:0]		data_stripe_0;		// From byte of bs.v
wire [7:0]		data_stripe_1;		// From byte of bs.v
wire			out;			// From line0 of partoserial.v, ...
wire			valid_mux;		// From mux0 of mux.v
wire			valid_stripe_0;		// From byte of bs.v
wire			valid_stripe_1;		// From byte of bs.v
// End of automatics
wire clk_2f;
wire clk_f;
wire out_0;
wire out_1;

always @(posedge clk_2f) begin
    if(~reset_L) begin
        data_reg_0 <= 0;
        data_reg_1 <= 0;
        valid_reg_0 <= 0;
        valid_reg_1 <= 0;
    end else begin
        data_reg_0 <= data_in_0;
        data_reg_1 <= data_in_1;
        valid_reg_0 <= valid_data_0;
        valid_reg_1 <= valid_data_1;
    end
end

always @(posedge clk_8f) begin
    if(~reset_L) begin
        tx_out_0_cond <= 0;
        tx_out_1_cond <= 0;
    end else begin
        tx_out_0_cond <= out_0;
        tx_out_1_cond <= out_1;
    end
end

gen_clk clocks (/*autoinst*/
		// Outputs
		.clk_2f			(clk_2f),
		.clk_f			(clk_f),
		// Inputs
		.clk_8f			(clk_8f),
		.enable			(enable));
mux mux0 (/*autoinst*/
	  // Outputs
	  .data_mux			(data_mux[7:0]),
	  .valid_mux			(valid_mux),
	  // Inputs
	  .clk_2f			(clk_2f),
	  .reset_L			(reset_L),
	  .valid_reg_0			(valid_reg_0),
	  .data_reg_0			(data_reg_0[7:0]),
	  .valid_reg_1			(valid_reg_1),
	  .data_reg_1			(data_reg_1[7:0]));

bs byte (/*autoinst*/
	 // Outputs
	 .data_stripe_0			(data_stripe_0[7:0]),
	 .valid_stripe_0		(valid_stripe_0),
	 .data_stripe_1			(data_stripe_1[7:0]),
	 .valid_stripe_1		(valid_stripe_1),
	 // Inputs
	 .data_mux			(data_mux[7:0]),
	 .valid_mux			(valid_mux),
	 .reset_L			(reset_L),
	 .clk_2f			(clk_2f));

partoserial line0 (/*autoinst*/
		   // Outputs
		   .out			(out_0),
		   // Inputs
		   .data_stripe		(data_stripe_0[7:0]),
		   .valid_stripe	(valid_stripe_0),
		   .reset_L		(reset_L),
		   .clk_8f		(clk_8f));

partoserial line1 (/*autoinst*/
		   // Outputs
		   .out			(out_1),
		   // Inputs
		   .data_stripe		(data_stripe_1[7:0]),
		   .valid_stripe	(valid_stripe_1),
		   .reset_L		(reset_L),
		   .clk_8f		(clk_8f));
endmodule


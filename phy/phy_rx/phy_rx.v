module phy_rx(
    input clk_8f,
    input reset_L,
    input in_0,
    input in_1,
	input enable,
    output reg [7:0] data_out_0_cond,
    output reg [7:0] data_out_1_cond,
	output reg valid_out_0_cond,
	output reg valid_out_1_cond
);
/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire [7:0]		data_demux_0;		// From demux0 of demux.v
wire [7:0]		data_demux_1;		// From demux0 of demux.v
wire [7:0]		data_unstripped;	// From byte_uns of byte_unstripping.v
wire			valid_demux_0;		// From demux0 of demux.v
wire			valid_demux_1;		// From demux0 of demux.v
wire [7:0]		data_par_0;		// From line0 of serialtopar.v, ...
wire			valid_par_0;		// From line0 of serialtopar.v, ...
wire [7:0]		data_par_1;		// From line0 of serialtopar.v, ...
wire			valid_par_1;		// From line0 of serialtopar.v, ...
wire			valid_unstripped;	// From byte_uns of byte_unstripping.v
// End of automatics
wire clk_2f;
wire clk_f;

always @(posedge clk_2f) begin
    if(~reset_L) begin
        data_out_0_cond<='b0;
        data_out_1_cond<='b0;
		valid_out_0_cond<='b0;
		valid_out_1_cond<='b0;
    end else begin
        data_out_0_cond<=data_demux_0;
        data_out_1_cond<=data_demux_1;
		valid_out_0_cond<=valid_demux_0;
		valid_out_1_cond<=valid_demux_1;
    end
end

gen_clk clocks (/*autoinst*/
		// Outputs
		.clk_2f			(clk_2f),
		.clk_f			(clk_f),
		// Inputs
		.clk_8f			(clk_8f),
		.enable			(enable));

serialtopar line0(/*AUTOINST*/
		  // Outputs
		  .data_par		(data_par_0[7:0]),
		  .valid_par		(valid_par_0),
		  // Inputs
		  .clk_f		(clk_f),
		  .clk_8f		(clk_8f),
		  .reset_L		(reset_L),
		  .in			(in_0));
serialtopar line1(/*AUTOINST*/
		  // Outputs
		  .data_par		(data_par_1[7:0]),
		  .valid_par		(valid_par_1),
		  // Inputs
		  .clk_f		(clk_f),
		  .clk_8f		(clk_8f),
		  .reset_L		(reset_L),
		  .in			(in_1));
byte_unstripping byte_uns(/*AUTOINST*/
			  // Outputs
			  .data_unstripped	(data_unstripped[7:0]),
			  .valid_unstripped	(valid_unstripped),
			  // Inputs
			  .clk_2f		(clk_2f),
			  .reset_L		(reset_L),
			  .data_par_0		(data_par_0[7:0]),
			  .data_par_1		(data_par_1[7:0]),
			  .valid_par_0		(valid_par_0),
			  .valid_par_1		(valid_par_1));
demux demux0(/*AUTOINST*/
	     // Outputs
	     .data_demux_0		(data_demux_0[7:0]),
	     .data_demux_1		(data_demux_1[7:0]),
	     .valid_demux_0		(valid_demux_0),
	     .valid_demux_1		(valid_demux_1),
	     // Inputs
	     .valid_unstripped		(valid_unstripped),
	     .clk_2f			(clk_2f),
	     .reset_L			(reset_L),
	     .data_unstripped		(data_unstripped[7:0]));



endmodule

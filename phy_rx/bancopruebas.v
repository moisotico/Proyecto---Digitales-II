`timescale 1ns /100 ps

`include "probador.v"
`include "phy_rx.v"
`include "phy_rxSynth.v"
module bancopruebas;
/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			clk_8f;			// From probador of probador.v
wire [7:0]		data_out_0_cond;	// From phy_rxcond of phy_rx.v
wire [7:0]		data_out_0_estruct;	// From phy_rxestruct of phy_rxSynth.v
wire [7:0]		data_out_1_cond;	// From phy_rxcond of phy_rx.v
wire [7:0]		data_out_1_estruct;	// From phy_rxestruct of phy_rxSynth.v
wire			enable;			// From probador of probador.v
wire			in_0;			// From probador of probador.v
wire			in_1;			// From probador of probador.v
wire			reset_L;		// From probador of probador.v
wire			valid_out_0_cond;	// From phy_rxcond of phy_rx.v
wire			valid_out_0_estruct;	// From phy_rxestruct of phy_rxSynth.v
wire			valid_out_1_cond;	// From phy_rxcond of phy_rx.v
wire			valid_out_1_estruct;	// From phy_rxestruct of phy_rxSynth.v
// End of automatics
/*autoreg*/
    phy_rx phy_rxcond(/*autoinst*/
		      // Outputs
		      .data_out_0_cond	(data_out_0_cond[7:0]),
		      .data_out_1_cond	(data_out_1_cond[7:0]),
		      .valid_out_0_cond	(valid_out_0_cond),
		      .valid_out_1_cond	(valid_out_1_cond),
		      // Inputs
		      .clk_8f		(clk_8f),
		      .reset_L		(reset_L),
		      .in_0		(in_0),
		      .in_1		(in_1),
		      .enable		(enable));
    phy_rxSynth phy_rxestruct(/*autoinst*/
			      // Outputs
			      .data_out_0_estruct(data_out_0_estruct[7:0]),
			      .data_out_1_estruct(data_out_1_estruct[7:0]),
			      .valid_out_0_estruct(valid_out_0_estruct),
			      .valid_out_1_estruct(valid_out_1_estruct),
			      // Inputs
			      .clk_8f		(clk_8f),
			      .enable		(enable),
			      .in_0		(in_0),
			      .in_1		(in_1),
			      .reset_L		(reset_L));
    probador probador(/*autoinst*/
		      // Outputs
		      .clk_8f		(clk_8f),
		      .reset_L		(reset_L),
		      .in_0		(in_0),
		      .in_1		(in_1),
		      .enable		(enable),
		      // Inputs
		      .data_out_0_cond	(data_out_0_cond[7:0]),
		      .data_out_1_cond	(data_out_1_cond[7:0]),
		      .valid_out_0_cond	(valid_out_0_cond),
		      .valid_out_1_cond	(valid_out_1_cond),
		      .data_out_0_estruct(data_out_0_estruct[7:0]),
		      .data_out_1_estruct(data_out_1_estruct[7:0]),
		      .valid_out_0_estruct(valid_out_0_estruct),
		      .valid_out_1_estruct(valid_out_1_estruct));
endmodule

`timescale 1ns /100 ps

`include "probador.v"
`include "phy_tx.v"

module bancopruebas;
/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			clk_8f;			// From probador of probador.v
wire [7:0]		data_in_0;		// From probador of probador.v
wire [7:0]		data_in_1;		// From probador of probador.v
wire			enable;			// From probador of probador.v
wire			reset_L;		// From probador of probador.v
wire			tx_out_0;		// From phy_cond of phy_tx.v
wire			tx_out_1;		// From phy_cond of phy_tx.v
wire			valid_data_0;		// From probador of probador.v
wire			valid_data_1;		// From probador of probador.v
// End of automatics
/*autoreg*/
    phy_tx phy_cond(/*autoinst*/
		    // Outputs
		    .tx_out_0		(tx_out_0),
		    .tx_out_1		(tx_out_1),
		    // Inputs
		    .reset_L		(reset_L),
		    .clk_8f		(clk_8f),
		    .enable		(enable),
		    .valid_data_0	(valid_data_0),
		    .valid_data_1	(valid_data_1),
		    .data_in_0		(data_in_0[7:0]),
		    .data_in_1		(data_in_1[7:0]));
    probador probador(/*autoinst*/
		      // Outputs
		      .reset_L		(reset_L),
		      .clk_8f		(clk_8f),
		      .enable		(enable),
		      .valid_data_0	(valid_data_0),
		      .data_in_0	(data_in_0[7:0]),
		      .valid_data_1	(valid_data_1),
		      .data_in_1	(data_in_1[7:0]),
		      // Inputs
		      .tx_out_0		(tx_out_0),
		      .tx_out_1		(tx_out_1));
endmodule

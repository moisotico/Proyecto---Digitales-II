`timescale 1ns /100 ps

`include "probador.v"
`include "phy_tx.v"

module bancopruebas;
/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			clk_8f;			// From probador of probador.v
wire			enable;			// From probador of probador.v
wire [7:0]		entrada_0;		// From probador of probador.v
wire [7:0]		entrada_1;		// From probador of probador.v
wire			reset;			// From probador of probador.v
wire			salida_ser_lane_0;	// From phy_cond of phy_tx.v
wire			salida_ser_lane_1;	// From phy_cond of phy_tx.v
wire			validin0;		// From probador of probador.v
wire			validin1;		// From probador of probador.v
// End of automatics
/*AUTOREG*/
    phy_tx phy_cond(/*AUTOINST*/
		    // Outputs
		    .salida_ser_lane_0	(salida_ser_lane_0),
		    .salida_ser_lane_1	(salida_ser_lane_1),
		    // Inputs
		    .reset		(reset),
		    .clk_8f		(clk_8f),
		    .enable		(enable),
		    .validin0		(validin0),
		    .validin1		(validin1),
		    .entrada_0		(entrada_0[7:0]),
		    .entrada_1		(entrada_1[7:0]));
    probador probador(/*AUTOINST*/
		      // Outputs
		      .reset		(reset),
		      .clk_8f		(clk_8f),
		      .enable		(enable),
		      .validin0		(validin0),
		      .entrada_0	(entrada_0[7:0]),
		      .validin1		(validin1),
		      .entrada_1	(entrada_1[7:0]),
		      // Inputs
		      .salida_ser_lane_0_cond(salida_ser_lane_0_cond),
		      .salida_ser_lane_1_cond(salida_ser_lane_1_cond));
endmodule

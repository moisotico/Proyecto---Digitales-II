/*
 *Universidad de Costa Rica - Escuela de Ingenieria Electrica
 *Proyecto #1 - IE-0523 - modulo tb del serialtopar
 *@author Giancarlo Marin H.
 *@date   29/05/2019
 *@brief  Banco de pruebas del phy para el pcie con su respectivo probador
*/

`timescale 	1ns				/ 100ps		// escala
// includes de archivos de verilog
`include "phy.v"
`include "phy_synth.v"
`include "probador.v"
`include "cmos_cells.v"

module tb(); // Testbench
	//wires de interconexion del modulo y su probador
	/*AUTOWIRE*/
	// Beginning of automatic wires (for undeclared instantiated-module outputs)
	wire		clk_8f;			// From test of probador.v
	wire [7:0]	data_in_0;		// From test of probador.v
	wire [7:0]	data_in_1;		// From test of probador.v
	wire [7:0]	data_out_0;		// From pcie_phy_con of phy.v, ...
	wire [7:0]	data_out_1;		// From pcie_phy_con of phy.v, ...
	wire		enable;			// From test of probador.v
	wire		reset_L;		// From test of probador.v
	wire		valid_data_in_0;	// From test of probador.v
	wire		valid_data_in_1;	// From test of probador.v
	wire		valid_data_out_0;	// From pcie_phy_con of phy.v
	wire		valid_data_out_1;	// From pcie_phy_con of phy.v
	// End of automatics
	

	// Instanciacion de modulos con los parametros definidos
	phy pcie_phy_con(/*autoinst*/
			.valid_data_out_0(valid_data_out_0_cond),
			.valid_data_out_1(valid_data_out_1_cond),
			.data_out_0(data_out_0_cond[7:0]),
			.data_out_1(data_out_1_cond[7:0]),
			.clk_8f(clk_8f),
			.reset_L(reset_L),
			.enable(enable),
			.data_in_0(data_in_0[7:0]),
			.data_in_1(data_in_1[7:0]),
			.valid_data_in_0(valid_data_in_0),
			.valid_data_in_1(valid_data_in_1));

	phy_synth pcie_est(/*autoinst*/
			.data_out_0(data_out_0_estruct[7:0]),
			.data_out_1(data_out_1_estruct[7:0]),
			.valid_data_out_0(valid_data_out_0_estruct),
			.valid_data_out_1(valid_data_out_1_estruct),
			.clk_f(clk_f),
			.data_in_0(data_in_0[7:0]),
			.data_in_1(data_in_1[7:0]),
			.enable(enable),
			.reset_L(reset_L),
			.valid_data_in_0(valid_data_in_0),
			.valid_data_in_1(valid_data_in_1));
		
	probador test (/*autoinst*/
			.clk_8f(clk_8f),
			.reset_L(reset_L),
			.data_in_0(data_in_0[7:0]),
			.data_in_1(data_in_1[7:0]),
			.valid_data_in_0(valid_data_in_0),
			.valid_data_in_1(valid_data_in_1),
			.enable(enable),
			.data_out_0_cond(data_out_0_cond[7:0]),
			.data_out_1_cond(data_out_1_cond[7:0]),
			.valid_out_data_0_cond(valid_out_data_0_cond),
			.valid_out_data_1_cond(valid_out_data_1_cond),
			.data_out_0_estruct(data_out_0_estruct[7:0]),
			.data_out_1_estruct(data_out_1_estruct[7:0]),
			.valid_data_out_0_estruct(valid_data_out_0_estruct),
			.valid_data_out_1_estruct(valid_data_out_1_estruct));

endmodule

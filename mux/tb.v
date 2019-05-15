/*
 *Universidad de Costa Rica - Escuela de Ingenieria Electrica
 *Proyecto #1 - IE-0523 - modulo tb del mux
 *@author Giancarlo Marin H.
 *@date   14/05/2019
 *@brief  Banco de pruebas del mux con su respectivo probador
*/

`timescale 	1ns				/ 100ps		// escala
// includes de archivos de verilog
`include "mux.v"
`include "mux_synth.v"
`include "probador.v"
`include "cmos_cells.v"

module tb(); // Testbench
	//wires de interconexion del modulo y su probador
	wire[7:0] 	data_in_0, data_in_1, data_out_c, data_out_e;
	wire 		clk, reset_L, valid_in_0, valid_in_1, valid_out_c, valid_out_e;

	// Instanciacion de modulos con los parametros definidos
	mux mux_con(/*autoinst*/
			.data_out(data_out_c[7:0]),
			.valid_out(valid_out_c),
			.clk(clk),
			.reset_L(reset_L),
			.valid_in_0(valid_in_0),
			.data_in_0(data_in_0[7:0]),
			.valid_in_1(valid_in_1),
			.data_in_1(data_in_1[7:0]));

	mux_synth mux_est(/*autoinst*/
			.data_out(data_out_e[7:0]),
			.valid_out(valid_out_e),
			.clk(clk),
			.data_in_0(data_in_0[7:0]),
			.data_in_1(data_in_1[7:0]),
			.reset_L(reset_L),
			.valid_in_0(valid_in_0),
			.valid_in_1(valid_in_1));
		
	probador test (/*autoinst*/
			.clk(clk),
			.reset_L(reset_L),
			.data_in_0(data_in_0[7:0]),
			.valid_in_0(valid_in_0),
			.data_in_1(data_in_1[7:0]),
			.valid_in_1(valid_in_1),
			.data_out_c(data_out_c[7:0]),
			.data_out_e(data_out_e[7:0]),
			.valid_out_c(valid_out_c),
			.valid_out_e(valid_out_e));
endmodule
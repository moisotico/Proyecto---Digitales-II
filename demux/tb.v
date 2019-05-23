/*
 *Universidad de Costa Rica - Escuela de Ingenieria Electrica
 *Proyecto #1 - IE-0523 - modulo tb del demux
 *@author Giancarlo Marin H.
 *@date   15/05/2019
 *@brief  Banco de pruebas del demux con su respectivo probador
*/

`timescale 	1ns				/ 100ps		// escala
// includes de archivos de verilog
`include "demux.v"
`include "demux_synth.v"
`include "probador.v"
`include "cmos_cells.v"

module tb(); // Testbench
	//wires de interconexion del modulo y su probador
	wire[7:0] 	data_in, data_out0_c, data_out0_e, data_out1_c, data_out1_e;
	wire 		clk, reset_L, valid_in, valid_out0_c, valid_out0_e, valid_out1_c, valid_out1_e;

	// Instanciacion de modulos con los parametros definidos
	demux mux_con(/*autoinst*/
			.data_out0(data_out0_c[7:0]),
			.data_out1(data_out1_c[7:0]),
			.valid_out0(valid_out0_c),
			.valid_out1(valid_out1_c),
			.valid_in(valid_in),
			.clk(clk),
			.reset_L(reset_L),
			.data_in(data_in[7:0]));

	demux_synth mux_est(/*autoinst*/
			.data_out0(data_out0_e[7:0]),
			.data_out1(data_out1_e[7:0]),
			.valid_out0(valid_out0_e),
			.valid_out1(valid_out1_e),
			.clk(clk),
			.data_in(data_in[7:0]),
			.reset_L(reset_L),
			.valid_in(valid_in));
		
	probador test (/*autoinst*/
			.clk(clk),
			.reset_L(reset_L),
			.data_in(data_in[7:0]),
			.valid_in(valid_in),
			.data_out0_c(data_out0_c[7:0]),
			.data_out0_e(data_out0_e[7:0]),
			.valid_out0_c(valid_out0_c),
			.valid_out0_e(valid_out0_e),
			.data_out1_c(data_out1_c[7:0]),
			.data_out1_e(data_out1_e[7:0]),
			.valid_out1_c(valid_out1_c),
			.valid_out1_e(valid_out1_e));
endmodule
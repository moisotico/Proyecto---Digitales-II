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
`include "gen_clk.v"

module tb(); // Testbench
	//wires de interconexion del modulo y su probador
	/*AUTOWIRE*/
	

	// Instanciacion de modulos con los parametros definidos
	phy pcie_phy_con(/*autoinst*/);

	phy_synth pcie_est(/*autoinst*/);
		
	probador test (/*autoinst*/);

endmodule
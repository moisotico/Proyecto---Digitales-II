/*
 *Universidad de Costa Rica - Escuela de Ingenieria Electrica
 *Proyecto #1 - IE-0523 - modulo probador del serialtopar
 *@author Giancarlo Marin H.
 *@date   20/05/2019
 *@brief  Modulo que genera las señales y monitoriza las salidas del modulo serialtopar conductual y estructural sintetizado
*/

`include "checker.v"

module probador (
	output reg 					clk_f,			// generador del clock
	output reg 					clk_8f,			// generador del clock
	output reg 					reset_L,		// generador de reset
	output reg					data_in,		// generador de la entrada de dato 0
	input [7:0]					data_out_c,		// monitor de salida de datos cond
	input [7:0]					data_out_e,		// monitor de salida de datos estr
	input 						valid_out_c, 	// monitor de salida del bit valido cond
	input 						valid_out_e 	// monitor de salida del bit valido estr
	);
	wire check_data_out, check_valid;	// salidas del checker

	checker c0(/*autoinst*/
			.check_data_out(check_data_out),
			.check_valid(check_valid),
			.clk(clk_f),
			.reset_L(reset_L),
			.data_out_c(data_out_c[7:0]),
			.data_out_e(data_out_e[7:0]),
			.valid_out_c(valid_out_c),
			.valid_out_e(valid_out_e));

	initial begin
		$dumpfile("s2p.vcd");		// archivo "dump"
		$dumpvars;					// dumping de variables
		// Mensajes en consola 
		$display ("\t\tclk\treset_L\tdata_in \tdata_out_c valid_out_c\tdata_out_e valid_out_e\tcheck_data_out check_valid_out");
		$monitor($time,"\t%b\t%b\t%x %b\t%x %b\t%b %b", clk_f, reset_L, data_in, data_out_c, valid_out_c, data_out_e, valid_out_e, check_data_out,check_valid);
		// Pruebas
		data_in <= 0; 					
		// Pruebas #1: Reset bajo. 
		reset_L <= 0;
		// Prueba #2: Reset alto. Valido primer dato
		@(posedge clk_f);
		reset_L <= 1;
		// Prueba #3: Envía BC 4 veces
		repeat(4) begin
			@(posedge clk_8f);
			data_in <= 1;
			@(posedge clk_8f);
			data_in <= 0;
			@(posedge clk_8f);
			data_in <= 1;
			@(posedge clk_8f);
			data_in <= 1;
			@(posedge clk_8f);
			data_in <= 1;
			@(posedge clk_8f);
			data_in <= 1;
			@(posedge clk_8f);
			data_in <= 0;
			@(posedge clk_8f);
			data_in <= 0;
		end
		// Prueba #4: Envía 3 datos validos
		repeat(8) begin // envía FF
			@(posedge clk_8f);
			data_in <= 1;
		end
		// envia EE
		repeat(2) begin
			@(posedge clk_8f);
			data_in <= 1;
			@(posedge clk_8f);
			data_in <= 1;
			@(posedge clk_8f);
			data_in <= 1;
			@(posedge clk_8f);
			data_in <= 0;
		end
		//envia DD
		repeat(2) begin
			@(posedge clk_8f);
			data_in <= 1;
			@(posedge clk_8f);
			data_in <= 1;
			@(posedge clk_8f);
			data_in <= 0;
			@(posedge clk_8f);
			data_in <= 1;
		end
		// Prueba #5: Envía BC de nuevo. Se espera valid_out = 0
		@(posedge clk_8f);
		data_in <= 1;
		@(posedge clk_8f);
		data_in <= 0;
		@(posedge clk_8f);
		data_in <= 1;
		@(posedge clk_8f);
		data_in <= 1;
		@(posedge clk_8f);
		data_in <= 1;
		@(posedge clk_8f);
		data_in <= 1;
		@(posedge clk_8f);
		data_in <= 0;
		@(posedge clk_8f);
		data_in <= 0;
		// Prueba 6: Vuelve a enviar otro dato valido
		// envia AA
		repeat(4) begin
			@(posedge clk_8f);
			data_in <= 1;
			@(posedge clk_8f);
			data_in <= 0;
		end
		// Prueba 7: Reset alto y termina de almacenar señales
		repeat(7) begin
			@(posedge clk_8f);
		end
		reset_L <= 0;
		@(posedge clk_f);
		$finish;	
	end
	// Generador del clk
	initial	begin
		clk_f <= 0;				// Valor inicial del clk_f
		clk_8f <= 0;			// Valor inicial del clk_8f
	end
	always #1 clk_8f <= ~clk_8f;		// toggle cada 1ns -> 8f = 500MHz
	always #8 clk_f <= ~clk_f;			// toggle cada 8ns -> f = 62,5MHz
endmodule
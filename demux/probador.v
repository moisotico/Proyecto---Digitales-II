/*
 *Universidad de Costa Rica - Escuela de Ingenieria Electrica
 *Proyecto #1 - IE-0523 - modulo probador del demux
 *@author Giancarlo Marin H.
 *@date   15/05/2019
 *@brief  Modulo que genera las señales y monitoriza las salidas del modulo mux conductual y estructural sintetizado
*/

`include "checker.v"

module probador (
	output reg 					clk,			// generador del clock
	output reg 					reset_L,		// generador de reset
	output reg[7:0]				data_in,		// generador de la entrada de dato 0
	output reg 					valid_in,		// generador de bit valido entrada 0
	input [7:0]					data_out0_c,	// monitor de salida 0 de datos cond
	input [7:0]					data_out0_e,	// monitor de salida 0 de datos estr
	input 						valid_out0_c, 	// monitor de salida del bit valido 0 cond
	input 						valid_out0_e, 	// monitor de salida del bit valido 0 estr
	input [7:0]					data_out1_c,	// monitor de salida 1 de datos cond
	input [7:0]					data_out1_e,	// monitor de salida 1 de datos estr
	input 						valid_out1_c, 	// monitor de salida del bit valido 1 cond
	input 						valid_out1_e 	// monitor de salida del bit valido 1 estr
	);
	wire check_out0, check_out1, check_valid_out0, check_valid_out1;	// salidas del checker

	checker c0(/*autoinst*/
			.check_out0(check_out0),
			.check_out1(check_out1),
			.clk(clk),
			.reset_L(reset_L),
			.data_out0_c(data_out0_c[7:0]),
			.data_out1_c(data_out1_c[7:0]),
			.data_out0_e(data_out0_e[7:0]),
			.data_out1_e(data_out1_e[7:0]));

	initial begin
		$dumpfile("demux.vcd");		// archivo "dump"
		$dumpvars;					// dumping de variables
		// Mensajes en consola 
		$display ("\t\tclk\treset_L\tdata_in valid_in\tcheck_out0 check_out1");
		$monitor($time,"\t%b\t%b\t%x %b\t%x %b\t%b %b", clk, reset_L, data_in, valid_in, check_out0,check_out1);
		// Pruebas
		valid_in <= 0;
		data_in <= 7'b0; 					
		// Pruebas #1: Reset bajo. 
		reset_L <= 0;
		// Prueba #2: Reset alto. Valido primer dato
		@(posedge clk);
		reset_L <= 1;
		// Sincroniza
		@(posedge clk);
		valid_in <= 1;
		data_in <= 8'hff;
		repeat(3) begin
			@(posedge clk) begin
				data_in <= data_in - 8'h11;
			end
		end
		// Prueba #3: Espera
		@(posedge clk) begin
			valid_in <= 0;
		end
		@(posedge clk);
		@(posedge clk);
		// Prueba #4: Continua la entrada de dato_in por dos ciclos mas
		@(posedge clk) begin
			valid_in <= 1;
			data_in <= 8'h03;
		end
		@(posedge clk) begin
			data_in <= 8'h04;
		end
		@(posedge clk) begin
			valid_in <= 0;
		end
		@(posedge clk);
		@(posedge clk);
		// Prueba #5: Prueba del funcionamiento de selector interno con entrada de mas datos
		@(posedge clk) begin
			valid_in <= 1;
			data_in <= 8'haa;
		end
		@(posedge clk) begin
			data_in <= 8'h99;
		end
		@(posedge clk) begin
			valid_in <= 0;
		end
		@(posedge clk);
		@(posedge clk);
		// Prueba #6: Ultima entrada de datos
		@(posedge clk) begin
			valid_in <= 1;
			data_in <= 8'h07;
		end
		@(posedge clk) begin
			data_in <= 8'h08;
		end
		@(posedge clk) begin
			valid_in <= 0;
		end
		@(posedge clk);
		@(posedge clk);
		// Prueba 7: Reset alto y termina de almacenar señales
		@(posedge clk);
		reset_L <= 0;
		#10 $finish;	
	end
	// Generador del clk
	initial	clk <= 0;				// Valor inicial del clk
	always #10 clk <= ~clk;			// toggle cada 10ns
endmodule
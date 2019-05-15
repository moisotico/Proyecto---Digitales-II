/*
 *Universidad de Costa Rica - Escuela de Ingenieria Electrica
 *Proyecto #1 - IE-0523 - modulo probador del mux
 *@author Giancarlo Marin H.
 *@date   14/05/2019
 *@brief  Modulo que genera las señales y monitoriza las salidas del modulo mux conductual y estructural sintetizado
*/

`include "checker.v"

module probador (
	output reg 					clk,			// generador del clock
	output reg 					reset_L,		// generador de reset
	output reg[7:0]				data_in_0,		// generador de la entrada de dato 0
	output reg 					valid_in_0,		// generador de bit valido entrada 0
	output reg[7:0]				data_in_1,		// generador de la entrada de dato 1
	output reg 					valid_in_1,		// generador de bit valido entrada 1
	input [7:0]					data_out_c,		// monitor de salida de datos cond
	input [7:0]					data_out_e,		// monitor de salida de datos estr
	input 						valid_out_c, 	// monitor de salida del bit valido cond
	input 						valid_out_e 	// monitor de salida del bit valido estr
	);
	wire check_data_out, check_valid;	// salidas del checker

	checker c0(/*autoinst*/
			.check_data_out(check_data_out),
			.check_valid(check_valid),
			.clk(clk),
			.reset_L(reset_L),
			.data_out_c(data_out_c[7:0]),
			.data_out_e(data_out_e[7:0]),
			.valid_out_c(valid_out_c),
			.valid_out_e(valid_out_e));

	initial begin
		$dumpfile("mux.vcd");		// archivo "dump"
		$dumpvars;					// dumping de variables
		// Mensajes en consola 
		$display ("\t\tclk\treset_L\tdata_in_0 valid_in_0\tdata_in_1 valid_in_1\tcheck_data_out check_valid_out");
		$monitor($time,"\t%b\t%b\t%x %b\t%x %b\t%b %b", clk, reset_L, data_in_0, valid_in_0, data_in_1, valid_in_1,check_data_out,check_valid);
		// Pruebas
		valid_in_0 <= 0;
		valid_in_1 <= 0;
		data_in_0 <= 4'b0; 					
		data_in_1 <= 4'b0;
		// Pruebas #1: Reset bajo. 
		reset_L <= 0;
		// Prueba #2: Reset alto. Valido primer dato
		@(posedge clk) begin
			reset_L <= 1;
			valid_in_0 <= 1;
			data_in_0 <= 8'hff;
		end
		// Prueba #3: Ignora entrada de dato_in_1
		@(posedge clk) begin
			data_in_0 <= 8'hee;
			valid_in_1 <= 1;
			data_in_1 <= 8'h00;
		end
		// Prueba #3: Continua la entrada de dato_in_0 por dos ciclos mas
		@(posedge clk) begin
			data_in_0 <= 8'hdd;
			data_in_1 <= 8'h11;
		end
		@(posedge clk) begin
			data_in_0 <= 8'hcc;
			data_in_1 <= 8'h22;
		end
		// Prueba #4: Genera una espera de dos ciclos para sincronizar despues de colocar ambos valid en bajo
		@(posedge clk) begin
			valid_in_0 <= 0;
			valid_in_1 <= 0;
		end
		@(posedge clk);
		// Prueba #5: Recibe datos de la entrada 1 e ignora datos de entrada 0 porque llegan un ciclo despues
		@(posedge clk) begin
			valid_in_1 <= 1;
			data_in_1 <= 8'h33;
		end
		@(posedge clk) begin
			data_in_0 <= 8'hbb;
			valid_in_0 <= 1;
			data_in_1 <= 8'h44;
		end
		// Sincroniza
		@(posedge clk) begin
			valid_in_0 <= 0;
			valid_in_1 <= 0;
		end
		@(posedge clk);
		// Prueba #6: Funcionamiento de selector para dos sucesos de datos que llegan al mismo tiempo
		@(posedge clk) begin
			valid_in_0 <= 1;
			valid_in_1 <= 1;
			data_in_0 <= 8'haa;
			data_in_1 <= 8'h55;
		end
		@(posedge clk) begin
			data_in_0 <= 8'h99;
			data_in_1 <= 8'h66;
		end
		// Sincroniza
		@(posedge clk) begin
			valid_in_0 <= 0;
			valid_in_1 <= 0;
		end
		@(posedge clk);
		@(posedge clk) begin
			valid_in_0 <= 1;
			valid_in_1 <= 1;
			data_in_0 <= 8'h88;
			data_in_1 <= 8'h77;
		end
		@(posedge clk) begin
			data_in_0 <= 8'h77;
			data_in_1 <= 8'h88;
		end
		// Sincroniza
		@(posedge clk) begin
			valid_in_0 <= 0;
			valid_in_1 <= 0;
		end
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
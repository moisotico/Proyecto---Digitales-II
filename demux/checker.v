/*
 *Universidad de Costa Rica - Escuela de Ingenieria Electrica
 *Proyecto #1 - IE-0523 - modulo demux
 *@author Giancarlo Marin H.
 *@date   15/05/2019
 *@brief  Modulo de chequeo entre las señales de dos demux 1 a 2 de 7bit con selector automatico y bits de valido
*/

module checker(
	output reg		check_out0,		// salida de 1 bit que indica que ambos datos de la salida 0 son iguales	
	output reg		check_out1,		// salida de 1 bit que indica que ambos datos de la salida 1 son iguales	
	input 			clk,			// señal de clock del modulo	
	input 			reset_L,		// señal de reset_L del modulo
	input [7:0]		data_out0_c,	// salida 0 del demultiplexor conductual
	input [7:0]		data_out1_c,	// salida 1 del demultiplexor conductual
	input [7:0]		data_out0_e,			// salida 0 del demultiplexor estructural
	input [7:0]		data_out1_e			// salida 1 del demultiplexor estructural
	);
	reg [7:0] 		out_c_0,out_e_0,out_c_1,out_e_1; //ff
	
	always @(posedge clk) begin		// ffs para registrar las entradas
		if(reset_L==0) begin
			out_c_0 <= 0;
			out_c_1 <= 0;
			out_e_0 <= 0;
			out_e_1 <= 0;
		end else begin
			out_c_0 <= data_out0_c;
			out_c_1 <= data_out1_c;
			out_e_0 <= data_out0_e;
			out_e_1 <= data_out1_e;
		end
	end

	always @(posedge clk) begin		// bloque de comparacion en los flancos de reloj
		if (reset_L==1) begin
			if (out_c_0==out_e_0) begin
				check_out0<=1;
			end
			else begin
				check_out0<=0;
				$display ($time,"Error diferencia entre modulos");
			end 
			if (out_c_1==out_e_1) begin
				check_out1<=1;
			end
			else begin
				check_out1<=0;
				$display ($time,"Error diferencia entre modulos");
			end 
		end
		else begin
			check_out0<=1;
			check_out1<=1;
		end
	end
endmodule // checker_mux
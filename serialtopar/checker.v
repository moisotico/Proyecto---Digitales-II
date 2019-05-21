/*
 *Universidad de Costa Rica - Escuela de Ingenieria Electrica
 *Proyecto #1 - IE-0523 - modulo checker del mux
 *@author Giancarlo Marin H.
 *@date   14/05/2019
 *@brief  Modulo de chequeo entre las señales de dos mux uno conductual y otro estructural
*/

module checker(
	output reg		check_data_out,	// salida de 1 bit que indica que ambos datos de data_out son iguales	
	output reg 		check_valid,	// salida de 1 bit que indica que ambos bits de valido son iguales
	input 			clk,			// señal de clock del modulo	
	input 			reset_L,		// señal de reset_L del modulo
	input [7:0]		data_out_c,		// entrada de datos generada por del modulo conductual
	input [7:0]		data_out_e,		// entrada de datos generada por el modulo estructural
	input 			valid_out_c,	// entrada de bit de valido por el modulo conductual
	input 			valid_out_e	// entrada de bit de valido por el modulo estructural
	);
	// ffs de entrada 
	reg [7:0] 		out_c,out_e; 	
	reg 			valid_c,valid_e;
	
	always @(posedge clk) begin		// ffs para registrar las entradas
		if(reset_L==0) begin
			out_c <= 0;
			out_e <= 0;
			valid_c <= 0;
			valid_e <= 0;
		end else begin
			out_c <= data_out_c;
			out_e <= data_out_e;
			valid_c <= valid_out_c;
			valid_e <= valid_out_e;
		end
	end

	always @(posedge clk) begin		// bloque de comparacion en los flancos de reloj
		if (reset_L==1) begin
			if (out_c == out_e) begin
				check_data_out<=1;
			end
			else begin
				check_data_out<=0;
				$display ($time,"Error diferencia entre modulos");
			end 
			if (valid_c==valid_e) begin
				check_valid<=1;
			end
			else begin
				check_valid<=0;
				$display ($time,"Error diferencia entre modulos");
			end 
		end
		else begin
			check_data_out<=1;
			check_valid<=1;
		end
	end
endmodule // checker
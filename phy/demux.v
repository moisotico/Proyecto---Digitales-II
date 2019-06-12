/*
 *Universidad de Costa Rica - Escuela de Ingenieria Electrica
 *Proyecto #1 - IE-0523 - modulo demux
 *@author Giancarlo Marin H.
 *@date   15/05/2019
 *@brief  Descripcion conductual del modulo demux 1:2 con entrada de 8 bits y bit de valido en la entrada y salidas
*/

module demux(
	output reg[7:0]	data_demux_0,		// salida 0 de tipo reg del demultiplexor
	output reg[7:0]	data_demux_1,		// salida 1 de tipo reg del demultiplexor
	output reg 		valid_demux_0,		// salida 0 bit de valid 
	output reg 		valid_demux_1,		// salida 1 bit de valid
	input 			valid_unstripped,		// entrada de datos valid
	input 			clk_2f,			// señal de clock del modulo
	input 			reset_L,		// señal de reset en bajo del modulo
	input [7:0]		data_unstripped			// señal entrada de datos del demultiplexor
	);

	reg selector, first, toggle, reading;								// flags de control
	reg valid_0, valid_1;								// flags de valid
	reg [7:0] data_0, data_1;							// registros internos para los datos
	
	always@(*)begin
		data_0=0;
		data_1=0;
		valid_0=0;
		valid_1=0;
		reading=0;
		if (~reset_L)begin
			data_0=0;
			data_1=0;
			valid_0=0;
			valid_1=0;
			reading=0;
		end else begin
			if (valid_unstripped)begin
				reading=1;
				if (~selector)begin
					data_0=data_unstripped;
					valid_0=valid_unstripped;
				end else begin
					data_1=data_unstripped;
					valid_1=valid_unstripped;
				end
			end else begin
				reading=0;
			end
		end
	end

	always @(posedge clk_2f) begin
		if(~reset_L) begin
			data_demux_0 <= 0;
			data_demux_1 <= 0;
			valid_demux_0 <= 0;
			valid_demux_1 <= 0;
			selector <= 0;
			toggle <= 0;
			first <= 0;
		end else begin
			if (~first)begin
				selector<=0;
				toggle<=0;
			end
			if (reading)begin
				toggle<=1;
				first<=1;
			end
			else if (toggle && ~valid_unstripped)begin
				selector<=~selector;
				toggle<=0;
			end else begin
				toggle<=0;
			end
			
			data_demux_0 <= data_0;
			data_demux_1 <= data_1;
			valid_demux_0 <= valid_0;
			valid_demux_1 <= valid_1;
		end
	end
endmodule 
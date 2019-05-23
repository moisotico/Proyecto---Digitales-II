/*
 *Universidad de Costa Rica - Escuela de Ingenieria Electrica
 *Proyecto #1 - IE-0523 - modulo mux
 *@author Giancarlo Marin H.
 *@date   14/05/2019
 *@brief  Descripcion conductual del modulo mux 2:1 de 8 bits con bit de valido las entradas y la salida
*/

module mux(
	output reg[7:0]	data_out,		// salida del multiplexor
	output reg 		valid_out,		// bit de valid de la salida
	input 			clk,			// señal de clock del modulo
	input 			reset_L,		// señal de reset del modulo
	input 			valid_in_0,		// bit valid entrada 0
	input [7:0]		data_in_0,		// entrada de datos 0 del multiplexor
	input 			valid_in_1,		// bit valid entrada 1
	input [7:0]		data_in_1		// entrada de datos 1 del multiplexor
	);
	reg 			selector,write,ignore,ignore_i,channel, channel_i; // regs internos de 1 bit
	reg [7:0]		data_reg;		// regs internos que transfieren la entrada a la salida
	
	always @(*) begin				// bloque combinacional
		data_reg = 0;
		write = 0;
		ignore_i = 0;
		channel_i=0;
		if (valid_in_0 && !valid_in_1)begin
			data_reg = data_in_0;
			write = 1;
			ignore_i = 1;
			channel_i = 0;
		end // if (valid_in_0 && !valid_in_1)
		else if (!valid_in_0 && valid_in_1)begin
			data_reg = data_in_1;
			write = 1;
			ignore_i = 1;
			channel_i = 1;
		end // else if (!valid_in_0 && valid_in_1)
		else if (valid_in_0 && valid_in_1 && !ignore) begin
			write = 1;
			ignore_i = 1;
			if (!selector) begin
				data_reg = data_in_0;
			end // if (!selector)
			else begin
				data_reg = data_in_1;
			end // if (!selector)
		end // else if (valid_in_0 && valid_in_1 && ignore==0)
		else if (valid_in_0 && valid_in_1 && ignore) begin
			write = 1;
			ignore_i = 1;
			channel_i = channel;
			if (!channel) begin
				data_reg = data_in_0;
			end // if (!selector)
			else begin
				data_reg = data_in_1;
			end // if (!selector)
		end // else if (valid_in_0 && valid_in_1 && !ignore)
		else begin
			write = 0;
			ignore_i =0;
			channel_i = 0;
		end // else
	end

    always @(posedge clk) begin		// bloque sincrono
		if (!reset_L) begin		// reset de los flops 
			selector <= 0;
    		valid_out <= 0;
    		data_out <= 0;
    		ignore <= 0;
    		channel <= 0;
		end
		else begin					// asignacion de los flops de manera sincrona
			data_out <= data_reg;	
    		valid_out <= write;
    		ignore <= ignore_i;
    		if (valid_in_0 && valid_in_1 && !ignore)begin // cambia selector solo cuando llegan al mismo tiempo la primera vez
    			selector<=~selector;
    			channel<=selector;
    		end
    		else begin
    			channel<=channel_i;
    		end
		end
    end
endmodule 
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
	reg 			selector,receiving,channel,sync;		// regs internos de un 1b
	reg[1:0]		cntr_wait_cyc;	// contador de ciclos wait 
	reg [7:0]		data_reg;		// regs internos que transfieren la entrada a la salida
	
	always @(*) begin				// bloque combinacional
		receiving = 0;
		data_reg = 0;
		channel = 0;
		if (!receiving && sync)begin
			if (valid_in_0 && valid_in_1) begin
				if (selector==0) begin
					data_reg=data_in_0;
					receiving=1;
					channel=0;
				end
				else if (selector==1)begin
					data_reg=data_in_1;
					receiving=1;
					channel=1;
				end
			end
			else if (valid_in_0) begin
				data_reg=data_in_0;
				receiving=1;
				channel=0;
			end
			else if (valid_in_1) begin
				data_reg=data_in_1;
				receiving=1;
				channel=1;
			end	
		end
		else if (receiving && sync)begin
			if (!channel && valid_in_0) begin
				data_reg=data_in_0;
				receiving=1;
				channel=0;
			end
			else if (channel && valid_in_1) begin
				data_reg=data_in_1;
				receiving=1;
				channel=1;
			end
		end
		else if (!sync)begin
			receiving=0;
		end
	end

    always @(posedge clk) begin		// bloque sincrono
		if (!reset_L) begin		// reset de los flops 
			selector <= 0;
    		valid_out <= 0;
    		data_out <= 0;
    		sync <= 0;
		end
		else begin					// asignacion de los flops de manera sincrona
			data_out <= data_reg;	
    		valid_out <= receiving;
    		if (!valid_in_0 && !valid_in_1)begin
    			cntr_wait_cyc <= cntr_wait_cyc + 1;
    			sync <= 0;
    		end
    		if (cntr_wait_cyc==2)begin
				cntr_wait_cyc <= 0;
				sync <= 1;
			end
			if (sync && !receiving && valid_in_0 && valid_in_1)begin
				selector=~selector;	// toggle al selector cuando ambos datos lleguen al mismo tiempo
			end
		end
    end
endmodule 
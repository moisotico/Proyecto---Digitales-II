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
	reg 			selector,channel;

    always @(posedge clk) begin		// bloque sincrono
		if (!reset_L) begin		// reset de los flops 
			selector <= 0;
			channel <= 0;
    		valid_out <= 0;
    		data_out <= 0;
		end
		else begin					// asignacion de los flops de manera sincrona
			if (valid_in_0 && !valid_in_1) begin
				data_reg = data_in_0;
				channel = 0;
			end
			else if(!valid_in_0 && valid_in_1)begin
				data_reg = data_in_1;
				channel = 1;
			end
			if (valid_in_0 && valid_in_1)begin
				if (valid_out)begin
					if (selector)begin
						data_out<=data_in_1;
						valid_out<=1;
						selector<=1;
					end
					else begin
						data_out<=data_in_0;
						valid_out<=1;
						selector<=0;
					end
				end
				else begin
					if (channel)begin
						data_out<=data_in_1;
						valid_out<=1;
						channel<=0;
						selector<=1;
					end
					else begin
						data_out<=data_in_1;
						valid_out<=1;
						channel<=1;
						selector<=0;
					end
				end
			end
		end
    end
endmodule 

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
	reg 			selector,write,channel,next,toggle;
	reg				cntr_wait_cyc;	// contador de ciclos wait 
	reg [7:0]		data_reg;		// regs internos que transfieren la entrada a la salida
	
	always @(*) begin				// bloque combinacional
		data_reg = 0;
		write = 0;
		channel = 0;
		next = 0;
		if (valid_in_0 || valid_in_1) begin
			if (!write) begin
				write = 1;
				if (valid_in_0 && !valid_in_1) begin
					data_reg = data_in_0;
					channel = 0;
				end
				else if(!valid_in_0 && valid_in_1)begin
					data_reg = data_in_1;
					channel = 1;
				end
				else if(valid_in_0 && valid_in_1)begin
					next = 1;
					if (!selector)begin
						data_reg = data_in_0;
						channel = 0;	
					end
					else begin
						data_reg = data_in_1;
						channel = 1;
					end
				end
			end
			else if (write) begin
				write = 1;
				if (!channel) begin
					data_reg = data_in_0;
					channel = 0;	
				end
				else begin
					data_reg = data_in_1;
					channel = 1;
				end
			end
		end
		else begin
			write = 0;
		end
	end

	always @(posedge next)begin
		toggle = 1;
	end

    always @(posedge clk) begin		// bloque sincrono
		if (!reset_L) begin		// reset de los flops 
			selector <= 0;
    		valid_out <= 0;
    		data_out <= 0;
    		toggle <= 0;
		end
		else begin					// asignacion de los flops de manera sincrona
			data_out <= data_reg;	
    		valid_out <= write;
    		if (toggle)begin
    			selector<=~selector;
    			toggle=0;
    		end
		end
    end
endmodule 
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
	reg 			selector,valid0,valid1,toggle;		// regs internos de un 1b 
	reg [7:0]		data_reg0, data_reg1;	// regs internos que transfieren la entrada a la salida y soluciona el problema de temporizacion
	
	always @(*) begin				// bloque combinacional
		data_demux_0 = 'b0;			// valores por defecto para evitar latches				
		data_demux_1 = 'b0;
		valid_demux_0=0;
		valid_demux_1=0;
		reading=0;
		toggle=0;
		lane=0;
		if (reset_L == 0) begin		// reset asincrono
			data_demux_0 = 'b0;				
			data_demux_1 = 'b0;
			valid_demux_0=0;
			valid_demux_1=0;
			toggle=0;
		end
		else if (selector == 0 && valid_unstripped == 1) begin	// selector para las salidas del demux
			data_demux_0 = data_unstripped;
			data_demux_1 = data_reg1;
			valid_demux_0=1;
			valid_demux_1=0;
			toggle = 0;
		end
		else if (selector == 1 && valid_unstripped == 1) begin
			data_demux_0 = data_reg0;
			data_demux_1 = data_unstripped;
			valid_demux_0=0;
			valid_demux_1=1;
			toggle =0;
		end
		else if (valid_unstripped==0) begin
			data_demux_0 = data_reg0;
			data_demux_1 = data_reg1;
			valid_demux_0=0;
			valid_demux_1=0;
			toggle = 1;
		end
	end

    always @(posedge clk_2f) begin		// bloque sincrono
		if (reset_L == 0) begin		// reset de los flops 
			selector <= 0;
			data_reg0 <= data_demux_0;
    		data_reg1 <= data_demux_1;
    		valid0 <= 0;
    		valid1 <= 0;
		end
		else begin					// asignacion de los flops de manera sincrona
			if (toggle) begin
				selector <= ~selector; // toggle del selector cuando 
			end
			data_reg0 <= data_demux_0;	
    		data_reg1 <= data_demux_1;
    		valid0 <= valid_demux_0;
    		valid1 <= valid_demux_1;
		end
    end
endmodule 
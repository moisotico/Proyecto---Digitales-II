/*
 *Universidad de Costa Rica - Escuela de Ingenieria Electrica
 *Proyecto #1 - IE-0523 - modulo serialtopar
 *@author Giancarlo Marin H.
 *@date   20/05/2019
 *@brief  Descripcion conductual del modulo serial to paralelo con bit de valido en las entradas y la salida
*/

module serialtopar(
	output reg[7:0]	data_par,		// salida en paralelo de 8b
	output reg 		valid_par,		// bit de valid de la salida
	input 			clk_f,			// señal de clock del modulo
	input			clk_8f,			// señal de clock a 8f
	input 			reset_L,		// señal de reset del modulo
	input 			in 				// entrada de datos serial
	);
	reg 			active;		    // regs internos de 1 bit
	reg 			valid;			// valid temporal
	reg [7:0]		buffer;			// reg desplazante que recibe los datos
	reg [7:0]		buffer2;		// reg que contiene el dato a enviar a la salida
	reg [2:0]		bc_cnt;			// reg que cuenta la cantidad de datos de control bc
	reg [2:0]		cnt_bits;		// contador de bits leidos despues de ultima lectura
	wire [7:0]		shift_reg;


	assign shift_reg = {buffer[6:0],in};

	always @(posedge clk_8f) begin		// bloque sincrono
		if (!reset_L) begin			// reset de los flops 
			buffer <= 0;
			active <=0;
			bc_cnt <= 0;
			cnt_bits <= 0;
			buffer2 <= 0;
			valid <= 0;
		end
		else begin
			buffer <= shift_reg;
			cnt_bits <= cnt_bits + 1;
			if (cnt_bits==0) begin
				buffer2<=shift_reg;
			end
			if (shift_reg==8'hbc)begin
				bc_cnt <= bc_cnt +1;
			end
			if (bc_cnt >= 4) begin
				active = 1;
			end
			if (active && buffer2!=8'hbc)begin
				valid <= 1;
			end		
			else begin
				valid <= 0;
			end	
		end
    end	

    always @(posedge clk_f) begin		// bloque sincrono
		if (!reset_L) begin			// reset de los flops 
			data_par <= 0;
			valid_par<= 0;
		end
		else begin					// asignacion de los flops de manera sincrona
			data_par<=buffer2;			
			valid_par<=valid;
		end	
    end
endmodule 
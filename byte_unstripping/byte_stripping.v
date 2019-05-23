/**
	*Universidad de Costa Rica - Escuela de Ingenieria Electrica
	*Proyecto #1 - IE-0523 - modulo byte unstripping
	*@author Moises Campos Z.
	*@date   21/05/2019
	*@brief  Descripcion conductual del byte unstripping    
**/

module byte_unstripping(
    output reg[7:0]	data_unstripe_out,		// salida del unstripping
	output reg 		valid_unstripe_out,		// bit de valid de la salida
    input           clk_f,					// clk a f
	input           clk_2f,					// clk a 2f
	input           reset_L,				// reset en bajo
	input[7:0]      data_lane_0,      		// entrada lane 0 del unstripe
	input[7:0]      data_lane_1,    	  	// entrada lane 1 del unstripe
	input           valid_lane_0,
	input           valid_stripe_1);

	//Banderas y senales internas
    reg             sel;
    
    
	//bloques always
    always@(*)begin
        if (!reset_L)begin
        	
        end
    
    end
    
    always@(posedge clk_f)begin

    end

    always@(posedge clk_2f)begin
        if (counter)begin
            counter <= 'b0;
            if(valid_demux) data_demux <= data_valdated_1; 
        end
        
        else begin
            counter <= counter + 'b1;
            if(valid_demux) data_demux <= data_valdated_0; 
        end
        //agregar entradas
        // dar prioridad a data_strip_0
        
        // validar entradas
    end



endmodule

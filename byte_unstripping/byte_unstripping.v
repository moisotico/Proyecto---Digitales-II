/**
	*Universidad de Costa Rica - Escuela de Ingenieria Electrica
	*Proyecto #1 - IE-0523 - modulo byte unstripping
	*@author Moises Campos Z.
	*@date   21/05/2019
	*@brief  Descripcion conductual del byte unstripping    
**/
`timescale 1ns/1ps

module byte_unstripping(
                        output reg[7:0] data_demux,     //salida a data demux, cambia con clk_2f
                        output reg      valid_demux,

                        input           clk_f,
                        input           clk_2f,
                        input           reset_L,
                        input[7:0]      data_stripe_0,      //entradas data stripe cambian 
                        input[7:0]      data_stripe_1,      //tomando como referencia clk_f
                        input           valid_stripe_0,
                        input           valid_stripe_1  );

//Banderas y senales internas
    
    reg [7,0]       data_validated0;
    reg [7,0]       data_validated_1;
    reg             counter;
    reg             selector; 
    
//bloques always
    always@(*)begin
        if (!reset_L) begin
            counter <= 'b0;
            valid_stripe_0 <= 'b0;
            valid_stripe_0 <= 'b0;
            selector <= 'b0;
        end

        if (valid_stripe_0) data_valdated_0 <= data_stripe_0;
        if (valid_stripe_1) data_valdated_1 <= data_stripe_1;
        //  salida data_demux      
    
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

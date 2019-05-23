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
    
    reg [7,0]       data_validated_0;
    reg [7,0]       data_validated_1;
    reg             valid_counter;
    reg             selector; 
    
//bloques always
    always@(*)begin
        
        //activa la entrada
        if (!reset_L) begin
            valid_counter = 'b0;
            data_stripe_0 = 'b0;
            data_stripe_1 = 'b0;
        end 
    end
    
    /**
    always@(posedge clk_f)begin
    end
    **/
    always@(posedge clk_2f)begin
        if valid_demux begin
            if (valid_counter)begin
                valid_counter <= 'b0;
                if(valid_demux) data_demux <= data_validated_1; 
            end
            
            else begin
                valid_counter <= valid_counter + 'b1;
                if(valid_demux) data_demux <= data_validated_0; 
            end
        end
        if (!reset_L)begin
            selector<= 'b0;
            valid_stripe_0 <= 'b0;
            valid_stripe_1 <= 'b0;
        end
        
        // else selector <= ~selector;
        // agregar entradas
        // dar prioridad a data_strip_0
        else begin
            //mover a posedge2f
            if (valid_stripe_0) begin
                data_validated_0 <= data_stripe_0;
                
            end
            else begin
                data_validated_0 <= data_validated_0;
            end
            
            if (valid_stripe_1) begin
                data_validated_1 <= data_stripe_1;
            end
            else begin
                 data_validated_1 <= data_validated_1;
            end
            //  salida data_demux
         end
 
        // validar entradas
    end



endmodule

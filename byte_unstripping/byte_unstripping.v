/**
	*Universidad de Costa Rica - Escuela de Ingenieria Electrica
	*Proyecto #1 - IE-0523 - modulo byte unstripping
	*@author Moises Campos Z.
	*@date   21/05/2019
	*@brief  Descripcion conductual del byte unstripping    
**/

//`timescale 1ns/1ps

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
    
    reg [7:0]       data_validated_0;
    reg [7:0]       data_validated_1;
    //reg             valid_counter;
    reg             selector; 
    
//bloques always
       /**
    always@(*)begin
        //activa la entrada
        if (reset_L==0) begin
            selector = 'b0;
        end 
    end
    
        **/
    /**
    always@(posedge clk_f)begin
    end
    **/

    //fecuencia clk_2f
    always@(posedge clk_2f)begin
        if (!reset_L)begin
            selector <= 'b0;
            data_validated_0    <= 'b0;
            data_validated_1    <= 'b0;
            valid_demux         <= 'b0;              
        end
        
        // agregar entradas
        // dar prioridad a data_strip_0

        else begin 
            case (selector)
                //default
                0:
                    if (valid_stripe_0) begin
                        data_validated_0 <= data_stripe_0; 
                        selector <= ~selector; 
                        valid_demux <= valid_stripe_0;              //valid_demux selection
                    end
                    else begin
                        data_validated_0 <= data_validated_0;
                        valid_demux <= 'b0;
                    end
                    
                1:
                    if (valid_stripe_1) begin
                        data_validated_1 <= data_stripe_1;
                        selector <= ~selector; 
                        valid_demux <= valid_stripe_1;              //valid_demux selection
                    end
                    else begin
                        data_validated_1 <= data_validated_1;
                        valid_demux <= 'b0;
                    end
            endcase
            
         end
 
        // validar salida data_demux
        if (valid_demux) begin
            if (selector==0)begin
                data_demux <= data_validated_0; 
            end
                
            else begin
                data_demux <= data_validated_1; 
            end
        end
            //Si es invalido, selector == 0
        else begin
                selector <= 'b0;
                data_demux <= 'b0;
        end
    end

endmodule

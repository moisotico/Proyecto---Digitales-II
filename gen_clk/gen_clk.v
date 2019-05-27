 /**
	*Universidad de Costa Rica - Escuela de Ingenieria Electrica
	*Proyecto #1 - IE-0523 - modulo generador de reloj.
	*@author Moises Campos Z.
	*@date   15/05/2019
	*@brief  Descripcion conductual del byte unstripping
**/ 


`timescale 1ns/1ps

module gen_clk(
				input			clk_8f,
				input			rst,
				input			enb,
				output reg		clk_2f,
				output reg		clk_f	 );

	// counter de clk_2f y clk_f
    reg counter;

    always@(posedge clk_8f) begin
        
        if(rst) begin
            counter <= 1;
            clk_2f <= 1'b0;
            clk_f <= 1'b0;
        end

        else begin
            if(enb) begin
                if (counter < 1) begin
                    counter <= counter + 'b1;  // counter de clk_2f y clk_f
                end
                else begin
                    counter <= 'b0;                         //resetear counter
                    clk_2f <= ~clk_2f;                      //clk_2f cada 2 ciclos 
                    if(~clk_2f) clk_f <= ~clk_f;            //clk_f solo la mitad
                end
            end
        end
    end


endmodule

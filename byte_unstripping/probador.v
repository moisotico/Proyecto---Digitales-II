/**
	*Universidad de Costa Rica - Escuela de Ingenieria Electrica
	*Proyecto #1 - IE-0523 - modulo probador para byte unstripping
	*@author Moises Campos Z.
	*@date   22/05/2019
	*@brief  Probador del byte unstripping    
**/

module probador( /*AUTOINST*/
					input[7:0]			data_demux,     //salida a data demux, cambia con clk_2f
					input				valid_demux,
					output reg			clk_f,
					output reg			clk_2f,
					output reg			reset_L,
					output reg [7:0]	data_stripe_0,      //entradas data stripe cambian 
					output reg [7:0]	data_stripe_1,      //tomando como referencia clk_f
					output reg         	valid_stripe_0,
					output reg			valid_stripe_1	);
//senales internas (pendiente importar clock)
    
    reg             f2_cond;
    reg             f2_estruct;
    reg             f_cond;
    reg             f_estruct;

 initial begin
       
        $dumpfile("byte_unstripping.vcd");               //Dumpfile to make in current folder
        $dumpvars;
     
     //$display?
    

    //se resetean los datos
        reset_L         <= 'b0;
        data_stripe_0   <= 'b0;
        data_stripe_1   <= 'b0;

                          
     //inicio de pruebas     
        # 60;
        @(posedge clk_2f)
        reset_L	<= 1;
        
/**        
        # 60;
        @(posedge clk_8f)
            enb <= 1;

        # 20;
        @(posedge clk_8f)
            enb <= 0;

        # 20;
        @(posedge clk_8f)
            rst <= 1;
                
        
        # 20;
        @(posedge clk_8f)
            rst <= 0;
            enb <= 1;
**/
        $finish;
end

// Checker pendiente
    /**
always @(posedge clk_8f) begin
    f2_cond<=clk_2f_cond;
    f_cond<=clk_f_cond;
    f2_estruct<=clk_2f_estruct;
     f_estruct<=clk_f_estruct;
    if (enb) begin
        if(f_cond==f_estruct)begin
            $display("Las salidas son iguales en f");   
        end
        else begin
            $display("Las salidas NO son iguales en f");   
        end
    
        if(f2_cond==f2_estruct)begin
            $display("Las salidas son iguales en 2f");   
        end
        else begin
            $display("Las salidas NO son iguales en 2f");   
        end
    end
end
**/
    always # 8 clk_2f <= ~clk_2f;       //genera señal 4 ns 

    //provisional
    always  #20 data_stripe_0 <= $random % 256;
    always  #20 data_stripe_1 <= $random % 256;

endmodule

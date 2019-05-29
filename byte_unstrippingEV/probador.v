/**
	*Universidad de Costa Rica - Escuela de Ingenieria Electrica
	*Proyecto #1 - IE-0523 - modulo probador para byte unstripping
	*@author Moises Campos Z.
	*@date   22/05/2019
	*@brief  Probador del byte unstripping    
**/

module probador( /*AUTOINST*/
					input[7:0]			data_demux_cond,     //salida a data demux, cambia con clk_2f
					input				valid_demux_cond,
                    input[7:0]			data_demux_estruct,     //salida a data demux, cambia con clk_2f
					input				valid_demux_estruct,
					output reg			clk_f,
					output reg			clk_2f,
					output reg			reset_L,
					output reg [7:0]	data_stripe_0,      //entradas data stripe cambian 
					output reg [7:0]	data_stripe_1,      //tomando como referencia clk_f
					output reg         	valid_stripe_0,
					output reg			valid_stripe_1	);
//senales internas (pendiente importar clock)
    
    reg temp_valid_cond;
    reg temp_valid_estruct;
    reg [7:0] temp_datamux_cond;
    reg [7:0] temp_datamux_estruct;

 initial begin
       
        $dumpfile("bancopruebas.vcd");               //Dumpfile to make in current folder
        $dumpvars;
     
        reset_L         <= 'b0;
        data_stripe_0   <= 'h00;
        data_stripe_1   <= 'hFA;
        valid_stripe_0 <= 'b0;
        valid_stripe_1 <= 'b0;

                          
        @(posedge clk_f)
        reset_L	<= 1;
        data_stripe_1<=data_stripe_1+1;
        data_stripe_0<=data_stripe_0+1;
        valid_stripe_0<='b1;

        @(posedge clk_f)
        reset_L	<= 1;
        data_stripe_1<=data_stripe_1+1;
        data_stripe_0<=data_stripe_0+1;
        valid_stripe_1<='b1;
    
    
        @(posedge clk_f)
        data_stripe_1<=data_stripe_1+1;
        data_stripe_0<=data_stripe_0+1;
        valid_stripe_0<='b0;
    
        @(posedge clk_f)
        data_stripe_1<=data_stripe_1+1;
        data_stripe_0<=data_stripe_0+1;
        valid_stripe_1<='b0;

        repeat (2)begin
            @(posedge clk_f)begin
            data_stripe_1<=data_stripe_1+1;
            data_stripe_0<=data_stripe_0+1;
            end
        end

        @(posedge clk_f)
        data_stripe_1<=data_stripe_1+1;
        data_stripe_0<=data_stripe_0+1;
        valid_stripe_0<='b1;
        
        @(posedge clk_f)
        data_stripe_1<=data_stripe_1+1;
        data_stripe_0<=data_stripe_0+1;
        valid_stripe_1<='b1;
        
        @(posedge clk_f)
        data_stripe_1<=data_stripe_1+1;
        data_stripe_0<=data_stripe_0+1;
        
        @(posedge clk_f)
        data_stripe_1<=data_stripe_1+1;
        data_stripe_0<=data_stripe_0+1;
        valid_stripe_0<='b0;
        valid_stripe_1<='b0;
        
        repeat(2)begin
        @(posedge clk_f)
        data_stripe_1<=data_stripe_1+1;
        data_stripe_0<=data_stripe_0+1;
        end
        $finish;
end
    initial begin
    clk_2f <=0;
    clk_f <=0;
    end

    always # 2 clk_2f <= ~clk_2f; 

    always @(posedge clk_2f)begin
        clk_f<=~clk_f;
        temp_valid_cond<=valid_demux_cond;
        temp_valid_estruct<=valid_demux_estruct;
        temp_datamux_cond<=data_demux_cond;
        temp_datamux_estruct<=data_demux_estruct;
        if (reset_L) begin
            if(temp_valid_cond==temp_valid_estruct && temp_datamux_cond==temp_datamux_estruct)begin
                $display("Las descripciones son iguales en valid y data");   
            end 
            else begin
                $display("Las descripciones NO son iguales en valid y data");   
            end
        end
    end
    


endmodule

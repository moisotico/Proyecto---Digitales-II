module probador(
    output reg clk_8f,
    output reg reset_L,
    output reg [7:0] data_in_0,
    output reg [7:0] data_in_1,
    output reg valid_in_0,
    output reg valid_in_1,
    output reg enable,
    input [7:0] data_out_0_cond,
    input [7:0] data_out_1_cond,
    input valid_out_0_cond,
    input valid_out_1_cond,
    input [7:0] data_out_0_estruct,
    input [7:0] data_out_1_estruct,
	input valid_out_0_estruct,
	input valid_out_1_estruct);

    // reg clk_4f;
    // reg clk_2f;
    // reg clk_f;

    // reg [7:0]temp_0_cond;
    // reg [7:0]temp_1_cond;

    // reg [7:0]temp_0_estruct;
    // reg [7:0]temp_1_estruct;
    
    // reg temp_valid_0_cond;
    // reg temp_valid_1_cond;

    // reg temp_valid_0_estruct;
    // reg temp_valid_1_estruct;
   initial begin
    $dumpfile("bancopruebas.vcd");
    $dumpvars;
    // Pruebas
        enable <= 0;
        data_in_0 <= 'h00;
        data_in_1 <= 'h00;
        valid_in_0<='b0;
        valid_in_1<='b0;
        // Pruebas #1: Reset bajo. 
        reset_L <= 0;
        // Prueba #2: Reset alto. Valido primer dato
        repeat(4) begin
        @(posedge clk_8f);
        end
        enable <= 1;
        reset_L <= 1;
        
        repeat(4) begin
        @(posedge clk_8f);
        end
        reset_L <= 0;


        repeat(4) begin
        @(posedge clk_8f);
        end
        reset_L <= 1;
        // Prueba #3: Envía BC 4 veces
        repeat(16) begin
        @(posedge clk_8f);
        end   
        
            repeat(4) begin
        @(posedge clk_8f);
        end   
            data_in_0<='hDD;
            data_in_1<='hCC;
            valid_in_0<='b1;
            valid_in_1<='b0;
        // Prueba #4: Envía 3 datos validos
        repeat(4) begin
        @(posedge clk_8f);
        end   
            data_in_0<='hEC;
            data_in_1<='hBC;
            valid_in_0<='b1;
            valid_in_1<='b1;

        repeat(4) begin
        @(posedge clk_8f);
        end   
            data_in_0<='hAC;
            data_in_1<='h0C;
            valid_in_0<='b1;
            valid_in_1<='b1;
        // envia EE
        repeat(4) begin
        @(posedge clk_8f);
        end
            data_in_0<='hAA;
            data_in_1<='hBB;
            valid_in_0<='b0;
            valid_in_1<='b1;
        //envia DD
        repeat(4) begin
        @(posedge clk_8f);
        end
            data_in_0<='hDD;
            data_in_1<='hDE;
            valid_in_0<='b0;
            valid_in_1<='b0;
        // Prueba #5: Envía BC de nuevo. Se espera valid_out = 0
        repeat(4) begin
        @(posedge clk_8f);
        end
            data_in_0<='h01;
            data_in_1<='h23;
            valid_in_0<='b0;
            valid_in_1<='b0;
        // Prueba 6: Vuelve a enviar otro dato valido
        // envia AA
        repeat(4) begin
        @(posedge clk_8f);
        end
            data_in_0<='hAA;
            data_in_1<='hAB;
            valid_in_0<='b1;
            valid_in_1<='b1;
        // Prueba 7: Envía dato invalido
        repeat(4) begin
        @(posedge clk_8f);
        end
            data_in_0<='hBC;
            data_in_1<='hBC;
            valid_in_0<='b1;
            valid_in_1<='b1;
        // Prueba 8: Envía datos validos
        // Se envia por lane0 99 y lane 1 11
        repeat(4) begin
        @(posedge clk_8f);
        end
            data_in_0<='h99;
            data_in_1<='h11;
            valid_in_0<='b1;
            valid_in_1<='b1;
        //Dato invalido
        repeat(4) begin
        @(posedge clk_8f);
        end
            data_in_0<='hEE;
            data_in_1<='hAA;
            valid_in_0<='b0;
            valid_in_1<='b0;
        // Se envia por lane0 88 y lane 1 22
        repeat(4) begin
        @(posedge clk_8f);
        end
            data_in_0<='h88;
            data_in_1<='h22;
            valid_in_0<='b0;
            valid_in_1<='b0;
        // Se envia por lane0 77 y lane 1 33
        repeat(4) begin
        @(posedge clk_8f);
        end
            data_in_0<='h77;
            data_in_1<='h33;
            valid_in_0<='b0;
            valid_in_1<='b1;
        //Dato invalido
        repeat(4) begin
        @(posedge clk_8f);
        end
            data_in_0<='hBC;
            data_in_1<='hBC;
            valid_in_0<='b1;
            valid_in_1<='b1;
        // Se envia por lane0 66 y lane 1 44
        repeat(4) begin
        @(posedge clk_8f);
        end
            data_in_0<='h66;
            data_in_1<='h44;
            valid_in_0<='b1;
            valid_in_1<='b1;
        
        $finish;    
   end

    initial begin
    clk_8f <=0;
    clk_4f <=0;
    clk_2f <=0;
    clk_f <=0;
    end

    always #2 clk_8f <=~clk_8f;
    always @(posedge clk_8f)begin
        clk_4f=~clk_4f;
    end
    always @(posedge clk_4f)begin
        clk_2f=~clk_2f;
    end
    always @(posedge clk_2f)begin
        clk_f=~clk_f;
    //     temp_0_cond<=data_out_0_cond;
    //     temp_1_cond<=data_out_1_cond;
    //     temp_valid_0_cond<=valid_out_0_cond;
    //     temp_valid_1_cond<=valid_out_1_cond;
      
    //     temp_0_estruct<=data_out_0_estruct;
    //     temp_1_estruct<=data_out_1_estruct;
    //     temp_valid_0_estruct<=valid_out_0_estruct;
    //     temp_valid_1_estruct<=valid_out_1_estruct;
    
    // if (reset_L) begin
    //     if(temp_0_cond==temp_0_estruct && temp_1_cond==temp_1_estruct)begin
    //         $display("Las descripciones son iguales en ambas salidas");   
    //     end 
    //     else begin
    //         $display("Las descripciones NO son iguales en ambas salidas");   
    //     end

    //     if(temp_valid_0_cond==temp_valid_0_estruct && temp_valid_1_cond==temp_valid_1_estruct)begin
    //         $display("Las descripciones son iguales en ambas valids");   
    //     end 
    //     else begin
    //         $display("Las descripciones NO son iguales en ambas valids");   
    //     end
    // end
    end  


endmodule


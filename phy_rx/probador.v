module probador(
    output reg clk_8f,
    output reg reset_L,
    output reg in_0,
    output reg in_1,
	output reg enable,
    input [7:0] data_out_0_cond,
    input [7:0] data_out_1_cond,
	input valid_out_0_cond,
	input valid_out_1_cond,
    input [7:0] data_out_0_estruct,
    input [7:0] data_out_1_estruct,
	input valid_out_0_estruct,
	input valid_out_1_estruct);

    reg clk_4f;
    reg clk_2f;
    reg clk_f;
    // reg temp_0_cond;
    // reg temp_1_cond;
    // reg temp_0_estruct;
    // reg temp_1_estruct;
   initial begin
    $dumpfile("bancopruebas.vcd");
    $dumpvars;
    // Pruebas
        enable <= 0;
        in_0 <= 0;
        in_1 <= 0;               
        // Pruebas #1: Reset bajo. 
        reset_L <= 0;
        // Prueba #2: Reset alto. Valido primer dato
        @(posedge clk_f);
        reset_L <= 1;
        enable <= 1;
        // Prueba #3: Envía BC 4 veces
        repeat(4) begin
            @(posedge clk_8f);
            in_0 <= 1;
            in_1 <= 1;
            @(posedge clk_8f);
            in_0 <= 0;
            in_1 <= 0;
            @(posedge clk_8f);
            in_0 <= 1;
            in_1 <= 1;
            @(posedge clk_8f);
            in_0 <= 1;
            in_1 <= 1;
            @(posedge clk_8f);
            in_0 <= 1;
            in_1 <= 1;
            @(posedge clk_8f);
            in_0 <= 1;
            in_1 <= 1;
            @(posedge clk_8f);
            in_0 <= 0;
            in_1 <= 0;
            @(posedge clk_8f);
            in_0 <= 0;
            in_1 <= 0;
        end
        // Prueba #4: Envía 3 datos validos
        repeat(8) begin // envía FF
            @(posedge clk_8f);
            in_0 <= 1;
            in_1 <= 0;
        end
        // envia EE
        repeat(2) begin
            @(posedge clk_8f);
            in_0 <= 1;
            in_1 <= 1;
            @(posedge clk_8f);
            in_0 <= 1;
            in_1 <= 1;
            @(posedge clk_8f);
            in_0 <= 1;
            in_1 <= 1;
            @(posedge clk_8f);
            in_0 <= 0;
            in_1 <= 1;
        end
        //envia DD
        repeat(2) begin
            @(posedge clk_8f);
            in_0 <= 1;
            in_1 <= 1;
            @(posedge clk_8f);
            in_0 <= 1;
            in_1 <= 1;
            @(posedge clk_8f);
            in_0 <= 0;
            in_1 <= 0;
            @(posedge clk_8f);
            in_0 <= 1;
            in_1 <= 1;
        end
        // Prueba #5: Envía BC de nuevo. Se espera valid_out = 0
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        // Prueba 6: Vuelve a enviar otro dato valido
        // envia AA
        repeat(4) begin
            @(posedge clk_8f);
            in_0 <= 1;
            in_1 <= 1;
            @(posedge clk_8f);
            in_0 <= 0;
            in_1 <= 0;
        end
        // Prueba 7: Envía dato invalido
         repeat(3) begin
            @(posedge clk_8f);
            in_0 <= 1;
            in_1 <= 1;
            @(posedge clk_8f);
            in_0 <= 0;
            in_1 <= 0;
            @(posedge clk_8f);
            in_0 <= 1;
            in_1 <= 1;
            @(posedge clk_8f);
            in_0 <= 1;
            in_1 <= 1;
            @(posedge clk_8f);
            in_0 <= 1;
            in_1 <= 1;
            @(posedge clk_8f);
            in_0 <= 1;
            in_1 <= 1;
            @(posedge clk_8f);
            in_0 <= 0;
            in_1 <= 0;
            @(posedge clk_8f);
            in_0 <= 0;
            in_1 <= 0;
        end
        // Prueba 8: Envía datos validos
        // Se envia por lane0 99 y lane 1 11
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;

        //Dato invalido
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        // Se envia por lane0 88 y lane 1 22
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        // Se envia por lane0 77 y lane 1 33
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        //Dato invalido
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        // Se envia por lane0 66 y lane 1 44
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 1;
        @(posedge clk_8f);
        in_0 <= 1;
        in_1 <= 0;
        @(posedge clk_8f);
        in_0 <= 0;
        in_1 <= 0;
        // Prueba 9: Reset alto y termina de almacenar señales
        repeat(7) begin
            @(posedge clk_8f);
        end
        reset_L <= 0;
        @(posedge clk_f);
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
    end  
endmodule


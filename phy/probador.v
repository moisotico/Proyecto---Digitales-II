/*
 *Universidad de Costa Rica - Escuela de Ingenieria Electrica
 *Proyecto #1 - IE-0523 - modulo probador phy
 *@author Giancarlo Marin H. / esteban Valverde
 *@date   31/05/2019
 *@brief  Modulo probador que monitoriza las salidas y genera las entradas del modulo phy 
*/

module probador(
    output reg clk_8f,
    output reg reset_L,
    output reg [7:0] data_in_0,
    output reg [7:0] data_in_1,
    output reg valid_data_in_0,
    output reg valid_data_in_1,
    output reg enable,
    input [7:0] data_out_0_cond,
    input [7:0] data_out_1_cond,
    input valid_data_out_0_cond,
    input valid_data_out_1_cond,
    input [7:0] data_out_0_estruct,
    input [7:0] data_out_1_estruct,
	input valid_data_out_0_estruct,
	input valid_data_out_1_estruct);

    //Wires para chequeo de las salidas
    wire check_out0, check_out1;

    checker_phy phy_check(/*autoinst*/
          .check_out0(check_out0),
          .check_out1(check_out1),
          .clk_8f(clk_8f),
          .reset_L(reset_L),
          .data_out0_c(data_out_0_cond[7:0]),
          .data_out1_c(data_out_1_cond[7:0]),
          .data_out0_e(data_out_0_estruct[7:0]),
          .data_out1_e(data_out_1_estruct[7:0]));

   initial begin
    $dumpfile("phy.vcd");
    $dumpvars;
    // Pruebas
    // Datos iniciales
    enable <= 0;
    data_in_0 <= 'h00;
    data_in_1 <= 'h00;
    valid_data_in_0<='b0;
    valid_data_in_1<='b0;
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
    repeat(8) begin
        @(posedge clk_8f);
    end
    reset_L <= 1;
    // Prueba #3: Envía BC 4 veces mientras espera un tiempo en cada canal
    repeat(46) begin
        @(posedge clk_8f);
    end

    // Prueba #4: Envía 4 datos validos en el canal 1 y envia 1 dato válido y uno inválido en el canal 2 al mismo tiempo
    repeat(4) begin
        @(posedge clk_8f);
    end
    data_in_0<='hDD;
    data_in_1<='h00;
    valid_data_in_0<='b1;
    valid_data_in_1<='b0;
    repeat(4) begin
        @(posedge clk_8f);
    end   
    data_in_0<='hEE;
    data_in_1<='hBB;
    valid_data_in_0<='b1;
    valid_data_in_1<='b1;
    repeat(4) begin
    @(posedge clk_8f);
    end   
    data_in_0<='hFF;
    data_in_1<='hAA;
    valid_data_in_0<='b1;
    valid_data_in_1<='b1;
    repeat(4) begin
    @(posedge clk_8f);
    end
    data_in_0<='h01;
    data_in_1<='h99;
    valid_data_in_0<='b1;
    valid_data_in_1<='b1;
    // Sincronizacion
    repeat(4) begin
        @(posedge clk_8f);
    end
    valid_data_in_0<='b0;
    valid_data_in_1<='b0;
    repeat(16) begin
        @(posedge clk_8f);
    end
    // Prueba #5: Envío desfazado de datos CH2 primero
    data_in_0<='hBC;
    data_in_1<='h11;
    valid_data_in_0<='b0;
    valid_data_in_1<='b1;
    repeat(4) begin
        @(posedge clk_8f);
    end
    data_in_0<='hFF;
    data_in_1<='h22;
    valid_data_in_0<='b1;
    valid_data_in_1<='b1;
    repeat(4) begin
        @(posedge clk_8f);
    end
    data_in_0<='hEE;
    data_in_1<='h33;
    valid_data_in_0<='b1;
    valid_data_in_1<='b1;
    // Sincronizacion
    repeat(4) begin
        @(posedge clk_8f);
    end
    valid_data_in_0<='b0;
    valid_data_in_1<='b0;
    repeat(28) begin
        @(posedge clk_8f);
    end
    // Prueba 6: Envío de datos al mismo tiempo
    data_in_0<='hDD;
    data_in_1<='h44;
    valid_data_in_0<='b1;
    valid_data_in_1<='b1;
    repeat(4) begin
        @(posedge clk_8f);
    end
    data_in_0<='hCC;
    data_in_1<='h55;
    valid_data_in_0<='b1;
    valid_data_in_1<='b1;
    repeat(4) begin
        @(posedge clk_8f);
    end
    data_in_0<='hBB;
    data_in_1<='h66;
    valid_data_in_0<='b1;
    valid_data_in_1<='b1;
    repeat(4) begin
        @(posedge clk_8f);
    end
    data_in_0<='hAA;
    data_in_1<='h77;
    valid_data_in_0<='b0;
    valid_data_in_1<='b0;
    // Sincronizacion
    repeat(4) begin
        @(posedge clk_8f);
    end
    valid_data_in_0<='b0;
    valid_data_in_1<='b0;
    repeat(24) begin
        @(posedge clk_8f);
    end
    // Prueba 7: Envío de datos invalidos
    data_in_0<='hDD;
    data_in_1<='h88;
    valid_data_in_0<='b1;
    valid_data_in_1<='b1;
    repeat(4) begin
        @(posedge clk_8f);
    end
    data_in_0<='hCC;
    data_in_1<='h00;
    valid_data_in_0<='b1;
    valid_data_in_1<='b1;
    repeat(4) begin
        @(posedge clk_8f);
    end
    data_in_0<='hBB;
    data_in_1<='hAA;
    valid_data_in_0<='b0;
    valid_data_in_1<='b0;
    // Espera un tiempo para Finalizacion de toma de datos
    repeat(60) begin
        @(posedge clk_8f);
    end
    $finish;    
    end

    // Generacion del clk_8f
    initial clk_8f <=0;
    always #2 clk_8f <=~clk_8f;
endmodule
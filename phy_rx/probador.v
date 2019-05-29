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
    reset_L<='b0;
    enable<='b0;
    in_0<='b0;
    in_1<='b0;
    @(posedge clk_f);
    reset_L<='b1;
    enable<='b1;
@(posedge clk_4f);
    repeat (4)begin    
    @(posedge clk_8f);
    in_0<='b1;
    in_1<='b1;
    @(posedge clk_8f);
    in_0<='b0;
    in_1<='b0;
    @(posedge clk_8f);
    in_0<='b1;
    in_1<='b1;
    @(posedge clk_8f);
    in_0<='b1;
    in_1<='b1;
    @(posedge clk_8f);
    in_0<='b1;
    in_1<='b1;
    @(posedge clk_8f);
    in_0<='b1;
    in_1<='b1;
    @(posedge clk_8f);
    in_0<='b0;
    in_1<='b0;
    @(posedge clk_8f);
    in_0<='b0;
    in_1<='b0;
    end
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
    // always @(posedge clk_8f)begin
    //     clk_4f<=~clk_4f;
    //     temp_0_cond<=tx_out_0_cond;
    //     temp_1_cond<=tx_out_1_cond;
    //     temp_0_estruct<=tx_out_0_estruct;
    //     temp_1_estruct<=tx_out_1_estruct;
    //     if (reset_L) begin
    //         if(temp_0_cond==temp_0_estruct && temp_1_cond==temp_1_estruct)begin
    //             $display("Las descripciones son iguales en ambas salidas");   
    //         end 
    //         else begin
    //             $display("Las descripciones NO son iguales en ambas salidas");   
    //         end
    //     end

    // end

    

  
endmodule


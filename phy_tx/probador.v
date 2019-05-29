module probador(
    input tx_out_0_cond,
    input tx_out_1_cond,
    input tx_out_0_estruct,
    input tx_out_1_estruct,
    output reg reset_L,
    output reg clk_8f,
    output reg enable,
    output reg valid_data_0,
    output reg [7:0]    data_in_0,
    output reg valid_data_1,
    output reg [7:0]    data_in_1    
);

    reg clk_2f;
    reg clk_4f;
    reg temp_0_cond;
    reg temp_1_cond;
    reg temp_0_estruct;
    reg temp_1_estruct;
   initial begin
    $dumpfile("bancopruebas.vcd");
    $dumpvars;
    $display("\t\ttime,\t clk_8f, reset_L, enable, valid_data_0, data_in_0, valid_data_1, data_in_1, tx_out_0,tx_out_1");

    $monitor($time,"\t%b,\t%b,\t%b,\t%b,\t%h,\t%b,\t%h,\t%b,\t%b",clk_8f, reset_L, enable, valid_data_0, data_in_0, valid_data_1, data_in_1, tx_out_0_cond,tx_out_1_cond);
    reset_L<='b0;
    enable<='b0;
    valid_data_0<='b0;
    valid_data_1<='b0;
    data_in_0<='b0;
    data_in_1<='hEF;
    @(posedge clk_8f);
    enable<='b1;
    @(posedge clk_2f);
    @(posedge clk_2f);
	reset_L<='b1;
    valid_data_0<='b1;
	data_in_0<=data_in_0+1;
    
    @(posedge clk_2f);
	valid_data_1<='b1;
	data_in_1<=data_in_1+1;
    data_in_0<=data_in_0+1;

    repeat (2) begin
    @(posedge clk_2f);
    data_in_0<=data_in_0+1;
    data_in_1<=data_in_1+1;
    end

    valid_data_1<='b0;
    valid_data_0<='b0;
    
    @(posedge clk_2f);
    @(posedge clk_2f);
    
    @(posedge clk_2f);
    valid_data_1<='b1;
    data_in_1<=data_in_1+1;

    @(posedge clk_2f);
    valid_data_0<='b1;
    data_in_0<=data_in_0+1;
    data_in_1<=data_in_1+1;
    
    repeat (2) begin
    @(posedge clk_2f);
    data_in_0<=data_in_0+1;
    data_in_1<=data_in_1+1;
    end
    $finish;
   end

    initial begin
    clk_8f <=0;
    clk_4f <=0;
    clk_2f <=0;
    end

    always #2 clk_8f <=~clk_8f;
    
    always @(posedge clk_8f)begin
        clk_4f<=~clk_4f;
        temp_0_cond<=tx_out_0_cond;
        temp_1_cond<=tx_out_1_cond;
        temp_0_estruct<=tx_out_0_estruct;
        temp_1_estruct<=tx_out_1_estruct;
        if (reset_L) begin
            if(temp_0_cond==temp_0_estruct && temp_1_cond==temp_1_estruct)begin
                $display("Las descripciones son iguales en ambas salidas");   
            end 
            else begin
                $display("Las descripciones NO son iguales en ambas salidas");   
            end
        end

    end

    always @(posedge clk_4f)begin
        clk_2f<=~clk_2f;
    end

  
endmodule


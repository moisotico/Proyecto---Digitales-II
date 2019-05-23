module probador(
    input tx_out_0,
    input tx_out_1,
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

   initial begin
    $dumpfile("bancopruebas.vcd");
    $dumpvars;
    $display("\t\ttime,\t clk_8f, reset_L, enable, valid_data_0, data_in_0, valid_data_1, data_in_1, tx_out_0,tx_out_1");

    $monitor($time,"\t%b,\t%b,\t%b,\t%b,\t%h,\t%b,\t%h,\t%b,\t%b",clk_8f, reset_L, enable, valid_data_0, data_in_0, valid_data_1, data_in_1, tx_out_0,tx_out_1);
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
    end

    always @(posedge clk_4f)begin
        clk_2f<=~clk_2f;
    end

    // always @(posedge clk_2f)begin
    //     clk_f<=~clk_f;
    // end
    
//    always @(posedge clk_2f) begin
//       _0cond<=lane_0_cond;
//       _0estruct<=lane_0_estruct;
//       _1cond<=lane_1_cond;
//       _1estruct<=lane_1_estruct;
      
//     if (reset_L) begin
//         if(_0cond==_0estruct && _1cond==_1estruct)begin
//             $display("Las descripciones son iguales en ambas salidas");   
//         end 
//         else begin
//             $display("Las descripciones NO son iguales en ambas salidas");   
//         end
//     end
//    end

endmodule


module probador(
    input salida_ser_lane_0_cond,
    input salida_ser_lane_1_cond,
    output reg reset,
    output reg clk_8f,
    output reg enable,
    output reg validin0,
    output reg [7:0]entrada_0,
    output reg validin1,
    output reg [7:0]entrada_1    
);

    reg clk_2f;
    reg clk_4f;

   initial begin
    $dumpfile("bancopruebas.vcd");
    $dumpvars;
    $display("\t\ttime,\t clk_8f, reset, enable, validin0, entrada_0, validin1, entrada_1, salida_ser_lane_0_cond,salida_ser_lane_1_cond");

    $monitor($time,"\t%b,\t%b,\t%b,\t%b,\t%h,\t%b,\t%h,\t%b,\t%b",clk_8f, reset, enable, validin0, entrada_0, validin1, entrada_1, salida_ser_lane_0_cond,salida_ser_lane_1_cond);
    reset<='b0;
    enable<='b0;
    validin0<='b0;
    validin1<='b0;
    entrada_0<='b0;
    entrada_1<='b0;
    
    @(posedge clk_2f);
	reset<='b1;
    enable<='b1;
    validin0<='b1;
	entrada_0<=entrada_0+1;
    
    @(posedge clk_2f);
	validin1<='b1;
	entrada_1<=entrada_1+1;
    entrada_0<=entrada_0+1;

    repeat (2) begin
    @(posedge clk_2f);
    entrada_0<=entrada_0+1;
    entrada_1<=entrada_1+1;
    end

    validin1<='b0;
    validin0<='b0;
    
    @(posedge clk_2f);
    @(posedge clk_2f);
    
    @(posedge clk_2f);
    validin1<='b1;
    entrada_1<=entrada_1+1;

    @(posedge clk_2f);
    validin0<='b1;
    entrada_0<=entrada_0+1;
    entrada_1<=entrada_1+1;
    
    repeat (2) begin
    @(posedge clk_2f);
    entrada_0<=entrada_0+1;
    entrada_1<=entrada_1+1;
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
      
//     if (reset) begin
//         if(_0cond==_0estruct && _1cond==_1estruct)begin
//             $display("Las descripciones son iguales en ambas salidas");   
//         end 
//         else begin
//             $display("Las descripciones NO son iguales en ambas salidas");   
//         end
//     end
//    end

endmodule


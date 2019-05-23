module probador(
	output reg clk_8f, 
	output reg rst,
	output reg enb,
	input clk_2f_cond,
	input clk_f_cond, 
	input clk_2f_estruct,
	input clk_f_estruct);

reg f2_cond,f2_estruct,f_cond,f_estruct;

 initial begin
       
        $dumpfile("gen_clk.vcd");               //Dumpfile to make in current folder
        $dumpvars;
        
        clk_8f <= 0;
        enb <= 0;                       //                           
        rst <= 1;                       // relojes se resetean            
        
        # 10;
        @(posedge clk_8f)
            rst <= 0;
            enb <= 1;
        
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
        $finish;
end

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

    always # 2 clk_8f <= ~clk_8f;       //genera señal 4 ns 

endmodule

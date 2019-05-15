module probador(
    input data_out_conduc,
    input data_out_estruct,
    output reg[7:0]data_in,
    output reg valid_in,
    output reg reset,
    output reg clk_8f);

    reg clk_f;
    reg clk_4f;
    reg clk_ff;
    reg cond;
    reg estruct;
   initial begin
    $dumpfile("bancopruebas.vcd");
    $dumpvars;
    $display("\t\ttime,\t reset, clk_f, clk_8f, valid_in, data_in, data_out_cond, data_out_estruct");

    $monitor($time,"\t%b,\t%b,\t%b,\t%b,\t%h,\t%b,\t%b",reset, clk_f, clk_8f, valid_in, data_in, data_out_conduc, data_out_estruct);
    reset<='b0;
    data_in<='b0;
    valid_in<='b0;
    
    @(posedge clk_8f);
    reset<='b1;
    valid_in<='b1;
    
    repeat (10) begin
    @(posedge clk_f);
    data_in<=data_in+1;
    end

    @(posedge clk_f);
    valid_in<='b0;
    data_in<=data_in+1;

    repeat (2) begin
    @(posedge clk_f);
    data_in<=data_in+1;
    end
     
    $finish;
      
   end

    initial begin
    clk_8f <=0;
    clk_4f <=0;
    clk_f <=0;  
    clk_ff<=0;  
    
    end
    always #2 clk_8f <=~clk_8f;
    
    always @(posedge clk_8f)begin
        clk_4f<=~clk_4f;
    end

    always @(posedge clk_4f)begin
        clk_ff<=~clk_ff;
    end

    always @(posedge clk_ff)begin
        clk_f<=~clk_f;
    end
    
   always @(posedge clk_8f) begin
      cond<=data_out_conduc;
      estruct<=data_out_estruct;
      if (reset) begin
      if(cond==estruct)
         $display("Las descripciones son iguales en ambas salidas");   
      end 
   end

endmodule


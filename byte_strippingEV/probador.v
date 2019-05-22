module probador(
    input [7:0]lane_0_cond,
    input valid_0_cond,
    input [7:0]lane_1_cond,
    input valid_1_cond,
    input [7:0]lane_0_estruct,
    input valid_0_estruct,
    input [7:0]lane_1_estruct,
    input valid_1_estruct,
    output reg [7:0]data_in,
    output reg valid_in,
    output reg reset,
    output reg clk_2f);

    reg clk_f;
    reg clk_4f;
    reg clk_8f;
    reg [7:0] _0cond;
    reg [7:0] _0estruct;
    reg [7:0] _1cond;
    reg [7:0] _1estruct;

   initial begin
    $dumpfile("bancopruebas.vcd");
    $dumpvars;
    $display("\t\ttime,\t reset, clk_2f, valid_in, data_in, lane0cond,valid0cond, lan1cond,valid1cond");

    $monitor($time,"\t%b,\t%b,\t%b,\t%h,\t%h,\t%b,\t%h,\t%b",reset, clk_2f, valid_in, data_in, lane_0_cond, valid_0_cond,lane_1_cond, valid_1_cond);
    reset<='b0;
    data_in<='b0;
    valid_in<='b0;
    
    @(posedge clk_2f);
	reset<='b1;
    valid_in<='b1;
	data_in<=data_in+1;
    
    repeat (11) begin
    @(posedge clk_2f);
    data_in<=data_in+1;
    end
    //Atraso
    @(posedge clk_2f);
    data_in<=data_in+1;
    //Atraso
    @(posedge clk_2f);
    data_in<=data_in+1;


    @(posedge clk_2f);
	valid_in<='b0;
	data_in<=data_in+1;



    @(posedge clk_2f);
	data_in<=data_in+1;

    @(posedge clk_2f);
	valid_in<='b1;
	data_in<=data_in+1;

    @(posedge clk_2f);
    valid_in<='b0;
    data_in<=data_in+1;

    repeat (2) begin
    @(posedge clk_2f);
    data_in<=data_in+1;
    end

    
    $finish;
      
   end

    initial begin
    clk_8f <=0;
    clk_4f <=0;
    clk_f <=0;  
    clk_2f<=0;  
    
    end
    always #2 clk_8f <=~clk_8f;
    
    always @(posedge clk_8f)begin
        clk_4f<=~clk_4f;
    end

    always @(posedge clk_4f)begin
        clk_2f<=~clk_2f;
    end

    always @(posedge clk_2f)begin
        clk_f<=~clk_f;
    end
    
   always @(posedge clk_2f) begin
      _0cond<=lane_0_cond;
      _0estruct<=lane_0_estruct;
      _1cond<=lane_1_cond;
      _1estruct<=lane_1_estruct;
      
    if (reset) begin
        if(_0cond==_0estruct && _1cond==_1estruct)begin
            $display("Las descripciones son iguales en ambas salidas");   
        end 
        else begin
            $display("Las descripciones NO son iguales en ambas salidas");   
        end
    end
   end

endmodule


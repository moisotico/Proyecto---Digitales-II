module gen_clk(
	clk_8f, enable,
	clk_2f, clk_f	
);

    input clk_8f, enable;
    output reg clk_2f, clk_f;   

    reg [1:0] counter;
    reg f2;

    always@(posedge clk_8f) begin
        
        if(!enable) begin
            counter <= 0;
            clk_2f <= 1'b0;
            clk_f <= 1'b0;
        end
        else if (counter < 1) begin
            counter <= counter + 'b1;  // counter de clk_2f y clk_f
        end
        else begin
            counter <= 'b0;                         //resetear counter
            f2 <= 'b1;                         //resetear counter
            clk_2f <= ~clk_2f;                      //clk_2f cada 4 ciclos 
            if(!clk_2f) begin
                clk_f <= ~clk_f;
            end
        end
    end
endmodule

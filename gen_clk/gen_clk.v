`timescale 1ns/1ps

module gen_clk(
	clk_8f, rst, enb,
	clk_2f, clk_f	
);

    input clk_8f, rst, enb;
    output reg clk_2f, clk_f;   

    reg [0:1] counter;

    always@(posedge clk_8f) begin
        
        if(rst) begin
            clk_2f <=   1'b0;
            clk_f <=   1'b0;
        end

        else begin
            if(enb) begin
                if (counter < 3) counter <= counter + 'b1;  // counter de clk_2f y clk_f
                else begin
                    counter <= 'b0;                         //resetear counter
                    if(~clk_2f) clk_2f <= ~clk_2f;          //clk 
                    if(~clk_2f & ~clk_f) clk_f <= ~clk_f; 
                end
            end
        end
    end


endmodule

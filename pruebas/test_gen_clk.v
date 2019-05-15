`timescale 1ns/1ps

`include "../gen_clk/gen_clk.v"

module test_gen_clk;

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire		clk_2f;			// From generador of gen_clk.v
    wire		clk_f;			// From generador of gen_clk.v
    // End of automatics
    /*AUTOREGINPUT*/
    // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
    reg			clk_8f;			// To generador of gen_clk.v
    reg			enb;			// To generador of gen_clk.v
    reg			rst;			// To generador of gen_clk.v
    // End of automatics

    gen_clk generador(/*AUTOINST*/
		      // Outputs
		      .clk_2f		(clk_2f),
		      .clk_f		(clk_f),
		      // Inputs
		      .clk_8f		(clk_8f),
		      .rst		(rst),
		      .enb		(enb));
    
    
    initial clk_8f <= 0;

    initial begin
        $dumpfile("gen_clk.vcd");               //Dumpfile to make in current folder
        $dumpvars;

        clk_8f <= 0;
        enb <= 0;                       //
        rst <= 1;                       // relojes se resetean

        repeat (20) begin
            @(posedge clk_8f)
                enb <= 0;
        end

        repeat(20)begin;
            @(posedge clk_8f)
                rst <= 1;
        end


        repeat(50)begin;
            @(posedge clk_8f)
                enb <= 1;
        end

        repeat (10)begin
            @(posedge clk_8f)
                rst <= 1;
        end
        
        $finish;
    end

    always # 2 clk_8f <= ~clk_8f;       //genera señal 4 ns 

endmodule

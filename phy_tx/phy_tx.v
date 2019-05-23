`include "gen_clk.v"
`include "mux.v"
`include "bs.v"
`include "partoserial.v"
module phy_tx(
    input reset,
    input clk_8f,
    input enable,
    input validin0,
    input validin1,
    input [7:0]entrada_0,
    input [7:0]entrada_1,
    output reg salida_ser_lane_0,
    output reg salida_ser_lane_1);

wire[7:0] salida_mux;
wire valid_mux;
wire [7:0]lane_0;
wire valid_0;
wire [7:0]lane_1;
wire valid_1;
wire sal0parse;
wire sal1parse;
wire clk_2f;
wire clk_f;

gen_clk clks (clk_8f,reset,enable,clk_2f,clk_f);
mux muxes (salida_mux,valid_mux,clk_2f,reset,validin0,entrada_0,validin1,entrada_1);
bs bystripping(salida_mux,valid_mux,reset,clk_2f,lane_0,valid_0,lane_1,valid_1);
partoserial linea0(lane_0,valid_0,reset,clk_8f,sal0parse);
partoserial linea1(lane_1,valid_1,reset,clk_8f,sal1parse);


always@(posedge clk_8f)begin
    if (reset==0) begin
        salida_ser_lane_0<='b0;
        salida_ser_lane_1<='b0;
    end else begin
        salida_ser_lane_0<=sal0parse;
        salida_ser_lane_1<=sal1parse;
    end
end


endmodule

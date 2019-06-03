
 `include "phy_tx.v"
 `include "phy_rx.v"
 `include "gen_clk.v"
 `include "checker.v"

module phy(
            input clk_8f,
            input reset_L,
            input enable,
            input[7:0] data_in_0,
            input[7:0] data_in_1,
            input valid_data_in_0,
            input valid_data_in_1,
            output valid_data_out_0,
            output valid_data_out_1,
            output [7:0] data_out_0,
            output [7:0] data_out_1
);

/*AUTOREG*/
/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			transfer_0;		// From tx_mod of phy_tx.v
wire			transfer_1;		// From tx_mod of phy_tx.v
// End of automatics


//descripcion pendiente
gen_clk clocks(/*AUTOINST*/
	       // Outputs
	       .clk_2f			(clk_2f),
	       .clk_f			(clk_f),
	       // Inputs
	       .clk_8f			(clk_8f),
	       .enable			(enable));    
    
phy_tx tx_mod(/*AUTOINST*/
	      // Outputs
	      .transfer_0		(transfer_0),
	      .transfer_1		(transfer_1),
	      // Inputs
	      .reset_L			(reset_L),
	      .clk_8f			(clk_8f),
	      .clk_2f			(clk_2f),
	      .clk_f			(clk_f),
	      .valid_data_in_0		(valid_data_in_0),
	      .valid_data_in_1		(valid_data_in_1),
	      .data_in_0		(data_in_0[7:0]),
	      .data_in_1		(data_in_1[7:0]));

phy_rx rx_mod(/*AUTOINST*/
	      // Outputs
	      .data_out_0		(data_out_0[7:0]),
	      .data_out_1		(data_out_1[7:0]),
	      .valid_data_out_0		(valid_data_out_0),
	      .valid_data_out_1		(valid_data_out_1),
	      // Inputs
	      .clk_8f			(clk_8f),
	      .clk_2f			(clk_2f),
	      .clk_f			(clk_f),
	      .reset_L			(reset_L),
	      .transfer_0		(transfer_0),
	      .transfer_1		(transfer_1));

endmodule

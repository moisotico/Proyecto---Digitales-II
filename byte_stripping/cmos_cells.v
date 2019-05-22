module BUF(input A,output Y);
assign Y = A;
endmodule

module NOT(input A,output Y);
assign Y = ~A;
endmodule

module NAND(input A, input B, output Y);
assign Y = ~(A & B);
endmodule

module NOR(input A, input B, output Y);
assign Y = ~(A | B);
endmodule

module DFF(input C, input D, output reg Q);
always @(posedge C)
	Q <= D;
endmodule

module DFFSR(input C, input D, input S, input R, output reg Q);
always @(posedge C, posedge S, posedge R)
	if (S)
		Q <= 1'b1;
	else if (R)
		Q <= 1'b0;
	else
		Q <= D;
endmodule
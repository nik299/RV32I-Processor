
`timescale 1ns/1ns

module ProgramCounter(clk, rst, next_addr,pcsrc, addr,st0);
	input clk, rst,pcsrc,st0;
	input [31:0] next_addr;
	output reg [31:0] addr;
initial addr<=0;	
	always @ (posedge clk) 
	begin
		if(st0) 
		begin
			if(rst) addr<=0;
			else addr <=  pcsrc? next_addr:addr+4;
		end
	end
endmodule

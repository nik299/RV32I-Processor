`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:35:03 09/01/2019 
// Design Name: 
// Module Name:    IMEM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`include "parameters.v"
//module IMEM(
//    );


//endmodule
module Imem (clk, iaddr, idata);

input		clk;
input	[`width-1:0]	iaddr;
output	[`width-1:0]	idata;

reg	[`width-1:0]	idata;

//	memAddr is an address register in the memory side.
reg	[`width-1:0]	memAddr;
reg	[`width-1:0]	Imem[0:1023];

	//	Definition of the latency to latch the address and
	//	read the memory.
parameter	addressLatch = 10, memDelay = 70;

	//	The I-Memory is initially loaded
initial
	$readmemh ("Imem.data", Imem);

	//	I-mem is read in every cycle.
	//	A read signal could be added if neccessary.
always @(posedge clk) begin
	//assign memAddr = iaddr[`ADDRESS_WIDTH-1:0];
	assign idata = Imem[{iaddr[9:0]}];
end

endmodule

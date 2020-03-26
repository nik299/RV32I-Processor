`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:56:36 09/17/2019 
// Design Name: 
// Module Name:    top 
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
module top(
    input clk
    ); //Only input from the outside is clock
	 
	 //wire reset,rdy;
	 wire [35:0] VIO_CONTROL;
	 //Control wires used by ICON to control VIO and ILA
    wire clkm, reset;
    wire [31:0] iaddr, idata;
    wire [31:0] daddr, drdata, dwdata;
    wire [3:0] we;
    wire [31:0] x31, pc,wrongaddr;
	 wire [4:0] errorbits;
CPU_pipe instanceA (
        .clk(clkm),
        .rst(reset),
        .iaddr(iaddr),
        .idata(idata),
        .daddr(daddr),
        .drdata(drdata),
        .dwdata(dwdata),
        .we(we),
        .x31(x31),
        .pc(pc),
		  .scause(errorbits),
		  .spec(wrongaddr)
    );	 
dmem instanceB(
		.clk(clkm),
		.daddr(daddr),
		.dwdata(dwdata),
		.drdata(drdata),
		.we(we)
		);
	 
imem instanceC(
		.iaddr(iaddr), 
		.idata(idata)
	);
//Calls for ICON, VIO and ILA blocks
icon0 instanceD (
    .CONTROL0(VIO_CONTROL) // INOUT BUS [35:0]
);

vio0 instanceE (
    .CONTROL(VIO_CONTROL), // INOUT BUS [35:0]
    .CLK(clk), // IN
	 .ASYNC_OUT({clkm,reset}),// IN BUS [1:0]
    .SYNC_IN({idata,daddr,wrongaddr,dwdata,we,x31,pc,errorbits}) // IN BUS [201:0]
);


endmodule

/*
UCF statement to be added in constraints file-
NET "clk" LOC = "C9"  | IOSTANDARD = LVCMOS33 ;
*/

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
	 wire [31:0] indata1,outdata1,daddr1;
	 wire [31:0] outdata2,daddr2,rv2,indata3,rv1;
	 wire [3:0] we;
	 wire we2,clk1,clk2,clk3;
	 wire [4:0] rs1,rs2,rd;
	 //Input-output ports controlled by VIO and ILA
	 
	 wire [35:0] ILA_CONTROL, VIO_CONTROL;
	 //Control wires used by ICON to control VIO and ILA
	 

v_rams_02b instanceA (
		.indata(indata1), 
		.outdata(outdata1), 
		.daddr(daddr1), 
		.we(we), 
		.clk(clk1)
	);
Imem instanceE (
		.clk(clk2), 
		.iaddr(daddr2), 
		.idata(outdata2)
	);
	regi instanceF (
		.rs1(rs1), 
		.rs2(rs2), 
		.rd(rd), 
		.we(we2), 
		.clk(clk3), 
		.indata(indata3), 
		.rv1(rv1), 
		.rv2(rv2)
	);
//Calls for ICON, VIO and ILA blocks
icon0 instanceB (
    .CONTROL0(ILA_CONTROL), // INOUT BUS [35:0]
    .CONTROL1(VIO_CONTROL) // INOUT BUS [35:0]
);

vio0 instanceC (
    .CONTROL(VIO_CONTROL), // INOUT BUS [35:0]
    .CLK(clk), // IN
    .ASYNC_OUT({we2,rs2,rs1,rd,indata3,daddr2,indata1,daddr1,we,clk1,clk2,clk3}), // OUT BUS [151:0]
    .SYNC_IN({rv1,rv2,outdata2,outdata1}) // IN BUS [127:0]
);

ila0 instanceD (
    .CONTROL(ILA_CONTROL), // INOUT BUS [35:0]
    .CLK(clk), // IN
    .TRIG0(outdata), // IN BUS [31:0]
    .TRIG1(we) // IN BUS [1:0]
    //.TRIG2(p) // IN BUS [15:0]
);

endmodule

/*
UCF statement to be added in constraints file-
NET "clk" LOC = "C9"  | IOSTANDARD = LVCMOS33 ;
*/

`timescale 1ns / 1ps

//Implementation Testbench for A0

module top(
    input clk
    ); //Only input from the outside is clock
	 
	 wire reset,rdy;
	 wire [7:0] a,b;
	 wire [15:0] p;
	 //Input-output ports controlled by VIO and ILA
	 
	 wire [35:0] ILA_CONTROL, VIO_CONTROL;
	 //Control wires used by ICON to control VIO and ILA
	 
seq_mult instanceA(
		 // Outputs
		 .p(p), .rdy(rdy), 
		 // Inputs
		 .clk(clk), .reset(reset), .a(a), .b(b)
		 ) ;
//Calling the multiplier instance


//Calls for ICON, VIO and ILA blocks
icon0 instanceB (
    .CONTROL0(ILA_CONTROL), // INOUT BUS [35:0]
    .CONTROL1(VIO_CONTROL) // INOUT BUS [35:0]
);

vio0 instanceC (
    .CONTROL(VIO_CONTROL), // INOUT BUS [35:0]
    .CLK(clk), // IN
    .ASYNC_OUT({a,b,reset}), // OUT BUS [16:0]
    .SYNC_IN({p,rdy}) // IN BUS [16:0]
);

ila0 instanceD (
    .CONTROL(ILA_CONTROL), // INOUT BUS [35:0]
    .CLK(clk), // IN
    .TRIG0(reset), // IN BUS [0:0]
    .TRIG1(rdy), // IN BUS [0:0]
    .TRIG2(p) // IN BUS [15:0]
);

endmodule

/*
UCF statement to be added in constraints file-
NET "clk" LOC = "C9"  | IOSTANDARD = LVCMOS33 ;
*/

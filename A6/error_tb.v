`timescale 1ns / 1ps


module error_tb;

	// Inputs
	reg [31:0] iaddr;
	reg clk,reset;
	wire[31:0] idata;

	// Outputs
	wire [2:0] error;

	// Instantiate the Unit Under Test (UUT)
	errordetect uut (
		.idata(idata), 
		.error(error)
	);
	 imem imem(
		.iaddr(iaddr), 
		.idata(idata)
	);
	always #5 clk = ~clk;
	always @(posedge clk) if(~reset) iaddr=iaddr+4;
	initial begin
		// Initialize Inputs
		iaddr = 0;
	     reset = 1;
        clk = 0;
        #100
        reset = 0;
		 #10000
		 reset=1;

	end
      
endmodule


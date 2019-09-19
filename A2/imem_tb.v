`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:58:24 09/01/2019
// Design Name:   Imem
// Module Name:   /home/nikhil/Downloads/xilinx/Assign2/imem_tb.v
// Project Name:  Assign2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Imem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`include "parameters.v"
module imem_tb;

	// Inputs
	reg clk;
	reg [31:0] address,exp;
	reg [`width-1:0] instrmem[0:`ADDRESS-1];

	// Outputs
	wire [31:0] instruction;

	// Instantiate the Unit Under Test (UUT)
	Imem uut (
		.clk(clk), 
		.iaddr(address), 
		.idata(instruction)
	);
	integer total, err,i;
	always #5 clk = !clk;

	task apply_and_check;
		input integer i;
		begin
			exp = instrmem[i];
			// Clock tick not necessary, but keeps the tests cleanly separated
			@(posedge clk);

			if (instruction == exp) begin
				$display($time, " Passed instr=%b adress=%d", instruction,address);
			end else begin
				$display($time, " Passed instr=%b exp=%b,address=%d", instruction,exp,address);
				err = err + 1;
			end
			total =total+ 1;

		end
	endtask // apply_and_check

	initial begin
		// Initialize the clock 
		clk = 0;
		// Counters to track progress
		total = 0;
		err = 0;
		address = 0;
		#100
		// Read in instructions, in1, in2 sequence
		$readmemh("Imem.txt", instrmem);

		for (i=0; i<40; i=i+1) begin
			apply_and_check(i);
			address = address+1;
		end

		if (err > 0) begin
			$display("FAIL %d out of %d", err, total);
		end else begin
			$display("PASS %d tests", total);
		end
		$finish;
	end


endmodule


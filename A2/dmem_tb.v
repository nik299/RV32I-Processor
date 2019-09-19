`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:24:57 09/01/2019
// Design Name:   DMEM
// Module Name:   /home/nikhil/Downloads/xilinx/Assign2/dmem_tb.v
// Project Name:  Assign2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DMEM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module dmem_tb;

	// Inputs
	reg [31:0] indata;
	reg [31:0] daddr;
	reg [1:0] we;
	reg clk;

	// Outputs
	wire [31:0] outdata;
	integer total, err;

	// Instantiate the Unit Under Test (UUT)
	v_rams_02b uut (
		.indata(indata), 
		.outdata(outdata), 
		.daddr(daddr), 
		.we(we), 
		.clk(clk)
	);
	task apply_and_check;
		input [31:0] address;
		input [31:0] data;
		input [1:0] mode;
		input [31:0] exp;
		begin
		#3
			assign indata = data;
			assign daddr = address;
			assign we = mode;
			#10  // Clock tick necessary,since output maybe expected to take 1 clock cycle 
			@(posedge clk);
			if (outdata == exp) begin
				$display($time, " Passed outdata=%h address=%h we=%b indata=%h", outdata,daddr,we,indata);
			end else begin
				$display($time, " Fail outdata=%h exp=%h address=%h we=%b indata=%h",outdata,exp,daddr,we,indata);
				err = err + 1;
			end
			total =total+ 1;
		end
	endtask // apply_and_check
always #5 clk = !clk;
	initial begin
		// Initialize Inputs
		indata = 0;
		daddr = 0;
		we = 0;
		clk = 0;
		err=0;
		total=0;

		// Wait 100 ns for global reset to finish
		//note for syntax of apply and check
		//1.apply_and_check(address[31:0],data[31:0],mode[1:0],expected value[31:0])
		//2. mode 00 read 32 bit            ,01 32 bit write
		//   mode  10 invalid but same as 00 ,11 write a byte at given address
		//3. initial valuesof RAMs are zeros
		#100;
		apply_and_check(32'h00000000,32'h04030201,2'b01,32'h04030201);
		apply_and_check(32'h00000002,32'h04060202,2'b11,32'h04020201);
		apply_and_check(32'h000000A2,32'h04030202,2'b11,32'h00020000);
		apply_and_check(32'h00100004,32'h12345678,2'b01,32'h12345678);
		apply_and_check(32'h000000A2,32'h12345678,2'b00,32'h00020000);
		if (err > 0) begin
			$display("FAIL %d out of %d", err, total);
		end else begin
			$display("PASS %d tests", total);
		end
		$finish;
	end
      
endmodule


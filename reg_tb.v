`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:39:27 09/03/2019
// Design Name:   regi
// Module Name:   /home/nikhil/Downloads/xilinx/Assign2/reg_tb.v
// Project Name:  Assign2
// Target Device:  spartan 3e
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: regi
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module reg_tb;

	// Inputs
	reg [4:0] rs1;
	reg [4:0] rs2;
	reg [4:0] rd;
	reg we;
	reg clk;
	reg [31:0] indata;

	// Outputs
	wire [31:0] rv1;
	wire [31:0] rv2;
	integer total, err;
	// Instantiate the Unit Under Test (UUT)
	regi uut (
		.rs1(rs1), 
		.rs2(rs2), 
		.rd(rd), 
		.we(we), 
		.clk(clk), 
		.indata(indata), 
		.rv1(rv1), 
		.rv2(rv2)
	);
	task apply_and_check;
		input [4:0] rs1a;
		input [4:0] rs2a;
		input [4:0] rda;
		input wea;
		input [31:0] data;
		input [31:0] exp1;
		input [31:0] exp2;
		begin
			assign rs1 = rs1a;
			assign rs2 = rs2a;
			assign rd = rda;
			assign we = wea;
			assign indata =data;
			// Clock tick not necessary, but keeps the tests cleanly separated
			@(posedge clk);

			if ((rv1 == exp1)&(rv2 == exp2)) begin
				$display($time, " Passed rs1=%b rv1=%h rs2=%b rv2=%h we =%b ",rs1,rv1,rs2,rv2,we);
			end else begin
				$display($time, " Fail rs1=%b rv1=%h exp1=%h rs2=%b rv2=%h exp2=%h we =%b ",rs1,rv1,exp1,rs2,rv2,exp2,we);
				err = err + 1;
			end
			total =total+ 1;
		end
	endtask // apply_and_check
	always #5 clk = !clk;
	initial begin
		// Initialize Inputs
		rs1 = 0;
		rs2 = 0;
		rd = 0;
		we = 0;
		clk = 0;
		indata = 0;
		total=0;
		err=0;

		// Wait 100 ns for global reset to finish
		#100;
		//Notes for apply_and_check(rs1,rs2,rd,we,indata,exp(rv1),exp(rv2))
      apply_and_check(5'b00000,5'b00000,5'b00001,1'b1,32'h00000009,32'h0000000,32'h00000000);
		apply_and_check(5'b00001,5'b00000,5'b00000,1'b1,32'h0000000a,32'h0000009,32'h00000000);
		apply_and_check(5'b00001,5'b00000,5'b00010,1'b1,32'h0000000a,32'h0000009,32'h00000000);
      apply_and_check(5'b00010,5'b00001,5'b00011,1'b1,32'h0000000b,32'h000000a,32'h00000009);
		apply_and_check(5'b00011,5'b00010,5'b00100,1'b1,32'h0000000c,32'h000000b,32'h0000000a);
		apply_and_check(5'b00100,5'b00000,5'b00101,1'b1,32'h0000000d,32'h000000c,32'h00000000);
		 //Add stimulus here
		if (err > 0) begin
			$display("FAIL %d out of %d", err, total);
		end else begin
			$display("PASS %d tests", total);
		end
		$finish;
	end
      
endmodule


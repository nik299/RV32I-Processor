//                              -*- Mode: Verilog -*-
// Filename        : seq-mult.v
// Description     : Sequential multiplier

// This implementation corresponds to a sequential multiplier, but
// most of the functionality is missing.  Complete the code so that
// the resulting module implements multiplication of two numbers in
// twos complement format.

// All the comments marked with *** correspond to something you need
// to fill in.

// This style of modeling is 'behavioural', where the desired
// behaviour is described in terms of high level statements ('if'
// statements in verilog).  This is where the real power of the
// language is seen, since such modeling is closest to the way we
// think about the operation.  However, it is also the most difficult
// to translate into hardware, so a good understanding of the
// connection between the program and hardware is important.

`define width 8
`define ctrwidth 4

module seq_mult (
		 // Outputs
		 p, rdy, 
		 // Inputs
		 clk, reset, a, b
		 ) ;
   input 		 clk, reset;
   input [`width-1:0] 	 a, b;
   // *** Output declaration for 'p'
   output 		 rdy;
	output [2*`width-1:0] p;
   
   // *** Register declarations for p, multiplier, multiplicand
   reg 			 rdy;
   reg [`ctrwidth:0] 	 ctr;
	reg [2*`width-1:0] multiplier;
	reg [2*`width-1:0] multiplicand;
	reg [2*`width-1:0] p;
	reg [2*`width-1:0] temp;

   always @(posedge clk or posedge reset)
     if (reset) begin
	rdy 		<= 0;
	p 		<= 0;
	ctr 		<= 0;
	temp<=0;
	multiplier 	<= {{`width{b[`width-1]}}, b}; // sign-extend
	multiplicand 	<= {{`width{a[`width-1]}}, a}; // sign-extend
     end else begin 
	if (ctr < `width/* *** How many times should the loop run? */ ) 
	  begin
	  if ((multiplier[ctr] == 1)&&(ctr!=7))
		begin
		p<=p+(multiplicand<<ctr);
		end else if ((multiplier[ctr] == 1)&&(ctr==7))
		 begin
		 p<=p-(multiplicand<<ctr);
		 end
	  ctr<=ctr+1;
	     // *** Code for multiplication
	  end else begin
	     rdy <= 1; 		// Assert 'rdy' signal to indicate end of multiplication
	  end
     end
   
endmodule // seqmult

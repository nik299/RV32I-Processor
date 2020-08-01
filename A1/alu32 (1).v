`include "parameters.v"

module ALU32 (
    in1, in2, op, out
);
    input [`width-1:0] in1, in2;
    input [`OPWIDTH-1:0] op;
    output reg [`width-1:0] out;
	 reg signed [`width-1:0] in3,in4;
    always @(in1 or in2 or op) begin
		  in3<=in1;
		  in4<=in2;
		  out<=0;
        case(op)
		  5'b00000 : out<=in1+in2;
		  5'b10000 : out<=in1+in2;
		  5'b00001 : out<=in1+in2;
		  5'b10001 : out<=in1-in2;
		  5'b11100 : out<=in1|in2;
		  5'b01100 : out<=in1|in2;
		  5'b01101 : out<=in1|in2;
		  5'b11110 : out<=in1&in2;
		  5'b01110 : out<=in1&in2;
		  5'b01111 : out<=in1&in2;
		  5'b11000 : out<=in1^in2;
		  5'b01000 : out<=in1^in2;
		  5'b01001 : out<=in1^in2;
		  5'b00011 : out<=in1<<in2[4:0];
		  5'b00010 : out<=in1<<in2[4:0];
		  5'b01011 : out<=in1>>in2[4:0];
		  5'b01010 : out<=in1>>in2[4:0];
		  5'b11011 : out<=in3 >>> in4[4:0];
		  5'b11010 : out<=$signed(in1) >>> in2[4:0];
		  5'b10100 : out<=in3<in4;
		  5'b00100 : out<=in3<in4;
		  5'b00101 : out<=in3<in4;
		  5'b10110 : out<=in1<in2;
		  5'b00110 : out<=in1<in2;
		  5'b00111 : out<=in1<in2;
		  endcase
    end

endmodule
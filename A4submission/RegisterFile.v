

`timescale 1ns/1ns

module RegisterFile(clk, rst, rs1, rs2, rd, rv1, rv2, indata, we,x31);
    input clk, rst, we;
    input [4:0] rs1, rs2, rd;
    output [31:0] rv1, rv2,x31;
    input [31:0] indata;
    reg [31:0] mem [31:0];
    //forwarding accross registers as this is expected
    assign rv1 = ((rs1 == rd) & (rd != 0) & we)? indata : mem[rs1];
    assign rv2 = ((rs2 == rd) & (rd != 0) & we)? indata : mem[rs2];
	 assign x31 = mem[5'b11111];
integer i;

initial for (i=0;i<32;i=i+1) mem[i] =0; //forcing the first register to zero
    always @(posedge clk) 
	 begin
		if(rst) for (i=0;i<32;i=i+1) mem[i] <=0; 
      else  if (we) mem[rd] <= indata;
		mem[{5'b0000}] <= 32'h00000000;  
    end
endmodule
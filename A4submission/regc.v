`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:32:28 11/03/2019 
// Design Name: 
// Module Name:    regc 
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
module regc(
regwrite,
memout,
iobytes,
aluout,
mem_read,
mem_read_sext,
finregw
    );
input [31:0] regwrite,memout;	 
input [3:0] iobytes;
input [1:0] aluout;
input mem_read,mem_read_sext;
wire [31:0] memimm;
output [31:0] finregw;
assign memimm = memout>>{aluout[1:0],3'b000};
wire [31:0] memextb, memexth, memext;	 
Extender #(8) memory(.isSigned(mem_read_sext), .in(memimm), .out(memextb));
Extender #(16) memory2(.isSigned(mem_read_sext), .in(memimm), .out(memexth));    
Mux8 mux8(.A(memout), .B(memextb), .C(memout), .D(memexth), .E(memout), .F(memout), .G(memout), .H(memout), .sel(iobytes[2:0]), .O(memext)); 
assign finregw =mem_read? memext: regwrite;
endmodule

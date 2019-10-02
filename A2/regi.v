`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:48:43 09/03/2019 
// Design Name: 
// Module Name:    regi 
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

module regi(
    input [4:0] rs1,//required address for rv1
    input [4:0] rs2,//required address for rv2
    input [4:0] rd,// required address for input data
    input we,
    input clk,
    input [31:0] indata,
    output [31:0] rv1,
    output [31:0] rv2
    );
reg [31:0] mem [0:31];
assign rv1 = mem[rs1];
assign rv2 = mem[rs2];
initial begin
mem[{5'b0000}]<= 32'h00000000;
end
always@(posedge clk)
  begin
  if(we)//doing it in write first mode I think
    begin
    mem[rd] <= indata;
    mem[{5'b0000}] <= 32'h00000000;//trying to put x0 register to 0 always
    end
  end
endmodule

`timescale 1ns / 1ps

module branch(
Z,
N,
V,
branch,
ui,
u_control,
jal,
jalr,
funct3,
pcimm,
aluout,
next_addr,
pcsrc
    );
input Z,N,V,branch,ui,u_control,jal,jalr;
input [2:0] funct3;
input [31:0] pcimm,aluout;
output pcsrc;
output [31:0] next_addr;
wire condition, signed_comp,load_pc;
assign load_pc = (branch & condition) | jal | (ui & (~u_control));//all cases where pc+4 is not used
assign signed_comp = (V)? ~N: N;
assign pcsrc = load_pc | jalr;
Mux8 #(1) mux8(.A(Z), .B(~Z), .C(1'b0), .D(1'b0), .E(signed_comp), .F(~signed_comp), .G(N), .H(~N), .sel(funct3), .O(condition));
assign next_addr= jalr? {{aluout[31:1]},1'b0} : pcimm;

endmodule

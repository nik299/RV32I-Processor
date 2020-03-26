
`timescale 1ns/1ns

module CPU(
    clk,
	 rst,
    drdata,
    we,
    dwdata,
    daddr,
    idata,
    iaddr,
	 pc,
	 x31
);


input clk;
input rst;
input [31:0] drdata;
input [31:0] idata;

output [3:0] we;
output [31:0] dwdata;
output [31:0] daddr;
output [31:0] iaddr;
output [31:0] pc;
output [31:0] x31;

wire [31:0] memin;
wire [3:0] iobytes;
wire [3:0] extra;
wire Z, N, V;
wire [31:0] rv1, rv2, regwrite,finregw;
wire [31:0] imm, pcimm, aluout,next_addr;
wire [3:0] alu_op; //last bit is add to sub, etc
wire r, jal, ui, u_control, i, s, branch,jalr,pcsrc,st0;
wire mem_read, mem_read_sext,regwe;

assign we = ({4{s}} & extra);
assign daddr = aluout;
assign pc=iaddr;
assign st0 =1;
ProgramCounter pc1(.clk(clk),.rst(rst), .addr(iaddr), .next_addr(next_addr),.pcsrc(pcsrc),.st0(st0));

DataPath dp(.pc(iaddr), .memin(memin), .pcimm(pcimm), .rv1(rv1), .rv2(rv2), .regwrite(regwrite), .alu_op(alu_op), .imm(imm), .aluout(aluout), .r(r), .jal(jal), .ui(ui), .u_control(u_control), .i(i), .s(s), .branch(branch),.jalr(jalr), .Z(Z), .N(N), .V(V));

Decoder dc(.word(idata), .alu_op(alu_op), .imm(imm), .r(r), .jal(jal), .ui(ui), .u_control(u_control), .i(i), .s(s), .branch(branch),.jalr(jalr), .mem_read(mem_read), .mem_read_sext(mem_read_sext),.regwe(regwe), .iobytes(iobytes));

RegisterFile file(.clk(clk), .rst(rst), .rs1(idata[19:15]), .rs2(idata[24:20]), .rd(idata[11:7]), .rv1(rv1), .rv2(rv2), .indata(finregw), .we(regwe),.x31(x31));

memc mem1(.memdata(memin),.addr(aluout[1:0]),.type(iobytes),.ioout(extra),.memin(dwdata));

branch branch1(.Z(Z),.N(N),.V(V),.branch(branch),.ui(ui),.u_control(u_control),.jal(jal),.jalr(jalr),.funct3(idata[14:12]),.pcimm(pcimm),.aluout(aluout),.next_addr(next_addr),.pcsrc(pcsrc));
regc regc(.regwrite(regwrite), .memout(drdata), .iobytes(iobytes),.aluout(aluout[1:0]), .mem_read(mem_read), .mem_read_sext(mem_read_sext),.finregw(finregw));
endmodule

`timescale 1ns/1ns

//Data then control signals then outputs
module DataPath(
    pc,
    rv1, 
    rv2, 
    regwrite,
    alu_op,
    imm,
    aluout,
    r,
    jal,
    ui,
    u_control,
    i,
    s,
    branch,
	 jalr,
    memin,
    pcimm,
    Z,
    N,
    V
);
input [3:0] alu_op;
input [31:0] rv1,rv2,pc, imm;
input r, jal, ui, u_control, i, s, branch,jalr;
output Z, N, V;
output [31:0] aluout, memin, pcimm,regwrite;
    
wire [31:0] bAlu,add_addr;


assign bAlu = ({32{r | branch}} & rv2) | ({32{i | s}} & imm);
    
ALU thing(.A(rv1), .B(bAlu), .switch(alu_op[3]), .operation(alu_op[2:0]), .O(aluout), .Z(Z), .N(N), .V(V));

assign pcimm = pc + imm;
   
assign regwrite = ({32{ui}} & ((u_control)? imm : pcimm)) | ({32{jal | jalr}} & {pc+4}) | ({32{r |(i & ~jalr)}} & aluout) ;


    
assign memin = rv2;
    
endmodule
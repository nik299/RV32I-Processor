
`timescale 1ns/1ns

module Decoder(
    word,
    alu_op,
    imm,
    r,
    jal,
    ui,
    u_control,
    i,
    s,
    branch,
	 jalr,
    mem_read,
    mem_read_sext,
	 regwe,
    iobytes
);
input [31:0] word;
output [31:0] imm;
output [3:0] alu_op; //last bit is add to sub, etc
output r, jal, ui, u_control, i, s, branch,jalr;
output mem_read, mem_read_sext,regwe;
output [3:0] iobytes;

wire arith, load_store;
wire [2:0] funct3;
wire [31:0] imm_u,imm_uj,imm_i,imm_s,imm_sb;
assign funct3 = word[14:12];                               //for diffrent subfunctions
assign u_control = word[5];                              //for extra help
assign arith = (word[4:2] == 3'b100);                      //arthematic
assign load_store = (word[4:2] == 3'b000) & ~word[6];      //load or store
assign ui = (word[4:2] == 3'b101);                         //lui or auipc
assign jal = (word[4:2] == 3'b011);                        //jal or fence(not done)
assign jalr =(word[4:2] == 3'b001);                        //jalr
assign r = arith & u_control;                                //1 r based 0 imm based arithmetic
assign i = ((arith | load_store ) & (~u_control)) | jalr;    //imm_i used ie imm
assign s = load_store & u_control ;                          //store 
assign mem_read = load_store & ~(u_control);                 //load
assign branch = (word[4:2] == 3'b000)& u_control & word[6];  //branch statements 
assign regwe = ~(branch | s);//regwe


// immediate generation
assign imm_uj = {{11{word[31]}}, word[31], word[19:12], word[20], word[30:21], 1'b0};//jal
assign imm_u = {word[31:12], 12'b0};                                                 //lui or auipc
assign imm_i = {{20{word[31]}}, word[31:20]};                                        // control signal i for immediate arithmetic or load or jalr
assign imm_s = {{20{word[31]}}, word[31:25], word[11:7]};                            // for store
assign imm_sb = {{19{word[31]}}, word[31], word[7], word[30:25], word[11:8], 1'b0};  //for branch
assign imm = (({32{ui}} & imm_u) | ({32{jal}} & imm_uj) | ({32{i}} & imm_i) | ({32{s}} & imm_s) | ({32{branch}} & imm_sb));
assign mem_read_sext = ~funct3[2];            //lhu or lbu

assign alu_op = arith? { ((u_control | (funct3 == 3'b101)) & word[30]), funct3}: {{~(load_store | jalr)}, 3'b000};

Mux4 #(4) mux4(.A(4'b0001), .B(4'b0011), .C(4'b1111), .D(4'b0000), .sel(funct3[1:0]), .O(iobytes));









endmodule
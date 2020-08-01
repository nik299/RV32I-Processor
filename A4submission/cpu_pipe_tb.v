module cpu_pipe_tb();
    reg clk, reset;
    wire [31:0] iaddr, idata;
    wire [31:0] daddr, drdata, dwdata;
    wire [3:0] we;
    wire [31:0] x31, pc;
	 wire [29:0] count;
	 parameter s1 = 64;//32+32
	 parameter s2 = 165;//
	 parameter s3 = 109;
	 parameter s4 = 108;

	 wire [s1-1:0] IF_ID;
	 wire [s2-1:0] ID_EX;
	 wire [s3-1:0] EX_MEM;
	 wire [s4-1:0] MEM_WB;
	assign count= iaddr[31:2]+1;
    CPU_pipe dut (
        .clk(clk),
        .rst(reset),
        .iaddr(iaddr),
        .idata(idata),
        .daddr(daddr),
        .drdata(drdata),
        .dwdata(dwdata),
        .we(we),
        .x31(x31),
        .pc(pc),
		  .IF_ID(IF_ID),
		  .ID_EX(ID_EX),
		  .EX_MEM(EX_MEM),
		  .MEM_WB(MEM_WB)
    );
	 
	 dmem dmem(
		.clk(clk),
		.daddr(daddr),
		.dwdata(dwdata),
		.drdata(drdata),
		.we(we)
		);
	 
	 imem imem(
		.iaddr(iaddr), 
		.idata(idata)
	);
	
    always #5 clk = ~clk;
    initial begin
	     reset = 1;
        clk = 0;
        #100
        reset = 0;
		 #10020
		 reset=1;
    end
endmodule

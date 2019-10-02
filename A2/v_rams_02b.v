`timescale 1ns / 1ps
`include "parameters.v"
//please don't talk about naming
module v_rams_02b (indata,   // Input data into the memory
            outdata,     // Output data from the memory
            daddr,     // Address of data to be read/written
            we,        // When we[0] is high its a write operation then we[1] when high enables byte write 
            clk);      // Clock
input clk;
input [3:0] we;
input [31:0] daddr;      //[31:0] for bus width used
input [31:0] indata;
output [31:0] outdata;
reg [7:0] RAM0 [1023:0]; //[7:0] for byte size data [1023:0] is required RAM size
reg [7:0] RAM1 [1023:0]; // 4 RAM for reaching 32 bits 4*8=32
reg [7:0] RAM2 [1023:0];
reg [7:0] RAM3 [1023:0];
reg [9:0] read_addr;//thi is needed if issue is not resolved	
reg [7:0] di0, di1,di2,di3;//input registers for handling two different modes of input
integer i;
initial begin for (i=0;i<1024;i=i+1)
begin 
RAM0[i] =0;
RAM1[i] =0;
RAM2[i] =0;
RAM3[i] =0; 
end 
end 
always@(we or indata)
	begin
	di0 <= indata[7:0];
	di1 <= indata[15:8];
	di2 <= indata[23:16];
	di3 <= indata[31:24];
	end

always @(posedge clk)
	begin
	if (we[0])
		begin
		RAM0[daddr[11:2]] <= di0;
		end
	if (we[1])
		begin
		RAM1[daddr[11:2]] <= di1;
		end
	if (we[2])
		begin
		RAM2[daddr[11:2]] <= di2;
		end
	if (we[3])
		begin
		RAM3[daddr[11:2]] <= di3;
		end
	read_addr <= daddr[11:2];
	end
//issue here please change code on next lab and teat it	but somehow it works!!
assign outdata = {RAM3[read_addr],RAM2[read_addr],RAM1[read_addr],RAM0[read_addr]};
endmodule

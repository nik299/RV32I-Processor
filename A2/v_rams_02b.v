`timescale 1ns / 1ps
`include "parameters.v"
//please don't talk about naming
module v_rams_02b (indata,   // Input data into the memory
            outdata,     // Output data from the memory
            daddr,     // Address of data to be read/written
            we,        // When we[0] is high its a write operation then we[1] when high enables byte write 
            clk);      // Clock
input clk;
input [1:0] we;
input [31:0] daddr;      //[31:0] for bus width used
input [31:0] indata;
output [31:0] outdata;
reg [7:0] RAM0 [1023:0]; //[7:0] for byte size data [1023:0] is required RAM size
reg [7:0] RAM1 [1023:0]; // 4 RAM for reaching 32 bits 4*8=32
reg [7:0] RAM2 [1023:0];
reg [7:0] RAM3 [1023:0];
reg [9:0] read_addr;     //not sure if this is actually needed
reg [7:0] di0, di1,di2,di3;//input registers for handling two different modes of input
reg [3:0] a;             //needed for extracting which byte to write from address
wire a1;//not nee
always @( we or daddr[1:0])
begin
if(we[1])
begin
case(daddr[1:0])
2'b00  : a <= 4'b0001;
2'b01  : a <= 4'b0010;
2'b10  : a <= 4'b0100;
2'b11  : a <= 4'b1000; 
endcase
end
else
begin
a <= 4'b1111;
end
end
always@(we or indata or daddr)
begin
	if(we[1])
		begin
		if(a[0])
			begin
			di0 <= indata[7:0];
			end
		if(a[1])
			begin
			di1 <= indata[7:0];
			end
		if(a[2])
			begin
			di2 <= indata[7:0];
			end
		if(a[3])
			begin
			di3 <= indata[7:0];
			end
		end
	else
		begin
		di0 <= indata[7:0];
		di1 <= indata[15:8];
		di2 <= indata[23:16];
		di3 <= indata[31:24];
		end
end
initial begin
$readmemh ("init.data", RAM0);
$readmemh ("init.data", RAM1);
$readmemh ("init.data", RAM2);
$readmemh ("init.data", RAM3);
end
always @(posedge clk)
begin
//write first(mostly) but both are synchronous
if (a[0] & we[0])
begin
RAM0[daddr[11:2]] <= di0;
end
if (a[1] & we[0])
begin
RAM1[daddr[11:2]] <= di1;
end
if (a[2] & we[0])
begin
RAM2[daddr[11:2]] <= di2;
end
if (a[3] & we[0])
begin
RAM3[daddr[11:2]] <= di3;
end
read_addr <= daddr[11:2];
end
//then read
assign outdata = {RAM3[read_addr],RAM2[read_addr],RAM1[read_addr],RAM0[read_addr]};
endmodule

`timescale 1ns / 1ps
module memc(
memdata,
addr,
type,
ioout,
memin,
error
    );
input [31:0] memdata;
input [1:0] addr;
input [3:0] type;

output [3:0] ioout;
output [31:0] memin;
output error;
assign ioout = (type !=0)? (type<<addr):type;
assign memin = (type!=0)? (memdata<<{{addr},3'b000}):memdata;
assign error = ((type == 4'b0011) & (addr[0])) | ((type == 4'b1111) & (addr[0] | addr[1]));
endmodule

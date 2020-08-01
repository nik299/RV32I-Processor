`timescale 1ns / 1ps
module memc(
memdata,
addr,
type,
ioout,
memin
    );
input [31:0] memdata;
input [1:0] addr;
input [3:0] type;

output [3:0] ioout;
output [31:0] memin;
assign ioout = (type !=0)? (type<<addr):type;
assign memin = (type!=0)? (memdata<<{{addr},3'b000}):memdata;

endmodule

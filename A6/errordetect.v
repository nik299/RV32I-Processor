`timescale 1ns / 1ps

module errordetect(
    idata,
	 error
    );
input [31:0] idata;
output [2:0] error;
wire t4,t5,t6,t7;
assign t4 = (idata[6:2]==5'b11001);
assign t5 = (idata[6:2]==5'b11000);
assign t6 = (idata[6:2]==5'b00000);
assign t7 = (idata[6:2]==5'b01000);
assign t8 = (idata[6:2]==5'b00100);
assign t9 = (idata[6:2]==5'b01100);
assign error[0] = ~((idata[0] & idata[1])  & ((idata[6:2]==5'b01101) | (idata[6:2]==5'b00101) | (idata[6:2]==5'b11011) | t4 | t5 | t6 | t7 | t8 | t9));
assign error[1] = (t4 & ~(idata[14:12]==3'b000)) | (t5 & (idata[14:12]==3'b010 | idata[14:12]==3'b011)) | (t6 & (idata[14:12]==3'b110 | idata[14:12]==3'b011 | idata[14:12]==3'b111)) | (t7 & (idata[14:12]==3'b011 | idata[14]==1 ));
assign error[2] =  ((t9 | (t8 & idata[13:12]==2'b01)) & (idata[29:25]!=5'b00000) & idata[31]);
endmodule

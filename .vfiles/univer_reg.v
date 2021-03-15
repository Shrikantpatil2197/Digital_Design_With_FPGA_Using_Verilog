`timescale 1ns / 1ps

module univer_reg(
    input clk,reset,lsi,rsi,
    input [1:0]sel,
    input [3:0]din,
    output reg [3:0]qout
    );
 initial begin
 qout=4'b0000;
 end   
always @(posedge clk)begin 
if(!reset)
 qout<=4'b0000;                                                              
else begin
 case(sel)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
  2'b00:
   qout<=qout;
  2'b01:
   qout<={rsi,qout[3:1]};
  2'b10:
   qout<={qout[2:0],lsi};
  2'b11:
   qout<=din;
 endcase
end
end    
endmodule

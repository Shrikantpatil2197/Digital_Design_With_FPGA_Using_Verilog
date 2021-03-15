`timescale 1ns / 1ps

module moore_seqnd(
    input clk,din,reset,
    output reg y
    );
reg [1:0]cur_state=0;
reg [1:0]nxt_state=0;
parameter[1:0]INIT=0,s1=1,s2=2,s3=3;    
//update state register
always@(posedge clk)
begin
 if(!reset)
 cur_state <= nxt_state;
 else
 cur_state <= INIT;
end

//nextstate decoder
always@(cur_state,din)
begin
case(cur_state)
INIT:begin
  if(din==1'b0) nxt_state=INIT; 
  else nxt_state=s1;
  end
s1:begin
   if(din==1'b0) nxt_state=s2;
   else nxt_state=s1;
end
s2:begin
   if(din==1'b0) nxt_state=INIT; 
   else nxt_state=s3;
end
s3:begin
   if(din==1'b1) nxt_state=s2;
   else nxt_state=s1;
end
default: nxt_state=INIT;
endcase
end    
    
//output decoder
always@(cur_state)begin
case(cur_state)
INIT: y = 1'b0;
s1: y = 1'b0;
s2: y = 1'b0;
s3: y = 1'b1;
default: y=1'b0;
endcase
end       
endmodule

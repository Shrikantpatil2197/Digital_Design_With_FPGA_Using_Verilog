`timescale 1ns / 1ps

module fulladd(
    input a,b,cin,
    output sum,cout    
    );
assign sum = a^b^cin;
assign cout = (a&b)|(a&cin)|(b&cin);
endmodule

module rshiftreg1(
    input clk,load,rshift,
    input [15:0] data,
    output reg [15:0] dout
    );
always @(posedge clk)begin
if (load) dout <= data;
else if (rshift) dout <= {1'b0,dout[15:1]};
end
endmodule

module rshiftreg2(
    input clk,rshift,clear,sdin,
    output reg [15:0] dout
    );
always @(posedge clk)begin
if (rshift) dout <= {sdin,dout[15:1]};
else if (clear) dout <= 0;
end
endmodule

module dff(
    input clk, din,clear,
    output reg qout
    );
always @(posedge clk)
begin
if (clear) qout <= 1'b0;
else qout <= din;
end
endmodule    

module counter(
    input clk, dcr,load,
    input [4:0] din,
    output reg [4:0] dout
    );
always @(posedge clk)
begin
if (load) dout <= din;
else if (dcr) dout<= dout-1;
end
endmodule

module comparator(
    input [3:0] data,
    output eqz
    );
assign eqz = (data==0); 
endmodule
    
module datapath(
    input [15:0]dataA,dataB,
    input [4:0]datactr,
    input clk,ldA,ldB,ldctr,clrsum,clrdff,rightsft,decctr,
    output eqz,
    output reg [15:0]fresult,
    output reg [4:0]ctrout
    );
wire cin,cout,z;
wire [15:0]x,y;

rshiftreg1 A(clk,ldA,rightsft,dataA,x);
rshiftreg1 B(clk,ldB,rightsft,dataB,y);
fulladd add(x[0],y[0],cin,z,cout);
rshiftreg2 result(clk,rightsft,clrsum,z,fresult);
counter ctr(clk,decctr,ldctr,datactr,ctrout);
comparator cmp(ctrout, eqz);
dff carry(clk,cout,clrdff,cin);
endmodule

module controller(
    input clk,start,eqz,
    output reg ldA, ldB, clrdff, clrsum, done,decctr,ldctr,rightsft
    );
reg [1:0]cur_state=0, nxt_state=0;
parameter s0=0,s1=1,s2=2,s3=3;
always @(posedge clk)
begin
cur_state <= nxt_state;
end

always @(*)
begin 
case(cur_state)
s0: if (start) nxt_state=s1;
s1: nxt_state=s2;
s2: if (eqz) nxt_state=s3;
s3: nxt_state=s0;
default: nxt_state=s0;
endcase
end

always@(*)
begin
case(cur_state)
s0: begin
    clrdff=1; clrsum=1;ldA=0;ldB=0; decctr=0;
    end
s1: begin
    ldA=1; ldB=1;clrsum=0;ldctr=1;clrdff=0;
    end
s2: begin
    ldA=0;ldB=0;ldctr=0;rightsft=1;decctr=1;   
    end
s3: begin
    rightsft=0;decctr=0;done=1;
    end
endcase
end
endmodule

module serial_adder(
    input start,clk,
    input [15:0]data1,data2,
    input [4:0]datactr,
    output reg done,
    output reg [15:0]sumout
    );
 wire ldA,ldB,ldctr,clrsum,clrdff,rightsft,decctr,eqz;
 datapath d(data1,data2,datactr,clk,ldA,ldB,ldctr,clrsum,clrdff,rightsft,decctr,eqz,sumout);
 controller c(clk,start,eqz,ldA, ldB, clrdff, clrsum, done,decctr,ldctr,rightsft);
endmodule


`timescale 1ns / 1ps


module muxdf4_1(i3,i2,i1,i0,s1,s0,out);
 input i3,i2,i1,i0,s1,s0;
 output out;
 assign out = (~s1&~s0&i0)|(~s1&s0&i1)|(s1&~s0&i2)|(s1&s0&i3);
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2020 11:36:37 AM
// Design Name: 
// Module Name: mux2_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux2_1(a,b,s,out);
 input a;
 input b;
 input s;
 output out;
 wire m,p,v;
 not u1(m,s);
 and u2(p,a,m); 
 and u3(v,b,s); 
 or u4(out,v,p);
endmodule


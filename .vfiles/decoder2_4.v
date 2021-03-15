`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2020 11:38:00 AM
// Design Name: 
// Module Name: decoder2_4
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


module decoder2_4(a,b,e,y0,y1,y2,y3);
 input a,b,e;
 output y0,y1,y2,y3;
 wire e1,a1,b1;
 not u1(e1,e);
 not u2(a1,a);
 not u3(b1,b);
 nand u4(y0,a1,b1,e1);
 nand u5(y1,a1,b,e1);
 nand u6(y2,a,b1,e1);
 nand u7(y3,a,b,e1);
endmodule

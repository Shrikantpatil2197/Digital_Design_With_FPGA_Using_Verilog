`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2020 08:37:51 PM
// Design Name: 
// Module Name: fulladder_tb
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
module fulladder_tb;
 reg pa, pb, pcin;
 wire psum, pcout;
// instantiate the fulladder module
 fulladder uut(pa, pb, pcin, psum, pcout); // positional association
 initial
  begin: blk_only_once
   reg [3:0] pa1;
   for (pa1=0; pa1 < 8; pa1 = pa1+1)
     begin
      {pa, pb, pcin} <= pa1;
      #50;
     end
   end
 endmodule

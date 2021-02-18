`timescale 1ns / 1ps

module decoder2_4_tb;
 reg pa, pb, pe;
 wire py0,py1,py2,py3;
// instantiate the fulladder module
 decoder2_4 uut(pa,pb,pe,py0,py1,py2,py3); // positional association
 initial
  begin: blk_only_once
   reg [3:0] pa1;
   for (pa1=0; pa1 < 4; pa1 = pa1+1)
     begin
      {pe, pa, pb} <= pa1;
      #50;
     end
   end
 endmodule
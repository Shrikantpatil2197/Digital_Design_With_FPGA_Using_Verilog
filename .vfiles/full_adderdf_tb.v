`timescale 1ns / 1ps

module full_adderdf_tb;
 reg pa, pb, pcin;
 wire psum,pcout;
// instantiate the fulladder module
 full_adderdf uut(pa, pb,pcin, psum, pcout); // positional association
 initial
  begin: blk_only_once
   reg [3:0] pa1;
   for (pa1=0; pa1 < 8; pa1 = pa1+1)
     begin
      {pcin,pa, pb} <= pa1;
      #50;
     end
   end
 endmodule
`timescale 1ns / 1ps

module muxdf4_1_tb;
 reg pi3, pi2, pi1, pi0, ps1, ps0;
 wire pout;
// instantiate the fulladder module
 muxdf4_1 uut(pi3, pi2, pi1, pi0, ps1, ps0, pout); // positional association
 initial
  begin: blk_only_once
   reg [2:0] pa0;
   for (pa0=0; pa0<4; pa0 = pa0+1)
     begin
      {ps1, ps0} <= pa0;
      #50;
     begin: blk_only_once
     reg [4:0] pa1;
     for (pa1=0; pa1 < 16; pa1 = pa1+1)
       begin
        {pi3, pi2, pi1, pi0} <= pa1;
        #50;
       end
     end
     end
   end
 endmodule




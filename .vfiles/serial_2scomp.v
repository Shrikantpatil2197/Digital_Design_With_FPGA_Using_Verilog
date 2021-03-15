`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2019 02:30:53 PM
// Design Name: 
// Module Name: serial_2scomp
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


module serial_2scomp(
    input xin, clk, reset_n,
    output yout
    );
    
parameter S0=3'b000, S1=3'b001, S2=3'b011, S3=3'b010, S4=3'b110, S5 =3'b111;
reg [2:0] M1_q, M1_d, M2_q, M2_d;
reg y1out, y2out;

assign yout = y2out;
always @(posedge clk or negedge reset_n)
begin
  if (reset_n==0) 
    begin  M1_q <= S0; M2_q <= S4; end
  else
    begin M1_q <= M1_d; M2_q <= M2_d; end
end

always @(M1_q)
begin
  M1_d = M1_q; y1out = 1'b0;
  case (M1_q)
    S0: M1_d = S1;
    S1: M1_d = S2;
    S2: M1_d = S3;
    S3: begin M1_d = S0; y1out = 1'b1; end
    default: M1_d = S0;
    endcase
end

always @(*)
begin
  M2_d = M2_q; y2out =1'b0;
  case (M2_q)
    S4: begin 
           y2out = xin;
           if ((xin==1'b1) && (y1out==1'b0)) M2_d = S5; else M2_d = S4;
        end
    S5: begin
           y2out = ~xin;
           if (y1out==1'b1) M2_d = S4; else M2_d = S5;
        end
    default: M2_d = S4;
  endcase
 end  
endmodule

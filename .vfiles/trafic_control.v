`timescale 1ns / 1ps

module trafic_control(
    input clk,cin,reset,
    output reg rh, gh, yh, rn, gn, yn 
    );
initial begin
rh= 0; gh=0; yh=0; rn=0; yn=0; gn=0;
end
reg [2:0]cur_state1=0, nxt_state1=0, cur_state2=5, nxt_state2=5;
parameter s0=0, s1=1, s2=2, s3=3,s4=4, s5=5;
reg [7:0]count=0;
reg st=0,ts=0,tlh=0,tlf=0;
reg y1=0,y2=1;

always@(posedge clk)begin
if (~reset)begin
cur_state1 <= nxt_state1;
cur_state2 <= nxt_state2;
end
else begin
 cur_state1 <= cur_state1;
 cur_state2 <= cur_state2;
 end
if (st)begin
    count <= count+1;
    if (count<100) ts <= 1;
    else if (count<200) begin
    tlh <=1;
    tlf <=1;
    end
    else st <=0;
    end
else begin
count <= 0;
end
end
    
always@(cur_state1,y2,cin)begin
case(cur_state1)
s0:begin
   rh = 1'b0;
   gh = 1'b1;
   yh = 1'b0;
if (cin==1)begin
    st = 1;
    if (tlh)begin
    nxt_state1 = s0;
    end 
    else begin
    st = 0;
    nxt_state1 = s1;
    end
end
end
s1:begin
   rh = 1'b0;
   gh = 1'b0;
   yh = 1'b1;
   st = 1;
   if (ts) begin
    nxt_state1 = s1;
   end
   else begin
   st=0;
   nxt_state1 = s2;
end
end
s2:begin
   rh = 1'b1;
   gh = 1'b0;
   yh = 1'b0;
   if (y2) begin
    nxt_state1 = s0;
   y2 = 0;
   end
   else begin
    nxt_state1 =s2;
      y1 = 1;
 end
 end
endcase
end

always@(cur_state2,y1)begin
case(cur_state2)
s3:begin
   rn = 1'b0;
   gn = 1'b1;
   yn = 1'b0;
   st=1;
   if (tlf)begin
    nxt_state2 = s3;
   end
   else begin
   st = 0;
   nxt_state2 = s4;
end
end
s4:begin
   rn = 1'b0;
   gn = 1'b0;
   yn = 1'b1;
   st=1;
   if (ts)begin
   nxt_state2 = s4;
   end
   else begin
   st = 0;
   nxt_state2=s5;
   end
end
s5:begin
   rn = 1'b1;
   gn = 1'b0;
   yn = 1'b0;
 
 if (y1) begin
    y1 = 0;
    nxt_state2 = s3;
 end
 else begin
    nxt_state2=s5;
      y2 = 1;
 end
 end
endcase
end 
endmodule

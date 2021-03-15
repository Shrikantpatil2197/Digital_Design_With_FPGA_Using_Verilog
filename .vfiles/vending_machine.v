`timescale 1ns / 1ps
module vending_machine(
    input clk, reset, ONE, TWO, FIVE,
    output reg water, change
    );
initial begin
water=0;
change=0;
end
reg [2:0]cur_state=0,nxt_state=0;
parameter s0=0, s1=1, s2=2, s3=3, s4=4, s5=5, s6=6;
always@(posedge clk)begin
if (reset)cur_state<= s0;
else cur_state <= nxt_state;
end
always@(*)begin
case(cur_state)
s0: begin
    if(FIVE)begin
    nxt_state = s1;
    end
    else if (TWO)begin
    nxt_state = s4;   
    end
    else begin
    nxt_state = s3;
    end
    change = 0;
    water = 0;
    end
s1:begin
    nxt_state = s2;
    change = 1;
    water = 0;
    end
s2:begin
   nxt_state = s0;
    change = 1;
    water = 1;
    end
s3:begin
    if(TWO)begin
    nxt_state = s5;
    end
    else begin
    nxt_state = s4;
    end 
    change = 0;
    water = 0;
    end   
s4:begin
    if(TWO)begin
    nxt_state = s6;
    end
    else begin
    nxt_state = s5;
    end 
    change = 0;
    water = 0;
    end  
s5: begin
    nxt_state = s0;
    change = 0;
    water = 1;
    end
s6: begin
   nxt_state = s0;
    change = 1;
    water = 1;
    end    
endcase
end
endmodule

`timescale 1ns / 1ps


module decade_counter(
    input counter_on,count_up,load,reset,clk,
    input [3:0]data_in,
    output reg [3:0]count,
    output reg[7:0] tc
    );
 initial begin
 count=4'b0000;
 tc=8'd0;
 end
always@(posedge clk,reset)
begin
 if(counter_on==0 || reset==1)
   count<=4'b0000;
 else begin
  case(count_up)
  //up counter
  1'b1:
  begin
   if(load)count<=data_in;
   else if(count==4'b1001) begin
   count<=4'b0000;
   tc<=tc+1;
   end
   else count<=count+1'b1; 
  end
  //down counter
  1'b0:
  begin
   if(load)count<=data_in;
   else if(count==4'b0000) begin
   count<=4'b1001;
   tc<=tc+1;
   end
   else count<=count-1'b1; 
   end
  endcase
  end
end 
endmodule

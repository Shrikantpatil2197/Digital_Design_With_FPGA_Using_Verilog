`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2019 04:12:37 PM
// Design Name: 
// Module Name: serial_2sC_tb
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


module serial_2sC_tb;
parameter t_PERIOD =100;
reg clk, reset_n, data, start;
wire pout;

integer data_file_in, data_file_out, scan_file; 

serial_2scomp uut(data, clk, reset_n, start, pout);

//clock generation

initial
 begin
    clk =0; reset_n =0; data =0; start =0;
    #150 reset_n = 1;
    #200 start = 1;
    
    data_file_in = $fopen("E:/academic/DDFPGA/DDFPGAlab/class_rtl/class_rtl.srcs/sim_1/new/input_sequence.txt", "r");
    data_file_out = $fopen("E:/academic/DDFPGA/DDFPGAlab/class_rtl/class_rtl.srcs/sim_1/new/output_file.txt","w");
//    $fmonitor(data_file_out,"clock=%b, data=%b, twosC=%b", clk, data, pout);
end

initial
    forever #(t_PERIOD/2) clk <= ~clk;

always @(posedge clk) begin
   if (start ==1)
   begin
	scan_file = $fscanf(data_file_in, "%b\n", data);
	#50
    if (!$feof(data_file_in))
		$fwrite	(data_file_out, "clock=%b, data=%b, twosC=%b\n", clk, data, pout);
	 else
	 begin
	  $fwrite	(data_file_out, "clock=%b, data=%b, twosC=%b\n", clk, data, pout);
	  $fclose(data_file_in);
	  $fclose(data_file_out);
	  $finish;	
	 end
	end
end


endmodule
`timescale 1ns / 1ps

module fulladder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
    );
    assign sum = a^b^cin;
    assign cout = (a&b)|(b&cin)|(a&cin);
endmodule

module four_ripple_adder(A,B,CIN,SUM,COUT);
input A[3:0],B[3:0],CIN;
output SUM[3:0],COUT;
wire c1,c2,c3;
fulladder f1(.sum(SUM[0]),.a(A[0]),.b(B[0]),.cin(CIN),.cout(c1));
fulladder f2(.sum(SUM[1]),.a(A[1]),.b(B[1]),.cin(c1),.cout(c2));
fulladder f3(.sum(SUM[2]),.a(A[2]),.b(B[2]),.cin(c2),.cout(c3));
fulladder f4(.sum(SUM[3]),.a(A[3]),.b(B[3]),.cin(c3),.cout(COUT));

endmodule

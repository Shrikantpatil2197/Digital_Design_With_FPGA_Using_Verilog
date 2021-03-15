`timescale 1ns / 1ps

module full_adder(a,b,cin,sum,cout);
    input a,b,cin;
    output sum,cout;
    wire m,p,v;
    xor u1(sum,a,b,cin);
    and u2(m,a,b);
    and u3(p,b,cin);
    and u4(v,a,cin);
    or u5(cout,m,p,v);
endmodule

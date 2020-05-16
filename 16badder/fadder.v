module fadder(
in1,
in2,
Cin,
Cout,
out
);
input in1, in2;
input Cin;
output Cout;
output out;
assign {Cout, out} = in1+in2+Cin;
endmodule
module four_adder (
in1,
in2,
Cin,
Cout,
out
);
input [3:0] in1, in2;
input Cin;
output Cout;
output [3:0] out;
assign {Cout, out} = in1 + in2 + Cin;
endmodule
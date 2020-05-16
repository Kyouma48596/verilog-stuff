module sixteen_adder(
in1,
in2,
Cin,
Cout,
out
);
input [15:0] in1, in2;
input Cin;
output Cout;
output [15:0] out;
wire [2:0] c;
four_adder A0 (in1[3:0], in2[3:0], Cin, c[0], out[3:0]);
four_adder A1 (in1[7:4], in2[7:4], c[0], c[1], out[7:4]);
four_adder A2 (in1[11:8], in2[11:8], c[1], c[2], out[11:8]);
four_adder A3 (in1[15:12], in2[15:12], c[2], Cout, out[15:12]);
// assign {Cout, out} = in1 + in2 + Cin; -> sucks so we use 4 bit adders instead
endmodule

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
wire [2:0] c;
// assign {Cout, out} = in1 + in2 + Cin; -> could still be better, lets use FAs
fadder FA0 (in1[0], in2[0], Cin, c[0], out[0]);
fadder FA1 (in1[1], in2[1], c[0], c[1], out[1]);
fadder FA2 (in1[2], in2[2], c[1], c[2], out[2]);
fadder FA3 (in1[3], in2[3], c[2], Cout, out[3]);
endmodule

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
wire w;
// assign {Cout, out} = in1+in2+Cin; -> algorthm is for pussies lets use gates
xor (w, in1, in2),
    (out, w, Cin);
assign Cout = ~^{Cin, in1, in2} || &{Cin, in1, in2};
endmodule
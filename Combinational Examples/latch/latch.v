module latch(
S,
R
Q,
nQ,
en
);
input S,R,en;
output Q,nQ;
wire [1:0] w;
// nand    (w[0], R, en),
//         (w[1], S, en),
//         (Q, w[0], nQ),
//         (nQ, Q, w[1]);
assign Q = ~(R&nQ);
assign nQ = ~(S&Q);
endmodule
module password(
in,
clk,
out
);
input in,clk;
output out;
wire [3:0] w;
wire [3:0] wbar;
assign wbar[0] = ~w[0];
assign wbar[1] = ~w[1];
assign wbar[2] = ~w[2];
assign wbar[3] = ~w[3];
dff d0 (in, w[0], wbar[0], clk);
dff d1 (w[0], w[1], wbar[1], clk);
dff d2 (w[1], w[2], wbar[2], clk);
dff d3 (w[2], w[3], wbar[3], clk);
assign out = &{w[0], wbar[1], wbar[2], w[3]};
endmodule

module dff(
D,
Q,
Qbar,
clk
);
input D, clk;
output Q, Qbar;
reg Q;
assign Qbar=~Q;
always @(negedge clk)
begin
    Q=D;
end
endmodule
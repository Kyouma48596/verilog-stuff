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
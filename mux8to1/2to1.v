module mux_2to1(
data,
ctrl,
out
);
input [1:0] data;
input ctrl;
output out;
assign out = data[ctrl];
endmodule
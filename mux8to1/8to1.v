module mux_8to1(
data,
ctrl,
out
);
input [7:0] data;
input [2:0] ctrl;
output out;
wire [0:3] s;
wire [0:1] t;
// assign out = data[ctrl];
// split it into 7 2:1 mux
mux_2to1 M0 (data[7:6], ctrl[0], s[0]);
mux_2to1 M2 (data[5:4], ctrl[0], s[1]);
mux_2to1 M3 (data[3:2], ctrl[0], s[2]);
mux_2to1 M4 (data[1:0], ctrl[0], s[3]);
mux_2to1 M5 (s[0:1], ctrl[1], t[0]);
mux_2to1 M6 (s[2:3], ctrl[1], t[1]);
mux_2to1 M7 (t[0:1], ctrl[2], out);
endmodule

module mux_2to1(
data,
ctrl,
out
);
input [1:0] data;
input ctrl;
output out;
wor out;
//gate definition of 2:1 mux
and (out, data[0], ~ctrl);
and (out, data[1], ctrl);
endmodule
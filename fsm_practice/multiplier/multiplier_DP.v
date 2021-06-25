`include "adder.v"
`include "counter.v"
`include "comparator.v"
`include "register.v"
module multiplier_DP
(
    input wire ldA, ldP, clrP, ldB, decB, clk,
    input wire [7:0] data_in,
    output wire eq
);

//signals
wire [7:0] bus;
wire [7:0] A_out, B_out, Z_out, P_out;
supply0 gnd;
assign bus = data_in;
//instantiations
counter #(.N(8)) B (.clk(clk), .reset(gnd), .load(ldB), .dec(decB), .data_in(bus), .count(B_out));
adder #(.N(8)) Z (.A(A_out), .B(P_out), .sum(Z_out));
register #(.N(8)) A (.clk(clk), .reset(gnd), .load(ldA), .clr(gnd), .data_in(bus), .out(A_out));
register #(.N(8)) P (.clk(clk), .reset(clrP), .load(ldP), .clr(gnd), .data_in(Z_out), .out(P_out));
comparator C (.A(B_out), .eq(eq));
endmodule
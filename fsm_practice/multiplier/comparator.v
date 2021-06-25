module comparator
#(parameter N = 8)
(
    input wire [N-1:0] A,
    output wire eq 
);

assign eq = (A=={N{1'b0}}) ? 1'b1 : 1'b0;

endmodule
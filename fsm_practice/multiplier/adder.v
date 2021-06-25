module adder
#(parameter N = 8)
(
    input wire [N-1:0] A,B,
    output wire [N-1:0] sum
);

assign sum = A + B;

endmodule
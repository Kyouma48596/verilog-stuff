`timescale 1 ns/10 ps
module edge_moore_test;
//signals
reg clk, reset, level;
wire ticc;

//instantiation
edge_moore uut(.clk(clk), .level(level), .reset(reset), .ticc(ticc));

//dumping
initial
    begin
        $dumpfile("edge_moore.vcd");
        $dumpvars(0,edge_moore_test);
        clk = 1'b0;
        level = 1'b0;
    end
//clock
always
    #5 clk = ~clk;

//inputs
initial
    begin
        @(negedge clk) reset = 1'b1;
        #1 reset = 1'b0;
        level = 1'b1;
        #5 level = 1'b0;
        repeat(5) @(negedge clk);
        #1 level = 1'b1;
        #1 level = 1'b0;
        #20 $finish;
    end
endmodule
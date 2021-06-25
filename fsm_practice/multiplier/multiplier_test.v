module multiplier_test;
//inout
reg start, clk, reset;
reg [7:0] data_in;
wire done;
//instantiation
multiplier_DP DP (.ldA(ldA), .ldP(ldP), .clrP(clrP), .ldB(ldB), .decB(decB), .clk(clk), .data_in(data_in), .eq(eq));

multiplier_CON CON (.ldA(ldA), .ldP(ldP), .clrP(clrP), .ldB(ldB), .decB(decB), .done(done), .data_in(data_in), .clk(clk), .eq(eq), .reset(reset), .start(start));

//dumping
initial
    begin
        $dumpfile("mult.vcd");
        $dumpvars(0,multiplier_test);
        clk = 1'b0;
        start = 1'b1;
        #200 $finish;
    end

//clock signal
always
    #5 clk = ~clk;
//input
initial
    begin
        reset = 1'b1;
        @(posedge clk) #1;
        reset = 1'b0;
        repeat(2) @(negedge clk);
        data_in = 8'd8;
        @(negedge clk) data_in = 8'd9;
    end

endmodule
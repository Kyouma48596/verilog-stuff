`timescale 1 ns/10 ps
module debouncer_test;
//inout
reg clk, level, m_tick, reset;
wire curr_level;

//instantiation
debouncer DB (.clk(clk), .level(level), .m_tick(m_tick), .reset(reset), .curr_level(curr_level));

//dumping
initial
    begin
        $dumpfile("debounce.vcd");
        $dumpvars(0,debouncer_test);
        clk = 1'b0;
        m_tick = 1'b0;
        level = 1'b0;
        reset = 1'b1;
    end
//clock signal
always 
    #5 clk = ~clk;
//tick
always
    begin
        m_tick = 1'b0;
        #4.5;
        m_tick = 1'b1;
        #1;
        m_tick = 1'b0;
        #4.5;
    end
//input
initial
    begin
        #1;
        reset = 1'b0;
        @(negedge clk);
        #50;
        level = 1'b1;
        #12; level = 1'b0;
        #15; level = 1'b1;
        #10; level = 1'b0;
        #19; level = 1'b1;
        #100;
        level = 1'b0;
        #100 $finish;
    end
endmodule
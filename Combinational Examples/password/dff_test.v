module dff_test();
reg D,clk;
wire Q,Qbar;
dff DUT (D,Q,Qbar,clk);
initial
    clk=0;
initial
    repeat (10)
    begin
        #5 clk=~clk;
    end
initial
    begin
        $dumpfile ("dff_test.vcd");
        $dumpvars (0, dff_test);
        $monitor ($time, " D = %b, Q = %b, Qbar = %b. clk = %b", D, Q, Qbar, clk);
        #5 D=0;
        #5 D=0;
        #5 D=0;
        #5 D=1;
        #5 D=1;
        #5 D=1;
        #5 D=0;
    end
endmodule
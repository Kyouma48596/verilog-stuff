module pwd_test();
reg in,clk;
wire out;
password DUT (in,clk,out);
initial
    clk=0;
initial
    repeat (50)
    begin
        #5 clk=~clk;
    end
initial
    begin
        $dumpfile ("pwd_test.vcd");
        $dumpvars (0, pwd_test);
        $monitor($time, " in = %b, out = %b, clk = %b", in, out,clk);
        #2;
        #10 in=0;
        #10 in=1;
        #10 in=0;
        #10 in=1;
        #10 in=0;
        #10 in=0;
        #10 in=1;
        #10 in=0;
        #10 in=0;
        #10 in=0;
        #10 in=1;
        #10 in=0;
        #10 in=0;
        #10 in=1; 
        #10 $finish;
    end
endmodule
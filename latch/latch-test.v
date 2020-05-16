module latch_test();
reg S,R,en;
wire Q,nQ;
latch DUT (S,R,Q,nQ,en);
initial
    begin
        $dumpfile ("latch_test.vcd");
        $dumpvars(0, latch_test);
        $monitor($time, " S = %b, R = %b, en = %b, Q = %b, nQ = %b", S,R,en,Q,nQ);
        #5 S=0;R=0;en=0;
        #5 S=0;R=1;en=0;
        #5 S=1;R=0;en=0;
        #5 S=1;R=1;en=0;
        #5 S=1;R=0;en=1;
        #5 S=0;R=0;en=0;
        #5 S=0;R=1;en=1;
        #5 S=0;R=0;en=1;
        #5 S=1;R=0;en=1;
        #5 S=0;R=0;en=1;
        #5 S=1;R=0;en=1;
        #5 $finish;
    end
endmodule
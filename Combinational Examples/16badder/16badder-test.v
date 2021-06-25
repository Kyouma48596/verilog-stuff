module sixteen_test();
reg [15:0] in1, in2;
reg Cin;
wire Cout;
wire [15:0] out;
sixteen_adder DUT (in1, in2, Cin, Cout, out);
initial
    begin
        $dumpfile ("16badder.vcd");
        $dumpvars (0, sixteen_test);
        $monitor ($time, " in1 = %b, in2 = %b, Cin = %b, Cout = %b, out = %b",in1, in2, Cin, Cout, out);
        #5 in1 = 16'b0000000000000000; in2 = 16'b1111111111111111; Cin = 0;
        #5 in1 = 16'b0000000000000001; in2 = 16'b1111111111111111; Cin = 0;
        #5 in1 = 16'b1000100001000100; in2 = 16'b0110001010000000; Cin = 1;
    end
endmodule
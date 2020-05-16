module testerino();
reg [31:0] in1,in2;
reg Cin;
wire Cout;
wire [31:0] out;
reg seed;
adder A0 (in1,in2,Cin,Cout,out);
initial
    begin
        $dumpfile("adder.vcd");
        $dumpvars(0,testerino);
        $monitor($time, " in1 = %32b, in2 = %32b, Cin = %b, out = %32b, Cout = %b", in1, in2, Cin, out, Cout);
        repeat (10)
        begin
            #5 in1 = $random; in2 = $random; Cin = $random;
        end
        #55 $finish;
    end
endmodule
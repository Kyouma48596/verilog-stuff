module test();
reg [15:0] data_in;
wire done;
reg clk;
controller CP(
done,
loadA,
loadB,
sel1,
sel2,
sel_in,
G,
E,
L,
clk,
start
);
datapath DP(
data_in,
loadA,
loadB,
sel1,
sel2,
sel_in,
G,
E,
L,
clk
);
assign start = 1;
initial 
    begin
        $dumpfile("GCD.vcd");
        $dumpvars(0, test);
        $monitor($time, " A = %16b, B = %16b, done = %b", DP.Aout, DP.Bout, CP.done);
        clk=1'b0;
        forever
            begin
                #5 clk=~clk;
            end
    end
initial
    begin
        #2 data_in = 6;
        #10 data_in = 4;
        #100 $finish;
    end

endmodule
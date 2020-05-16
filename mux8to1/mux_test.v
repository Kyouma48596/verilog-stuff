module mux_test();
reg [7:0] data;
wire [4:0] r;
assign r = {data[1:0], data[3:2]};
reg [2:0] ctrl;
wire out;
mux_8to1 M0 (data, ctrl, out);
initial
    begin
        $dumpfile ("mux_test.vcd");
        $dumpvars (0, mux_test);
        data = 10011101;
        $monitor ($time, "data = %b, ctrl = %b, out = %b", data, ctrl, out);
        #5 ctrl = 0;
        #5 ctrl = 1;
        #5 ctrl = 2;
        #5 ctrl = 3;
        #5 ctrl = 4;
        #5 ctrl = 5;
        #5 ctrl = 6;
        #5 ctrl = 7;
        $finish;
    end
endmodule
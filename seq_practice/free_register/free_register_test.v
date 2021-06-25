module free_register_test;
//signal declarations
reg clk, reset;
reg serial_in;
wire serial_out;

//instantiation
free_register #(.N(8)) uut(.clk(clk), .reset(reset), .serial_in(serial_in), .serial_out(serial_out));

//dumping
initial
    begin
        $dumpfile("free_register.vcd");
        $dumpvars(0,free_register_test);
        clk = 0;
    end

//clock signal
always
    #5 clk = ~clk;

//inputs
initial
    begin
        @(negedge clk) reset = 1'b1;
        #1 reset = 1'b0;
        serial_in = 1'b1;
        #5;
        @(negedge clk);
        #1;
        serial_in = 1'b0;
        #5;
        @(negedge clk);
        #1;
        serial_in = 1'b0;
        #5;
        @(negedge clk);
        #1;
        serial_in = 1'b1;
        #5;
        @(negedge clk);
        #1;
        serial_in = 1'b0;
        #5;
        @(negedge clk);
        #1;
        serial_in = 1'b1;
        #5;
        #10 $finish;
    end


endmodule
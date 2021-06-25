module uni_counter_test;
//signals
reg clk, reset, syn_clr;
reg [1:0] ctrl;
reg [7:0] data_in;
wire [7:0] count;
localparam COUNT_UP = 2'b00, COUNT_DOWN = 2'b01, PAUSE = 2'b10, LOAD = 2'b11;

//instantiation
uni_counter #(.N(8)) uut (.clk(clk), .reset(reset), .syn_clr(syn_clr), .ctrl(ctrl), .data_in(data_in), .count(count));

//dumping
initial
    begin
        $dumpfile("unicount.vcd");
        $dumpvars(0,uni_counter_test);
        clk = 1'b0;
    end

//clock signal
always  
    #5 clk = ~clk;

//inputs
initial
    begin
        @(negedge clk) reset = 1'b1;
        #1 reset = 1'b0;
        ctrl = COUNT_UP;
        @(negedge clk) #1;
        ctrl = COUNT_UP;
        @(negedge clk) #1;
        ctrl = COUNT_UP;
        @(negedge clk) #1;
        syn_clr = 1'b1;
        @(negedge clk) #1;
        syn_clr = 1'b0;
        ctrl = LOAD;
        data_in = 8'hAA;
        @(negedge clk) #1;
        ctrl = COUNT_DOWN;
        @(negedge clk) #1;
        ctrl = COUNT_DOWN;
        @(negedge clk) #1;
        ctrl = COUNT_DOWN;
        @(negedge clk) #1;
        ctrl = PAUSE;
        #15 $finish;
    end

endmodule
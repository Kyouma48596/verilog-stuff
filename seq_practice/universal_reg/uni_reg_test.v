module uni_reg_test;
//signal decs
reg clk, reset, s_in;
reg [7:0] p_in;
reg [1:0] data_ctrl;
wire [7:0] p_out;
wire s_out;
localparam DO_NOTHING = 2'b00, SHIFT_LEFT = 2'b01, SHIFT_RIGHT = 2'b10, PARALLEL_LOAD = 2'b11;
//instantiation
uni_reg #(.N(8)) uut (.clk(clk), .reset(reset), .data_ctrl(data_ctrl), .p_in(p_in), .s_in(s_in), .p_out(p_out), .s_out(s_out));

//dumping
initial
    begin
        $dumpfile("unireg.vcd");
        $dumpvars(0,uni_reg_test);
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
        data_ctrl = PARALLEL_LOAD;
        p_in = 8'hAB;
        @(negedge clk) #1;
        data_ctrl = SHIFT_RIGHT;
        s_in = 1'b0;
        @(negedge clk) #1;
        data_ctrl = SHIFT_LEFT;
        s_in = 1'b1;
        @(negedge clk) #1;
        data_ctrl = DO_NOTHING;
        @(negedge clk) #1;
        data_ctrl = PARALLEL_LOAD;
        p_in = 8'hCD;
        @(negedge clk) #1;
        data_ctrl = SHIFT_RIGHT;
        s_in = 1'b0;
        @(negedge clk) #1;
        data_ctrl = SHIFT_RIGHT;
        s_in = 1'b1;
        @(negedge clk) #1;
        data_ctrl = SHIFT_RIGHT;
        s_in = 1'b0;
        #15 $finish;
    end

endmodule
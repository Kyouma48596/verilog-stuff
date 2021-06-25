/* desc: A universal binary counter is more versatile. It can count up
or down, pause, be loaded with a specific value, or be synchronously cleared. */
module uni_counter
#(parameter N = 8)
(
    input wire clk, reset, syn_clr,
    input wire [1:0] ctrl,
    input wire [N-1:0] data_in,
    output wire [N-1:0] count
);
//params
localparam COUNT_UP = 2'b00, COUNT_DOWN = 2'b01, PAUSE = 2'b10, LOAD = 2'b11;
//signals
reg [N-1:0] r_contents;
wire [N-1:0] r_next;

//register
always @(posedge clk or posedge reset)
    begin
        if(reset) r_contents = {N{1'b0}};
        else if(syn_clr) r_contents = {N{1'b0}};
        else r_contents = r_next;
    end

//next state logic
assign r_next = (ctrl==COUNT_UP) ? r_contents + 1 :
                (ctrl==COUNT_DOWN) ? r_contents - 1 :
                (ctrl==LOAD) ? data_in :
                (ctrl==PAUSE) ? r_contents :
                r_contents;

//output logic
assign count = r_contents;

endmodule
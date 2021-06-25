module register
#(parameter N = 8)
(
    input wire clk, reset, load, clr,
    input wire [N-1:0] data_in,
    output wire [N-1:0] out
);

//signals
reg [N-1:0] r_contents;
wire [N-1:0] r_next;

//state reg
always @(posedge clk or posedge reset)
    begin
        if(reset) r_contents = 0;
        else r_contents = r_next;
    end

//next state logic
assign r_next = (load==1'b1) ? data_in :
                (clr==1'b1) ? 0 :
                r_contents;

//output logic
assign out = r_contents;

endmodule
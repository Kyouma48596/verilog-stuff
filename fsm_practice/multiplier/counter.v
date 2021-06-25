module counter
#(parameter N = 8)
(
    input wire clk, reset, load, dec,
    input wire [N-1:0] data_in,
    output wire [N-1:0] count
);

//signals
reg [N-1:0] r_contents;
wire [N-1:0] r_next;

//state reg
always @(posedge clk or posedge reset)
    begin
        if(reset) r_contents <= 0;
        else r_contents <= r_next;
    end

//next state logic
assign r_next = (load==1'b1) ? data_in :
                (dec==1'b1) ? r_contents - 1 :
                r_contents;

//output logic
assign count = r_contents;

endmodule
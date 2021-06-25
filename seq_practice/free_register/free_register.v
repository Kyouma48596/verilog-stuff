module free_register
#(parameter N = 8)
(
    input wire clk, reset,
    input wire serial_in,
    output wire serial_out
);

//signals
reg [N-1:0] r_contents;
wire [N-1:0] r_next;

//body
//sequential part
always @(posedge clk or posedge reset)
    begin
        if(reset)
            r_contents = 8'b0000_0000;
        else
            r_contents = r_next;
    end

//next state logic
assign r_next = {serial_in, r_contents[N-1:1]};

//output logic
assign serial_out = r_contents[0];

endmodule

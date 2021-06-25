/* design desc:  A universal shift register can load parallel data, shift its content
left or right, or remain in the same state. It can perform parallel-to-serial operation (first
loading parallel input and then shifting) or serial-to-parallel operation (first shifting and
then retrieving parallel output).*/
module uni_reg
#(parameter N = 8)
(
    input wire clk, reset,
    input wire [1:0] data_ctrl,
    input wire [N-1:0] p_in,
    input wire s_in,
    output wire [N-1:0] p_out,
    output wire s_out
);
//params
localparam DO_NOTHING = 2'b00, SHIFT_LEFT = 2'b01, SHIFT_RIGHT = 2'b10, PARALLEL_LOAD = 2'b11;
//signals
reg [N-1:0] r_contents;
wire [N-1:0] r_next;

//register
always @(posedge clk or posedge reset)
    begin
        if(reset) r_contents <= 8'b0000_0000;
        else r_contents <= r_next;
    end

//next state logic
assign r_next = (data_ctrl==DO_NOTHING) ? r_contents : 
                (data_ctrl==SHIFT_RIGHT) ? {s_in, r_contents[N-1:1]} :
                (data_ctrl==SHIFT_LEFT) ? {r_contents[N-2:0], s_in} : 
                (data_ctrl==PARALLEL_LOAD) ? p_in :
                r_contents;

//output logic
assign p_out = r_contents;
assign s_out = r_contents[0];

endmodule
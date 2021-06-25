module edge_moore
(
    input wire clk, reset, level,
    output reg ticc
);
//params
localparam ZERO = 2'b00, EDGE = 2'b01, ONE = 2'b10;

//signal decl
reg [1:0] r_contents, r_next;

//state reg
always @(posedge clk or posedge reset)
    begin
        if(reset) r_contents <= 0;
        else r_contents <= r_next;
    end

//next state and output logic
always @(*)
        case(r_contents)
        ZERO :
            begin
                ticc = 1'b0;
                if(level)
                    r_next = EDGE;
                else 
                    r_next = ZERO;
            end
        EDGE :
            begin
                r_next = ONE;
                ticc = 1'b1;
            end
        ONE :
            begin
                ticc = 1'b0;
                if(level)
                    r_next = ONE;
                else 
                    r_next = ZERO;
            end
        default : r_next = r_contents;
        endcase

endmodule
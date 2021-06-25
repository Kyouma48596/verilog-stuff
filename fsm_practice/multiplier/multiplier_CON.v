module multiplier_CON
(
    output reg ldA, ldP, clrP, ldB, decB, done,
    input wire [7:0] data_in,
    input wire clk, eq, reset, start
);
//instantiation

//params
parameter S0 = 3'd0, S1 = 3'd1, S2 = 3'd2, S3 = 3'd3, S4 = 3'd4;
//signals
reg [7:0] r_state;
wire [7:0] r_next;
//state reg
always @(posedge clk or posedge reset)
    begin
        if(reset) r_state = 0;
        else r_state = r_next;
    end
//next state logic
assign r_next = (r_state==S0 && start) ? S1 :
                (r_state==S0 && ~start) ? S0 :
                (r_state==S1) ? S2 :
                (r_state==S2) ? S3 :
                (r_state==S3 && eq) ? S4 :
                (r_state==S3 && ~eq) ? S3 :
                (r_state==S4) ? S4 :
                S0;
//output logic
always @(*)
    begin
        ldA = 1'b0;
        ldP = 1'b0;
        clrP = 1'b0;
        ldB = 1'b0;
        decB = 1'b0;
        done = 1'b0;
        case(r_state)
        S0 :
            begin
                #1;
                done = 1'b0;    
            end
        S1 : 
            begin
                #1;
                ldA = 1'b1;
                clrP = 1'b1;
            end
        S2 :
            begin
                #1;
                ldB = 1'b1;
            end
        S3 :
            begin
                #1;
                ldP = 1;
                decB = 1;
            end
        S4 :
            begin
                #1;
                done = 1'b1;
            end
        default : 
            begin
                #1;
                done = 1'b0;
            end
        endcase
    end
endmodule
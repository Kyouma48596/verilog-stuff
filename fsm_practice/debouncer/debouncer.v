module debouncer
(
    input wire clk, level, m_tick, reset,
    output wire curr_level
);
//params
parameter ZERO = 3'd0, WAIT0_1 = 3'd1, WAIT0_2 = 3'd2, WAIT0_3 = 3'd3, ONE = 3'd4, WAIT1_1 = 3'd5, WAIT1_2 = 3'd6, WAIT1_3 = 3'd7;
//signals
reg [2:0] r_state, r_next;
//state reg
always @(posedge clk or posedge reset)
    begin
        if(reset) r_state = 3'd0;
        else r_state = r_next;
    end
//next state logic
always @(*)
    begin
        r_next = r_state; //default state
        case(r_state)
        ZERO :
            begin
                if(level) r_next = WAIT0_1;
            end
        WAIT0_1 :
            begin
                if(level && m_tick) r_next = WAIT0_2;
            end
        WAIT0_2 :
            begin
                if(level && m_tick) r_next = WAIT0_3;
            end
        WAIT0_3 :
            begin
                if(level && m_tick) r_next = ONE;
            end
        ONE :
            begin
                if(~level) r_next = WAIT1_1;
            end
        WAIT1_1 :
            begin
                if(~level && m_tick) r_next = WAIT1_2;
            end
        WAIT1_2 :
            begin
                if(~level && m_tick) r_next = WAIT1_3;
            end
        WAIT1_3 :
            begin
                if(~level && m_tick) r_next = ZERO;
            end
        endcase
    end
//output logic
assign curr_level = (r_state==ZERO | r_state==WAIT0_1 | r_state==WAIT0_2 | r_state==WAIT0_3) ? 1'b0 : 1'b1;

endmodule
module UART_reciever
#(parameter D_BIT = 8'd8, S_BIT = 8'd1)
(
    input wire rx, clk, baud_sample_tick, reset,
    output [D_BIT-1:0] d_out,
    output wire rx_done
);
//params
localparam IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;
//signals
reg [3:0] s_count, s_count_next;
reg [D_BIT:0] b, b_next;
reg [3:0] n, n_next;
reg [1:0] state_reg, state_next;
reg done;

//registers
always @(posedge clk or posedge reset)
    begin
        if(reset)
            begin
                state_reg <= 0;
                s_count <= 0;
                b <= 0;
                n <= 0;
            end
        else 
            begin
                state_reg <= state_next;
                s_count <= s_count_next;
                n <= n_next;
                b <= b_next;
            end
    end
//next state logic
always @(*)
    begin
        state_next = state_reg;
        b_next = b;
        n_next = n;
        s_count_next = s_count;
        done = 0;
        case (state_reg)
        IDLE :
            begin
                if(rx==0)
                    begin
                        state_next = START;
                        s_count_next = 0;
                    end
            end
        START :
            begin
                if(baud_sample_tick)
                    begin
                        if(s_count==4'd7)
                            begin
                                s_count_next = 0;
                                n_next = 0;
                                state_next = DATA;
                            end
                        else 
                            begin
                                s_count_next = s_count + 1;
                            end
                    end
            end
        DATA :
            begin
                if(baud_sample_tick)
                    begin
                        if(s_count==4'd15)
                            begin
                                n_next = n + 1;
                                s_count_next = 0;
                                b_next = {rx, b[7:1]};
                                if(n_next==D_BIT)
                                    begin
                                        state_next = STOP;
                                        n_next = 0;
                                        s_count_next = 0;
                                    end
                                else
                                    begin
                                        state_next = DATA;
                                    end
                            end
                        else 
                            begin
                                s_count_next = s_count + 1;
                            end
                    end
            end
        STOP :
            begin
                if(baud_sample_tick)
                    begin
                        if(s_count==S_BIT-1)
                            begin
                                state_next = IDLE;
                                done = 1;
                                s_count_next = 0;
                                b_next = 0;
                                n_next = 0;
                            end
                        else 
                            begin
                                s_count_next = s_count + 1;
                            end
                    end

            end
        default :
            begin
                state_next = IDLE;
                b_next = 0;
                s_count_next = 0;
                n_next = 0;
                done = 0;
            end
        endcase
    end

//output
assign rx_done = done;
assign d_out = b;

endmodule
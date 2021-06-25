module UART_transmitter
#(parameter D_BIT = 8'd8, S_BIT = 8'd1)
(
    input wire d_in, clk, baud_tick, reset, start,
    output wire tx
);
//params
localparam IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;
//signals
reg [D_BIT-1:0] data, data_next;
reg [1:0] state_reg, state_next;
reg [3:0] n, n_next;
reg tx_reg, tx_next;
//registers
always @(posedge clk or posedge reset)
    begin
        if(reset)
            begin
                state_reg <= 0;
                n <= 0;
                data_next <= 0;
                tx_reg <= 1;
            end
        else
            begin
                state_reg <= state_next;
                n <= n_next;
                data <= data_next;
                tx_reg <= tx_next;
            end
    end
//next state logic
always @(*)
    begin
        state_next = state_reg;
        n_next = n;
        tx_next = 1;
        data_next = data;
        case(state_reg)
        IDLE :
            begin
                if(start)
                    begin
                        state_next = start;
                        n_next = 0;
                    end
            end
        START :
            begin
                if(baud_tick && tx_reg)
                    begin
                        tx_next = 0;
                        state_next = START;
                        data_next = d_in;
                    end
                else if (baud_tick && ~tx_reg)
                    begin
                        state_next = DATA;
                        n_next = 0;
                    end
            end
        DATA :
            begin
                if(baud_tick)
                    begin
                        n_next = n + 1;
                        tx_next = data[0];
                        data_next = data >> 1;
                        if(n_next==D_BIT)
                            begin
                                state_next = STOP;
                                n_next = 0;
                            end
                        else
                            begin
                                state_next = DATA;
                            end
                    end
            end
        STOP :
            begin
                if(baud_tick)
                    begin
                        tx_next = 1;
                        n_next = n + 1;
                        if(n_next==S_BIT)
                            begin
                                n_next = 0;
                                state_next = IDLE;
                            end
                        else
                            state_next = STOP;
                    end
            end
        default :
            begin
                state_next = state_reg;
                n_next = n;
                tx_next = 1;
                data_next = data;
            end
        endcase
    end
endmodule
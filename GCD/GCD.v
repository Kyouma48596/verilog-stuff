module datapath(
data_in,
loadA,
loadB,
sel1,
sel2,
sel_in,
G,
E,
L,
clk
);
input [15:0] data_in;
input loadA, loadB, sel1, sel2, sel_in, clk;
output G,E,L;
wire [15:0] wbus, Aout, Bout, MUXL_out, MUXR_out;
wire[15:0] Subout;
wire[15:0] SubA;
wire[15:0] SubB;

// controller CP (.done(done), .loadA(loadA), .loadB(loadB), .sel1(sel1), .sel2(sel2), .sel_in(sel_in), .G(G), .L(L), .E(E), .clk(clk));

pipo PIPOA(.in(wbus), .out(Aout), .load(loadA), .clk(clk));
pipo PIPOB(.in(wbus), .out(Bout), .load(loadB), .clk(clk));
compare COMP(.in1(Aout), .in2(Bout), .G(G), .E(E), .L(L));
MUX MUXL(.in1(Aout), .in2(Bout), .ctrl(sel1), .out(SubA));
MUX MUXR(.in1(Aout), .in2(Bout), .ctrl(sel2), .out(SubB));
subtractor SUB(.in1(SubA), .in2(SubB), .out(Subout));
MUX MUX_in(.in1(Subout), .in2(data_in), .ctrl(sel_in), .out(wbus));

endmodule

module controller(
done,
loadA,
loadB,
sel1,
sel2,
sel_in,
G,
E,
L,
clk,
start
);
input G,E,L, clk, start;
output reg done, sel1, sel2, sel_in, loadA, loadB;
reg[2:0] next_state;
reg[2:0] present_state = S0;

parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101;
always @(posedge clk)
    present_state <= next_state;
always @(present_state)
    begin
       case (present_state)
    S0: begin
        #1;
        done = 0;
        sel_in = 1;
        loadA = 1;
        loadB = 0;
        if(start) next_state = S1;
    end
    S1: begin
        #1;
        done = 0;
        sel_in = 1;
        loadA = 0;
        loadB = 1;        
        next_state = S2;
    end
    S2: begin
        #1;
        if(G) begin
            sel_in = 0;
            sel1 = 0;
            sel2 = 1;
            #1;
            loadA = 1;
            loadB = 0;
            // #1;
            done = 0;
            next_state = S3;
        end
         if(L) begin
            sel_in = 0;
            sel1 = 1;
            sel2 = 0;
            #1;
            loadA = 0;
            loadB = 1;
            // #1;
            done = 0;
            next_state = S4;
        end
         if (E) begin
            // sel_in = 0;
            // sel1 = 0;
            // sel2 = 0;
            // #1;
            // loadA = 0;
            // loadB = 0;
            // #1;
            // done = 1;
            next_state = S5;            
        end 
    end
    S3: begin
        #1;
        if(G) begin
            sel_in = 0;
            sel1 = 0;
            sel2 = 1;
            #1;
            loadA = 1;
            loadB = 0;
            // #1;
            done = 0;
            next_state = S3;
        end
         if(L) begin
            sel_in = 0;
            sel1 = 1;
            sel2 = 0;
            #1;
            loadA = 0;
            loadB = 1;
            // #1;
            done = 0;
            next_state = S4;
        end
         if (E) begin
            // sel_in = 0;
            // sel1 = 0;
            // sel2 = 0;
            // #1;
            // loadA = 0;
            // loadB = 0;
            // #1;
            // done = 1;
            next_state = S5;            
        end   
    end
    S4: begin
        #1;
        if(G) begin
            sel_in = 0;
            sel1 = 0;
            sel2 = 1;
            #1;
            loadA = 1;
            loadB = 0;
            // #1;
            done = 0;
            next_state = S3;
        end
         if(L) begin
            sel_in = 0;
            sel1 = 1;
            sel2 = 0;
            #1;
            loadA = 0;
            loadB = 1;
            // #1;
            done = 0;
            next_state = S4;
        end
         if (E) begin
            sel_in = 0;
            sel1 = 0;
            sel2 = 0;
            // #1;
            // loadA = 0;
            // loadB = 0;
            // #1;
            // done = 1;
            next_state = S5;            
        end    
    end
    S5: begin
        // #1;
        done = 1;
        sel_in = 0;
        sel1 = 0;
        sel2 = 0;
        loadA = 0;
        loadB = 0;
        next_state = S5;
    end
    default: begin
        // sel_in = 0;
        // sel1 = 0;
        // sel2 = 0;
        loadA = 0;
        loadB = 0;
        // done = 0;   
        next_state = S0;     
    end
    endcase 
    end
endmodule
module pipo(
in,
out,
load,
clk
);
input [15:0] in;
input clk, load;
output reg [15:0] out;
always @(posedge clk)
begin
    if(load)
        begin
            out <= in;
        end
end
endmodule

module MUX(
in1,
in2,
ctrl,
out
);
input [15:0] in1,in2;
input ctrl;
output [15:0] out;
assign out = (ctrl)?in2:in1;
endmodule

module subtractor(
in1,
in2,
out
);
input [15:0] in1, in2;
output reg [15:0] out;
always @(in1,in2)
    out = in1 - in2;
endmodule

module compare(
in1,
in2,
G,
E,
L
);
input [15:0] in1,in2;
output G,E,L;
assign G = in1>in2?1:0;
assign E = in1==in2;
assign L = in1<in2?1:0;
endmodule
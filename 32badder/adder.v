module adder (in1,in2,Cin,Cout,out);
input [n-1:0] in1, in2;
input Cin;
output Cout;
output [n-1:0] out;
parameter n = 32;
wire carries[n:0];
assign Cout = carries[n-1];
assign carries[0] = Cin;
genvar i;
generate for (i=0;i<n;i=i+1)
begin 
    assign out[i] = in1[i]^in2[i]^carries[i];
    assign carries[i+1] = (in1[i]&in2[i])+(in1[i]&carries[i])+(in2[i]&carries[i]);
end
endgenerate
endmodule
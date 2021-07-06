module JoggleRemove(input key,input clk,output reg key_p);
reg[2:0]ST;
parameter S0=3'b000,S1=3'b001,S2=3'b010,S3=3'b011,S4=3'b100,S5=3'b101;
initial begin
key_p<=0;
ST<=S0;
end
always@(posedge clk )
begin
case(ST)
S0:begin  ST<=key?S1:S0; key_p<=0;end
S1:begin  ST<=key?S3:S2; key_p<=key;end
S2:begin  ST<=key?S1:S0; key_p<=0;end
S3:begin  ST<=key?S3:S4; key_p<=1;end
S4:begin  ST<=key?S5:S0; key_p<=key;end
S5:begin  ST<=key?S3:S4; key_p<=1;end
default:begin ST<=key?S3:S0;key_p<=0;end
endcase
end
endmodule

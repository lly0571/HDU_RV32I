module RegPC(input clk,input rst_n,input write,input [1:0]PC_S,
input [31:0]imm32,input[31:0]F,input[31:0]PC0,
output reg[31:0]PC);

    always @(negedge rst_n or posedge clk) begin
        if(!rst_n)
        PC<=0;
        else if(write==1)
        case (PC_S)
            2'b00: PC<=PC+4;
            2'b01: PC<=imm32+PC0;
            2'b10: PC<=F;
        endcase
        
        else;
    end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/01 22:39:54
// Design Name: 
// Module Name: concatenate
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module concatenate(input[5:0]I_fmt,input[31:0]inst,input [2:0]funct3,
output reg[31:0]imm32);
always @(*) begin
    case (I_fmt)
    6'b100000: imm32=0;
    6'b010000: begin
    if(funct3==3'b101||funct3==3'b001) imm32={{27{1'b0}},inst[24:20]};
    else imm32={{20{inst[31]}},inst[31:20]};
    end
    6'b001000: imm32={{20{inst[31]}},inst[31:25],inst[11:7]};
    6'b000100: imm32={{20{inst[31]}},inst[7],inst[30:25],inst[11:8],1'b0};
    6'b000010: imm32={inst[31:12],12'b0};
    6'b000001: imm32={{12{inst[31]}},inst[19:12],inst[20],inst[30:21],1'b0};
    default: ;
endcase
end

endmodule

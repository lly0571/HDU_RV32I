`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/11 14:06:31
// Design Name: 
// Module Name: ID2
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


module ID2(input [6:0]opcode,input [6:0]funct7,input [2:0]funct3,output reg IS_R,
output reg IS_IMM,output reg IS_LUI,output reg IS_LW,output reg IS_SW,
output reg IS_BEQ,output reg IS_JAL,output reg IS_JALR,output reg[3:0]ALU_OP);
initial begin
    IS_R=0;IS_IMM=0;IS_LUI=0;IS_SW=0;IS_LW=0;IS_BEQ=0;IS_JAL=0;IS_JALR=0;ALU_OP=4'b0000;
end
always @(*) begin
    case (opcode)
//R
    7'b0110011:begin ALU_OP={funct7[5],funct3};IS_R=1;IS_IMM=0;IS_LUI=0;IS_SW=0;IS_LW=0;IS_BEQ=0;IS_JAL=0;IS_JALR=0;end
//I
    7'b0010011 : begin ALU_OP=(funct3==3'b101)?{funct7[5],funct3}:{1'b0,funct3};IS_IMM=1;
    IS_R=0;IS_LUI=0;IS_SW=0;IS_LW=0;IS_BEQ=0;IS_JAL=0;IS_JALR=0;end
//lui
    7'b0110111: begin ALU_OP=4'b0000;IS_LUI=1;IS_R=0;IS_IMM=0;IS_SW=0;IS_LW=0;IS_BEQ=0;IS_JAL=0;IS_JALR=0;end
//LW
    7'b0000011: begin ALU_OP=4'b0000;IS_LW=1;IS_R=0;IS_IMM=0;IS_LUI=0;IS_SW=0;IS_BEQ=0;IS_JAL=0;IS_JALR=0; end
//SW
    7'b0100011: begin ALU_OP=4'b0000;IS_SW=1;IS_R=0;IS_IMM=0;IS_LUI=0;IS_LW=0;IS_BEQ=0;IS_JAL=0;IS_JALR=0; end
//BEQ
    7'b1100011: begin ALU_OP=4'b0000;IS_BEQ=1;IS_R=0;IS_IMM=0;IS_LUI=0;IS_SW=0;IS_LW=0;IS_JAL=0;IS_JALR=0; end
//JAL
    7'b1101111: begin ALU_OP=4'b0000;IS_JAL=1;IS_R=0;IS_IMM=0;IS_LUI=0;IS_SW=0;IS_LW=0;IS_BEQ=0;IS_JALR=0; end
//JALR
    7'b1100111: begin ALU_OP=4'b0000;IS_JALR=1;IS_R=0;IS_IMM=0;IS_LUI=0;IS_SW=0;IS_LW=0;IS_BEQ=0;IS_JAL=0; end
endcase
end

endmodule

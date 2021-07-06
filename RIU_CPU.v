`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/16 11:10:27
// Design Name: 
// Module Name: RIU_CPU
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



module RIU_CPU(input clk,input rst_n,input[2:0]mode,output reg[31:0]out,output [3:0]FR
    );
    //,input clk_100M,output [7:0] AN,output [7:0] seg
    wire[31:0]PC,inst,A,B,F,imm32,R_Data_A,R_Data_B;
    wire [31:0]B_Data,M_R_Data,R_Data;
    reg [31:0]W_Data;
    //reg[31:0]out;
    wire PC_Write,IR_Write,Reg_Write,Mem_Write,PC0_Write;
    wire[4:0] rs1,rs2,rd;
    wire[6:0] opcode,funct7;
    wire[2:0]funct3;wire[5:0] I_fmt;
    wire IS_R,IS_IMM,IS_LUI,IS_LW,IS_SW,IS_JAL,IS_JALR,IS_BEQ;
    wire rs2_imm_s;
    wire[1:0]w_data_s,PC_s;
    wire[3:0]ALU_OP,ALU_OP_o;
    
    ID2 tran2(opcode,funct7,funct3,IS_R,IS_IMM,IS_LUI,IS_LW,IS_SW,IS_BEQ,IS_JAL,IS_JALR,ALU_OP);
    Test1 IM(PC_Write,IR_Write,clk,rst_n,PC0_Write,PC_s,imm32,F,inst,PC);    
    trans Trans(inst,rs1,rs2,rd,opcode,funct3,funct7,I_fmt);
    concatenate Con(I_fmt,inst,funct3,imm32);
    

    
    CU Control(clk,rst_n,IS_R,IS_IMM,IS_LUI,IS_LW,IS_SW,IS_JAL,IS_JALR,IS_BEQ,
    ALU_OP,FR,PC_Write,PC0_Write,IR_Write,Reg_Write,Mem_Write,
    rs2_imm_s,w_data_s,PC_s,ALU_OP_o);
    
    Register Regi(rs1,rs2,rd,Reg_Write,rst_n,~clk,W_Data,R_Data_A,R_Data_B);

    store32 SA(R_Data_A,~clk,rst_n,A);
    store32 SB(R_Data_B,~clk,rst_n,B);
    
    ALU Alu(A,B_Data,ALU_OP_o,F,FR);
    assign B_Data=(rs2_imm_s)?imm32:B;
    //assign W_Data=(w_data_s)?imm32:F;
    RAM_DM DM (
  .clka(clk),    // input wire clka
  .wea(Mem_Write),      // input wire [0 : 0] wea
  .addra(F[7:2]),  // input wire [5 : 0] addra
  .dina(B),    // input wire [31 : 0] dina
  .douta(M_R_Data)  // output wire [31 : 0] douta
);
    store32 MDR(M_R_Data,~clk,rst_n,R_Data);
    always @(*) begin
        case (w_data_s)
        2'b00:W_Data=F;
        2'b01:W_Data=imm32;
        2'b10:W_Data=R_Data; 
        2'b11:W_Data=PC;
    endcase
    end
    
    
    //Fdiv div(clk_100M,clk_1K);

    always @(*) begin
        //BEQ有问题吗？
        case (mode)
        3'b000: out=PC;
        3'b001: out=inst;
        3'b010: out=W_Data;
        3'b011: out=A;
        3'b100: out=B;
        3'b101: out=F;
        3'b110: out=R_Data;
        default: out=imm32;
    endcase
    end
    //work digit(out,clk_1K,AN,seg);
endmodule

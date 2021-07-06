`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/15 22:30:42
// Design Name: 
// Module Name: CU
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

//input[4:0] rs1,input[4:0] rs2,
module CU(input clk,input rst_n,input IS_R,input IS_IMM,input IS_LUI,input IS_LW,input IS_SW,
input IS_JAL,input IS_JALR,input IS_BEQ,input[3:0]ALU_OP,input[3:0]FR,
output reg PC_Write,output reg PC0_Write,output reg IR_Write,output reg Reg_Write,output Mem_Write,
output reg rs2_imm_s,output reg[1:0] w_data_s,output reg[1:0]PC_s,output reg [3:0] ALU_OP_o);
reg[3:0] ST;reg[3:0] Next_ST;
parameter idle = 4'b0000,S1=4'b0001,S2=4'b0010,S3=4'b0011,S4=4'b0100,
S5=4'b0101,S6=4'b0110,S7=4'b0111,S8=4'b1000,S9=4'b1001,S10=4'b1010,S11=4'b1011,S12=4'b1100,
S13=4'b1101,S14=4'b1110;
always @(negedge rst_n or posedge clk) begin
    if(!rst_n)ST<=idle;
    else ST<=Next_ST;
end
assign Mem_Write =(Next_ST==S10);
always @(*) begin
    Next_ST=idle;
    case(ST)
    idle: Next_ST=S1;
    S1:begin
      if(IS_LUI)begin Next_ST=S6;end
      else if(IS_JAL) begin Next_ST=S11;end
      else begin Next_ST=S2;end
    end
    S2:begin
      if(IS_R)begin Next_ST=S3;end
      else if(IS_IMM)begin Next_ST=S5;end
      else if(IS_BEQ)begin Next_ST=S13;end
      else begin Next_ST=S7;end
    end
    S3: Next_ST=S4;
    S4: Next_ST=S1;
    S5: Next_ST=S4;
    S6: Next_ST=S1;
    S7: begin
        if (IS_LW)  begin Next_ST=S8; end
        else if(IS_SW)begin Next_ST=S10;end
        else begin Next_ST=S12;       end
        //
    end
    S8: Next_ST=S9;
    S9: Next_ST=S1;
    S10: Next_ST=S1;
    S11: Next_ST=S1;
    S12: Next_ST=S1;
    S13: Next_ST=S14;
    S14: Next_ST=S1;
    default:Next_ST=S1;
endcase
end
always @(negedge rst_n or posedge clk) begin
    if (!rst_n) begin
        PC_Write<=0;PC0_Write<=0;IR_Write<=0;Reg_Write<=0;rs2_imm_s<=0;w_data_s<=2'b00;ALU_OP_o<=4'b0000;PC_s<=2'b00;
    end
    else begin
        case (Next_ST)
            S1: begin PC_Write<=1;PC0_Write<=1;IR_Write<=1;Reg_Write<=0;PC_s=2'b00; end
            S2: begin PC_Write<=0;PC0_Write<=0;IR_Write<=0;Reg_Write<=0; end
            S3: begin PC_Write<=0;PC0_Write<=0;IR_Write<=0;Reg_Write<=0;ALU_OP_o<=ALU_OP;rs2_imm_s<=0; end
            S4: begin PC_Write<=0;PC0_Write<=0;IR_Write<=0;Reg_Write<=1;w_data_s<=2'b00; end
            S5: begin PC_Write<=0;PC0_Write<=0;IR_Write<=0;Reg_Write<=0;ALU_OP_o<=ALU_OP;rs2_imm_s<=1; end
            S6: begin PC_Write<=0;PC0_Write<=0;IR_Write<=0;Reg_Write<=1;w_data_s<=2'b01; end
            S7: begin PC_Write<=0;PC0_Write<=0;IR_Write<=0;Reg_Write<=0;ALU_OP_o<=0000;rs2_imm_s<=1; end
            S8: begin PC_Write<=0;PC0_Write<=0;IR_Write<=0;Reg_Write<=0; end
            S9: begin PC_Write<=0;PC0_Write<=0;IR_Write<=0;Reg_Write<=1;w_data_s<=2'b10; end
            S10: begin PC_Write<=0;PC0_Write<=0;IR_Write<=0;Reg_Write<=0; end
            S11: begin PC_Write<=1;PC0_Write<=0;IR_Write<=0;Reg_Write<=1;w_data_s<=2'b11;PC_s<=2'b01; end
            S12: begin PC_Write<=1;PC0_Write<=0;IR_Write<=0;Reg_Write<=1;w_data_s<=2'b11;PC_s<=2'b10; end
            S13: begin PC_Write<=0;PC0_Write<=0;IR_Write<=0;Reg_Write<=0;ALU_OP_o<=4'b1000;rs2_imm_s<=0; end
            S14: begin PC_Write<=FR[3];PC0_Write<=0;IR_Write<=0;Reg_Write<=0;PC_s<=2'b01; end
        endcase
    end
end
endmodule

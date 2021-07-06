`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/11 16:11:33
// Design Name: 
// Module Name: Register
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


module Register(input [4:0]R_ADDR_A,input [4:0]R_ADDR_B,input [4:0]W_ADDR,
    input Reg_Write,input rst_n,input clk_regs,input [31:0]W_Data,
    output [31:0]R_Data_A,output [31:0]R_Data_B
    );
    reg [31:0]REG_File[0:31];integer i=0;
    initial begin
        for (i = 0; i<32; i=i+1) 
            begin
                REG_File[i]<=32'b0;
            end
    end
    always @(posedge clk_regs or negedge rst_n) begin
        if(!rst_n)begin
        //for循环赋值
            /*REG_File[0]<=32'b0;
            REG_File[1]<=32'b0011;
            REG_File[2]<=32'hfffffff8;
            REG_File[3]<=32'b11110;
            REG_File[4]<=32'b1;      
            REG_File[5]<=32'b11101;*/      
            for (i = 0; i<32; i=i+1) 
            begin
                REG_File[i]<=32'b0;
            end
        end
        else begin
             if(Reg_Write && W_ADDR!=0)
             REG_File[W_ADDR]<=W_Data;
             else begin
                 REG_File[W_ADDR] <= REG_File[W_ADDR];
             end
        end
    end
    assign R_Data_A = REG_File[R_ADDR_A];
    assign R_Data_B = REG_File[R_ADDR_B];
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/31 20:37:52
// Design Name: 
// Module Name: Test1
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


module Test1(input PC_write,input IR_write,input clka,input rst_n,
    input PC0_Write,input [1:0]PC_S,input [31:0]imm32,input[31:0]F,
    output [31:0]inst,output [31:0]PC);
    //去掉移位，F
    wire[31:0]douta,PC0;
    wire[5:0]addra;

    RegPC regPC(~clka,rst_n,PC_write,PC_S,imm32,F,PC0,PC);  
    Reg PCO(PC,~clka,rst_n,PC0_Write,PC0);
    assign addra = PC[7:2];
    im rom (
  .clka(clka),    // input wire clka
  .addra(addra),  // input wire [5 : 0] addra
  .douta(douta)  // output wire [31 : 0] douta
);
  Reg regIR(douta,~clka, rst_n, IR_write,inst);

endmodule

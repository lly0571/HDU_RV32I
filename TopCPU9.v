`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/17 20:48:19
// Design Name: 
// Module Name: TopCPU7
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


module TopCPU9(input clka,input clk_100M,input rst_n,input[2:0]mode,output [7:0] AN,output [7:0] seg,output [3:0]FR);
    wire [31:0]out;
    
    Fdiv div(clk_100M,clk_1K);
    JoggleRemove jr(clka,clk_1K,clk);
    work digi(out,clk_1K,AN,seg);
    RIU_CPU cpu(clk,rst_n,mode,out,FR);
endmodule

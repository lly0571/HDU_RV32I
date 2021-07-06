`timescale 1ns / 1ps
module Reg(input [31:0]F,input clk,input rst_n,input write,
output reg[31:0]File);
    always @(negedge rst_n or posedge clk) begin
        if(!rst_n)
        File<=0;
        else if(write==1)
        File<=F;
        else ;
    end
endmodule

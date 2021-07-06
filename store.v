`timescale 1ns / 1ps


module store32(input [31:0]F,input clk,input rst_n,
output reg[31:0]File
    );
    always @(negedge rst_n or posedge clk) begin
        if(!rst_n)
        File<=0;
        else
        File<=F;
    end
endmodule

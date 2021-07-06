`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/06 16:45:57
// Design Name: 
// Module Name: Fdiv
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


module Fdiv(
      input clk_100M,
      output reg clk_1K
    );
  reg [10:0] counter1;
   always@(posedge clk_100M)
   begin
       if(counter1==11'd2000)
            begin
              clk_1K<=~clk_1K;
              counter1<=11'd0;
            end
       else 
           counter1<=counter1+1'b1;
   end

endmodule

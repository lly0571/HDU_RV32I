`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/06 15:39:23
// Design Name: 
// Module Name: work
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


module work(
   input [31:0]F,
   input clk_1K,
       output reg[7:0] AN,
       output reg[7:0] seg
   );
  
    reg [2:0] bit_sel;
    reg[3:0] num;
    
     always @(posedge clk_1K)
                 bit_sel<=bit_sel+1'b1;
    always @(bit_sel)
              case(bit_sel)
                   3'b000:AN<=8'b11111110;
                   3'b001:AN<=8'b11111101;
                   3'b010:AN<=8'b11111011;
                   3'b011:AN<=8'b11110111;
                   3'b100:AN<=8'b11101111;
                   3'b101:AN<=8'b11011111;
                   3'b110:AN<=8'b10111111;
                   3'b111:AN<=8'b01111111;
              endcase  
          
    always @(bit_sel)
               case(bit_sel)
                   3'b000:num<=F[3:0];
                   3'b001: num<=F[7:4];
                   3'b010: num<=F[11:8];
                   3'b011:num<=F[15:12];             
                   3'b100:num<=F[19:16];
                   3'b101: num<=F[23:20];
                   3'b110: num<=F[27:24];
                   3'b111: num<=F[31:28];   
               endcase  
     always @(*)
               case(num) 
                   0:seg<=8'b00000011;
                   1:seg<=8'b10011111;
                   2:seg<=8'b00100101;
                   3:seg<=8'b00001101;
                   4:seg<=8'b10011001;
                   5:seg<=8'b01001001;
                   6:seg<=8'b01000001;
                   7:seg<=8'b00011111;
                   8:seg<=8'b00000001;
                   9:seg<=8'b00001001;
                   10:seg<=8'b00010001;
                   11:seg<=8'b11000001;
                   12:seg<=8'b01100011;
                   13:seg<=8'b10000101;
                   14:seg<=8'b01100001;
                   15:seg<=8'b01110001;
               endcase    
endmodule

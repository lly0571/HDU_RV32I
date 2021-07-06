`timescale 1ns / 1ps

module ALU(
    input [31:0]ALU_A,input [31:0]ALU_B,input [3:0]ALU_OP,
    output reg[31:0]ALU_F,output reg [3:0]FR
);
reg C32;
//使用case语句实现选择
always @(*) begin
    case(ALU_OP)
    4'b0000:begin
      {C32,ALU_F}=ALU_A+ALU_B;
    end
    4'b0001:begin
        ALU_F=ALU_A<<ALU_B;
    end
    4'b0010:begin      
      ALU_F=($signed(ALU_A) < $signed(ALU_B))?1:0;
    end
    4'b0011:begin
      ALU_F=(ALU_A < ALU_B)?1:0;
    end
    4'b0100:begin
      ALU_F=ALU_A^ALU_B;
    end
    4'b0101:begin
      ALU_F=ALU_A>>ALU_B;
    end
    4'b0110:begin
      ALU_F=ALU_A|ALU_B;
    end
    4'b0111:begin
      ALU_F=ALU_A&ALU_B;
    end
    4'b1000:begin
      {C32,ALU_F}=ALU_A-ALU_B;
    end
    4'b1001:begin
      ALU_F=$signed(ALU_A)>>>ALU_B;
    end
    endcase
    FR[3]=ALU_F==0;
    FR[2]=ALU_F[31];
    FR[1]=C32;
    FR[0]=C32^ALU_F[31]^ALU_A[31]^ALU_B[31];

end

endmodule

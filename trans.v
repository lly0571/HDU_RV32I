module trans(input [31:0]inst,
output [4:0]rs1,output [4:0]rs2,output [4:0]rd,
output [6:0]opcode,output [2:0]funct3,output [6:0]funct7,
output reg[5:0]I_fmt
    );

assign opcode = inst[6:0];
assign funct7=inst[31:25];
assign rs2=inst[24:20];
assign rs1=inst[19:15];
assign funct3=inst[14:12];
assign rd=inst[11:7];
always @(*) begin
  case (opcode)
//RISBUJ
//R
    7'b0110011: begin
      
      I_fmt=6'b100000;
    end
    //I
    7'b0010011:begin
      I_fmt=6'b010000;
    end
    //S
    7'b0100011:begin

      I_fmt=6'b001000;
    end
    //B
    7'b1100011:begin
      I_fmt=6'b000100;

    end
    //U
    7'b0110111:begin
      I_fmt=6'b000010;
    end
    //J
    7'b1101111:begin
      I_fmt=6'b000001;
    end
    //lw
    7'b0000011:I_fmt=6'b010000;
endcase
end

endmodule
module ALU(opcode,rs_reg,rt_reg,immediate,Branch,funct,ALU_result);

input [5:0]opcode, funct;
input [31:0]rs_reg, rt_reg;
input [15:0]immediate;
output Branch;
output [31:0]ALU_result;

wire [5:0]opcode, funct;
wire [31:0]rs_reg, rt_reg;
wire [15:0]immediate;
reg Branch;
reg [31:0]ALU_result;

reg signed[31:0] Srs_reg, Srt_reg, Sext_imm, Zext_imm, BranchAdd;

always @ ( opcode ) begin
  Branch=1'b0;
  Srs_reg = rs_reg;
  Srt_reg = rt_reg;
  Sext_imm = {{16{immediate[15]}}, immediate};
  Zext_imm = {{16{1'b0}}, immediate};
  BranchAdd = {{14{immediate[15]}}, immediate, 2'b0};

  if(opcode == 6'b000000)
  begin
    if(funct == 6'b100000)//add
    begin
      ALU_result = Srs_reg + Srt_reg;
    end

    if(funct == 6'b100010)//sub
    begin
      ALU_result = Srs_reg - Srt_reg;
    end

    if(funct == 6'b100100)//and
    begin
      ALU_result = rs_reg & rt_reg;
    end

    if(funct == 6'b100111)//nor
    begin
      ALU_result = rs_reg ~| rt_reg;
    end

    if(funct == 6'b100101)//or
    begin
      ALU_result = rs_reg | rt_reg;
    end

    if(funct == 6'b101010)//slt
    begin
      ALU_result = (rs_reg < rt_reg)?1'b1:1'b0;
    end
  end

  //i
  else if(opcode == 6'b001000)//addi
  begin
    ALU_result = Srs_reg + Sext_imm;
  end

  else if(opcode == 6'b001100)//andi
  begin
    ALU_result = rs_reg & Zext_imm;
  end

  else if(opcode == 6'b001101)//ori
  begin
    ALU_result = rs_reg | Zext_imm;
  end

  else if(opcode == 6'b001010)//slti
  begin
    ALU_result = (Srs_reg < Sext_imm)?1'b1:1'b0;
  end

  else if(opcode == 6'b000100)//beq
  begin
    if(Srs_reg==Srt_reg)
    begin
      Branch = 1'b1;
      ALU_result = BranchAdd;
    end
    else
    begin
      Branch = 1'b0;
    end
  end

  else if(opcode == 6'b000101)//bneq
  begin
    if(Srs_reg!=Srt_reg)
    begin
      Branch = 1'b1;
      ALU_result = BranchAdd;
    end
    else
    begin
      Branch = 1'b0;
    end
  end

  else if(opcode == 6'b000001)//bgez
  begin
    if(Srs_reg>=32'b00000000000000000000000000000000)
    begin
      Branch = 1'b1;
      ALU_result = BranchAdd;
    end
    else
    begin
      Branch = 1'b0;
    end
  end

  else if(opcode==6'b101000)//sb
  begin
    ALU_result = Srs_reg + Sext_imm;
  end
  else if(opcode==6'b101001)//sh
  begin
    ALU_result = Srs_reg + Sext_imm;
  end
  else if(opcode == 6'b101011)//sw
  begin
    ALU_result = Srs_reg + Sext_imm;
  end
  else if(opcode == 6'b100000)//lb
  begin
    ALU_result = Srs_reg + Sext_imm;
  end
  else if(opcode == 6'b100001)//lh
  begin
    ALU_result = Srs_reg + Sext_imm;
  end
  else if(opcode == 6'b100011 )//lw
  begin
    ALU_result = Srs_reg + Sext_imm;
  end


end//end ALU ops

endmodule

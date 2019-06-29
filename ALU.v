module ALU([5:0]opcode,
            [31:0]rs_reg,
            [31:0]rt_reg,
            [15:0]immediate,
            Branch,
            [5:0]funct,
            [31:0]writeData);

input [5:0]opcode, funct;
input [31:0]rs_reg, rt_reg;
input [15:0]immediate;
input Branch;
output [31:0]writeData;

wire [5:0]opcode, funct;
wire [31:0]rs_reg, rt_reg;
wire [15:0]immediate;
wire Branch;
reg [31:0]writeData;

reg signed[31:0] Srs_reg, Srt_reg, Sext_imm, Zext_imm;

always @ ( opcode, funct, rs_reg, rt_reg, immediate ) begin

  Srs_reg = rs_reg;
  Srt_reg = rt_reg;
  Sext_imm = {16{immediate[15]}, immediate};
  Zext_imm = {16{1b’0}, immediate};
  BranchAdd = {14{immediate[15]}, immediate, 2’b0}

  if(opcode == 6'b000000)
  begin
    if(funct == 6'b100000)//add
    begin
      writeData = Srs_reg + Srt_reg;
    end

    if(funct == 6'b100010)//sub
    begin
      writeData = Srs_reg - Srt_reg;
    end

    if(funct == 6'b100100)//and
    begin
      writeData = rs_reg & rt_reg;
    end

    if(funct == 6'b100111)//nor
    begin
      writeData = rs_reg ~| rt_reg;
    end

    if(funct == 6'b100101)//or
    begin
      writeData = rs_reg | rt_reg;
    end

    if(funct == 6'b101010)//slt
    begin
      writeData = (rs_reg < rt_reg)?1'b1:1'b0;
    end
  end

  //i
  else if(opcode == 6'b001000)//addi
  begin
    writeData = Srs_reg + Sext_imm;
  end

  else if(opcode == 6'b001100)//andi
  begin
    writeData = rs_reg & Zext_imm;
  end

  else if(opcode == 6'b001101)//ori
  begin
    writeData = rs_reg | Zext_imm;
  end

  else if(opcode == 6'b001010)//slti
  begin
    writeData = (Srs_reg < Sext_imm)?1'b1:1'b0;
  end

  else if(opcode == 6'b000100)//beq
  begin
    if(Srs_reg==Srt_reg)
    begin
      Branch = 1'b1;
      writeData = BranchAdd;
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
      writeData = BranchAdd;
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
      writeData = BranchAdd;
    end
    else
    begin
      Branch = 1'b0;
    end
  end

  else if(opcode==6'b101000)//sb
  begin
    writeData = Srs_reg + Sext_imm;
  end
  else if(opcode==6'b101001)//sh
  begin
    writeData = Srs_reg + Sext_imm;
  end
  else if(opcode==6'b101011)//sw
    writeData = Srs_reg + Sext_imm;
  end
  else if(opcode == 6'b100000)//lb
  begin
    writeData = Srs_reg + Sext_imm;
  end
  else if(opcode == 6'b100001)//lh
  begin
    writeData = Srs_reg + Sext_imm;
  end
  else if(opcode == 6'b100011 )//lw
  begin
    writeData = Srs_reg + Sext_imm;
  end


end//end ALU ops

endmodule

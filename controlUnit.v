module ControlUnit(RegWrite, RegRead, MemRead, MemWrite, Branch, toReg, [5:0]opcode, [5:0]funct);

input[5:0] opcode, funct;
output RegWrite, RegRead, MemRead, MemWrite, toReg;

wire[5:0]opcode, funct;
reg RegWrite, RegRead, MemRead, MemWrite, toReg;

always @ ( opcode, funct ) begin
  RegWrite = 1'b0;
  RegRead = 1'b0;
  MemRead = 1'b0;
  MemWrite = 1'b0;
  Branch = 1'b0;
  toReg = 1'b0;//0 ALU, 1 mem

  //R
  if(opcode==6'b000000)
  begin
    RegRead = 1'b1;
    if(funct!=6'b001000)//jr
    begin
      regWrite=1'b1;
    end
  end

  //I
  else if(opcode==6'b100000 | opcode==6'b100001 | opcode==6'b100011)//lb, lh, lw
  begin
    MemRead=1'b1;
    toReg=1'b1;
    RegWrite=1'b1;
  end

  else if(opcode==6'b101000 | opcode==6'b101001 | opcode==6'b101011)//sb, sh, sw
  begin
    MemWrite=1'b1;
    RegRead=1'b1;
  end

  else if(opcode == 6'b001000 | opcode == 6'b001100 | opcode == 6'b001101 | opcode == 6'b001010)//addi, andi, ori, slti
  begin
    RegRead=1'b1;
    RegWrite=1'b1;
  end

  else if(opcode == 6'b001111)//lui
  begin
    regWrite=1'b1;
  end

  else if(opcode == 6'b000011)//jal
  begin
    regWrite=1'b1;
  end

  //branch se calcula en la ALU

end

endmodule

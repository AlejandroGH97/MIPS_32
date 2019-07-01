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

always @ (rs_reg,rt_reg,funct,immediate) begin
  $display("ALU got opcode: %b and function: %b",opcode,funct);
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
    $display("add");
      ALU_result = Srs_reg + Srt_reg;
    end

    if(funct == 6'b100010)//sub
    begin
    $display("sub");
      ALU_result = Srs_reg - Srt_reg;
    end

    if(funct == 6'b100100)//and
    begin
    $display("and");
      ALU_result = rs_reg & rt_reg;
    end

    if(funct == 6'b100111)//nor
    begin
    $display("nor");
      ALU_result = rs_reg ~| rt_reg;
    end

    if(funct == 6'b100101)//or
    begin
    $display("or");
      ALU_result = rs_reg | rt_reg;
    end

    if(funct == 6'b101010)//slt
    begin
    $display("slt");
      ALU_result = (Srs_reg < Srt_reg)?1'b1:1'b0;
    end
  end

  //i
  else if(opcode == 6'b001000)//addi
  begin
  $display("addi");
    ALU_result = Srs_reg + Sext_imm;
  end

  else if(opcode == 6'b001100)//andi
  begin
  $display("andi");
    ALU_result = rs_reg & Zext_imm;
  end

  else if(opcode == 6'b001101)//ori
  begin
  $display("ori");
    ALU_result = rs_reg | Zext_imm;
  end

  else if(opcode == 6'b001010)//slti
  begin
  $display("slti");
    ALU_result = ($signed(Srs_reg) < $signed(Sext_imm))?32'b00000000000000000000000000000001:32'b00000000000000000000000000000000;
  end

  else if(opcode == 6'b000100)//beq
  begin
  $display("beq");
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
  $display("bneq");
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
  $display("bgez");
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
  $display("sb");
    ALU_result = Srs_reg + Sext_imm;
  end
  else if(opcode==6'b101001)//sh
  begin
  $display("sh");
    ALU_result = Srs_reg + Sext_imm;
  end
  else if(opcode == 6'b101011)//sw
  begin
  $display("sw");
    ALU_result = Srs_reg + Sext_imm;
  end
  else if(opcode == 6'b100000)//lb
  begin
  $display("lb");
    ALU_result = Srs_reg + Sext_imm;
    $display("Srs: %b - Sext: %b",Srs_reg,Sext_imm);
  end
  else if(opcode == 6'b100001)//lh
  begin
  $display("lh");
    ALU_result = Srs_reg + Sext_imm;
  end
  else if(opcode == 6'b100011 )//lw
  begin
  $display("lw");
    ALU_result = Srs_reg + Sext_imm;
  end
  else if(opcode==6'b001111)
  begin
  $display("lui");
    ALU_result={immediate,16'b0000000000000000};
  end

$display("ALU_Result: %b",ALU_result);

end//end ALU ops

endmodule

module DataMemory(ALU_result,
                    rt_reg,
                    opcode,
                    memRead,
                    memWrite,
                    clk,
                    immediate,
                    out);

input[31:0] ALU_result;
input[31:0] rt_reg;
input[5:0] opcode;
input[15:0] immediate;
input memRead,memWrite,clk;
output[31:0] out;


wire[31:0] ALU_result;
wire[31:0] rt_reg;
wire[5:0] opcode;
wire[15:0] immediate;
wire memRead,memWrite,clk;
reg[31:0] out;


reg [7:0] memory [0:255];

reg signed[31:0] Sext_imm,Srs_reg;

initial begin
  $readmemb("data_mem.txt",memory);
end

always @ ( negedge clk ) begin

  Sext_imm = {{16{immediate[15]}}, immediate};

  if(memWrite)
  begin
    if(opcode==6'b101000)//sb
    begin
    $display("Stored byte %b in memory address %b\n",rt_reg[7:0],ALU_result);
      memory[ALU_result]=rt_reg[7:0];
    end
    else if(opcode==6'b101001)//sh
    begin
    $display("Stored halfword %b in memory address %b\n",rt_reg[15:0],ALU_result);
      memory[ALU_result]=rt_reg[15:8];
      memory[ALU_result + 1]=rt_reg[7:0];
    end
    else if(opcode==6'b101011)//sw
    begin
    $display("Stored word %b in memory address %b\n",rt_reg,ALU_result);
      memory[ALU_result]=rt_reg[31:24];
      memory[ALU_result + 1]=rt_reg[23:16];
      memory[ALU_result + 2]=rt_reg[15:8];
      memory[ALU_result + 3]=rt_reg[7:0];
    end
    //$writememb("data_mem.txt", memory);
  end
end

always @ ( ALU_result ) begin
  if(memRead)//para loads
  begin
    Srs_reg = ALU_result;
    Sext_imm = {{16{immediate[15]}}, immediate};
    out = {memory[ALU_result],memory[ALU_result + 1],memory[ALU_result + 2],memory[ALU_result + 3]};//loads
    $display("Memory sent value: %b",out);
  end
end

endmodule

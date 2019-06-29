module DataMemory([31:0]ALU_result,
                    [31:0]rt_reg,
                    [5:0]opcode,
                    memRead,
                    memWrite,
                    clk,
                    [15:0]immediate,
                    [31:0]out);

input[31:0] ALU_result;
input[31:0] rt_reg;
input[5:0] opcode;
input memRead,memWrite,clk;
output[31:0] out;


wire[31:0] ALU_result;
wire[31:0] rt_reg;
wire[5:0] opcode;
wire memRead,memWrite,clk;
reg[31:0] out;


reg [7:0] memory [255:0];


initial begin
  $readmemb("data_mem.txt",memory);
end

always @ ( negedge clk ) begin

  Sext_imm = {16{immediate[15]}, immediate};

  if(memWrite)
  begin
    if(opcode==6'b101000)//sb
    begin
      memory[ALU_result]=rt_reg[7:0];
    end
    else if(opcode==6'b101001)//sh
    begin
      memory[ALU_result]=rt_reg[15:8];
      memory[ALU_result + 1]=rt_reg[7:0];
    end
    else if(opcode==6'b101011)//sw
    begin
      memory[ALU_result]=rt_reg[31:24];
      memory[ALU_result + 1]=rt_reg[23:16];
      memory[ALU_result + 2]=rt_reg[15:8];
      memory[ALU_result + 3]=rt_reg[7:0];
    end
    $writememb("data_mem.txt", memory);
  end
end

always @ ( rs_reg ) begin
  if(memRead)//para loads
  begin
    out = {memory[ALU_result],memory[ALU_result + 1],memory[ALU_result + 2],memory[ALU_result + 3]};//loads
  end
end

endmodule

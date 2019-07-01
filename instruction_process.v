module InstructionProcess(instruction,
                            opcode,
                            rs,
                            rt,
                            rd,
                            funct,
                            immediate,
                            address);

input [31:0] instruction;
output[4:0] rs,rt,rd;
output[5:0] opcode,funct;
output[15:0] immediate;
output[25:0] address;


wire[31:0] instruction;
reg[4:0] rs,rt,rd;
reg[5:0] opcode,funct;
reg[15:0] immediate;
reg[25:0] address;


always @ (instruction) begin
  opcode = instruction[31:26];
  if(opcode==6'b000000)//R
  begin
    rs = instruction[25:21];
    rt = instruction[20:16];
    rd = instruction[15:11];
    funct = instruction[5:0];
  end
  else if(opcode==6'b000010 || opcode==6'b000011)//J
  begin
    address = instruction[25:0];
  end
  else//I
  begin
    rs = instruction[25:21];
    rt = instruction[20:16];
    immediate = instruction[15:0];
  end
  $display("Instruction: %b\nOpcode: %b - rs: %b - rt: %b - rd: %b - funct: %b - Immediate: %b",instruction,opcode,rs,rt,rd,funct,immediate);
end

endmodule

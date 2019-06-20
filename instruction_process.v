module instruction_process([31:0]instruction,
                            [5:0]opcode,
                            [4:0]rs,
                            [4:0]rt,
                            [4:0]rd,
                            [5:0]funct,
                            [15:0]immediate,
                            [25:0]address);

input [31:0] instruction;
output[4:0] rs,rt,rd;
output[5:0] opcode,funct;
output[15:0] immediate;
output[25:0] address;

wire instruction;
reg opcode,rs,rt,rd,funct;
reg immediate;
reg address;



always @ ( instruction ) begin
  opcode = instruction[31:25];
  if(opcode==6'b000000)//R
  begin
    rs = instruction[25:21];
    rt = instruction[20:16];
    rd = instruction[15:11];
    funct = instruction[5:0];
  end
  else if(opcode==6'b000010 | opcode==6'b000011)//J
  begin
    address = instruction[25:0];
  end
  else//I
  begin
    rs = instruction[25:21];
    rt = instruction[20:16];
    immediate = instruction[15:0];
  end
end

endmodule

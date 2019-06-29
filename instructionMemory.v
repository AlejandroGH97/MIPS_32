module InstructionMemory([31:0]pc, [31:0] instruction);
input [31:0]pc;
output [31:0] out;

wire[31:0] pc;
reg[31:0] out;

reg [7:0] instruction_memory [255:0];

initial begin
  $readmemb("instruction_mem.txt", mem);
end

always @ ( in ) begin
  out = {mem[pc],mem[pc+1'b1],mem[pc+2'b10],mem[pc+2'b11]};
end


endmodule

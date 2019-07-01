module InstructionMemory(pc, instruction);
input [31:0]pc;
output [31:0] instruction;

wire[31:0] pc;
reg[31:0] instruction;

reg [7:0] mem [0:255];

initial begin
  $readmemb("programa3.txt", mem);
end

always @ (pc) begin
$display("PC: %b",pc);
  instruction = {mem[pc],mem[pc+1'b1],mem[pc+2'b10],mem[pc+2'b11]};
end


endmodule

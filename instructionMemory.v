module InstructionMemory([7:0]in, [31:0] out);
input [7:0] in;
output [31:0] out;

wire[7:0] in;
reg[31:0] out;

reg [31:0] instruction_memory [255:0];

initial begin
  $readmemb("instruction_mem.txt", mem);
end

always @ ( in ) begin
  out = mem[in];
end


endmodule

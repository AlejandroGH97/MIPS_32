module instructionMemory([31:0]in, [31:0] out);
input [31:0] in;
output [31:0] out;
wire in;
reg out;

reg [31:0] instruction_memory [255:0];

initial begin
  $readmemb("mem.txt", mem);
end

always @ ( in ) begin
  out = mem[in];
end


endmodule

module registers()

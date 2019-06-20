module Registers([4:0]read1,
  [4:0]read2,
  [4:0]writeAdd,
  clk,regWrite;
  [31:0]writeData,
  [31:0]out1,
  [31:0]out2);

input[4:0] read1, read2, writeAdd;
input clk, regWrite, rt_rd;
input[31:0] writeData;
output [31:0] out1, out2;

reg[31:0] registers[31:0];

initial begin
  registers[0]=0;
end


always @ ( writeData ) begin
  if(regWrite)
  begin

  end
end

endmodule

module MemToReg(toReg,ALU_Result,mem_read,out);

input[31:0] ALU_Result, mem_read;
input clk,toReg;
output[31:0] out;

wire toReg;
wire[31:0] ALU_Result, mem_read;
reg[31:0] out;

always @ ( ALU_Result,mem_read ) begin
  if(toReg==1'b0)//ALU_Result
  begin
  $display("Selected ALU data.");
    out=ALU_Result;
  end
  else if(toReg==1'b1)//mem_read
  begin
  $display("Selected mem data: %b",mem_read);
    out=mem_read;
  end
end



endmodule

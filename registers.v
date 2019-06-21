module Registers([4:0]read1,
  [4:0]read2,
  [4:0]writeAdd,
  [5:0] opcode,
  regWrite,RegRead,
  [31:0]writeData,
  [31:0]out1,
  [31:0]out2);

input[4:0] read1, read2, writeAdd;
input[5:0] opcode;
input clk, regWrite, rt_rd, RegRead;
input[31:0] writeData;
output [31:0] out1, out2;


wire[4:0] read1, read2, writeAdd;
wire[5:0] opcode;
wire clk, regWrite, rt_rd, RegRead;
wire[31:0] writeData;
reg [31:0] out1, out2;


reg[31:0] registers[31:0];

initial begin
		$readmemb("registers.mem", registers);
end


always @ ( writeData ) begin
  if(regWrite)
  begin
    if(rt_rd)//usa rd
    begin
      if(opcode==6'b100100)//lb
      begin
        registers[writeAdd][7:0]=writeData[7:0];
      end
      else if(opcode==6'b100101)//lh
      begin
        registers[writeAdd][15:0]=writeData[15:0];
      end
      else
      begin
        registers[writeAdd]=writeData;
      end
    end

    else//usa rt
    begin
    if(opcode==6'b101000)//sb
    begin
      registers[read2][7:0]=writeData[7:0];
    end
    else if(opcode==6'b101001)//sh
    begin
      registers[read2][15:0]=writeData[15:0];
    end
    else
    begin
      registers[read2]=writeData;
    end
    end
    $writememb("registers.mem",registers);
  end
end

always @ ( read1, read2 ) begin
  if (RegRead) begin
    registers[read1]=out1;
    registers[read2]=out2;
  end
end


endmodule

module Registers(pc,
                  read1,
                  read2,
                  writeAdd,
                  opcode,
                  immediate,
                  regWrite,RegRead,
                  writeData,
                  out1,
                  out2,
                  clk,
                  rt_rd);

input[31:0] pc;
input[4:0] read1, read2, writeAdd;
input[5:0] opcode;
input[15:0] immediate;
input clk, regWrite, RegRead,rt_rd;
input[31:0] writeData;
output [31:0] out1, out2;

wire[31:0] pc;
wire[4:0] read1, read2, writeAdd;
wire[5:0] opcode;
wire[15:0] immediate;

wire clk, regWrite, RegRead,rt_rd;
wire[31:0] writeData;
reg [31:0] out1, out2;


reg[31:0] registers[0:31];

initial begin
		$readmemb("registers.txt", registers);
end


always @ ( posedge clk ) begin
  if(opcode==6'b000011)//jal
  begin
    registers[31]=pc+3'b100;
  end
  $writememb("registers.txt",registers);
end

always @ ( writeData ) begin

  if(regWrite)
  begin
    if(rt_rd)//Se escribe a rt
    begin
      if(opcode == 6'b100000)//lb
      begin
        registers[read2][7:0]=writeData[7:0];
      end
      else if(opcode == 6'b100001)//lh
      begin
        registers[read2][15:0]=writeData[15:0];
      end
      else if(opcode == 6'b001111 )//lui
      begin
        registers[read2]={immediate,16'b0000000000000000};
      end
      else
      begin
        registers[read2]=writeData;
      end
    end
    else//Se escribe a rd
    begin
      registers[writeAdd]=writeData;
    end
  end
  $writememb("registers.txt",registers);
end

always @ ( read1, read2 ) begin
  if (RegRead) begin
    registers[read1]=out1;
    registers[read2]=out2;
  end
end

initial begin
  $monitor("WriteData_registers: %b",writeData);
end

endmodule

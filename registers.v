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


always @ (opcode) begin
  if(opcode==6'b000011)//jal
  begin
    registers[31]=pc+3'b100;
    $display("Address %b saved in $ra",registers[31]);
  end
end

always @ (writeData) begin
  $display("Registers got regWrite: %b",regWrite);
  if(regWrite)
  begin
    if(rt_rd)//Se escribe a rt
    begin
      if(opcode == 6'b100000)//lb
      begin
      $display("Loaded byte %b in %b(rt)\n",writeData[7:0],read2);
        registers[read2][7:0]=writeData[7:0];
      end
      else if(opcode == 6'b100001)//lh
      begin
      $display("Loaded halfword %b in %b(rt)\n",writeData[15:0],read2);
        registers[read2][15:0]=writeData[15:0];
      end
      else if(opcode == 6'b001111 )//lui
      begin
      $display("Loaded upper immediate %b in %b(rt)\n",writeData,read2);
        registers[read2]=writeData;
      end
      else
      begin
      $display("Loaded data %b in %b(rt)\n",writeData,read2);
        registers[read2]=writeData;
      end
    end
    else//Se escribe a rd
    begin
      $display("Loaded data %b in %b(rd)\n",writeData,writeAdd);
      registers[writeAdd]=writeData;
    end
  end
  $writememb("registers1.txt",registers);
end

always @ (read1, read2) begin
if (RegRead)
  begin
    out1 = registers[read1];
    out2 = registers[read2];
    $display("Register module got read1 %b with value: %b and read2 %b with value: %b",read1,out1,read2,out2);
  end
end

endmodule

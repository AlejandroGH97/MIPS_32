module Registers([31:0]pc,
                  [4:0]read1,
                  [4:0]read2,
                  [4:0]writeAdd,
                  [5:0] opcode,
                  [15:0]immediate,
                  regWrite,RegRead,
                  [31:0]writeData,
                  [31:0]out1,
                  [31:0]out2,
                  clk);

input[31:0] pc;
input[4:0] read1, read2, writeAdd;
input[5:0] opcode;
input[15:0] immediate;
input clk, regWrite, RegRead;
input[31:0] writeData;
output [31:0] out1, out2;

wire[31:0] pc;
wire[4:0] read1, read2, writeAdd;
wire[5:0] opcode;
wire[15:0] immediate;

wire clk, regWrite, RegRead;
wire[31:0] writeData;
reg [31:0] out1, out2;


reg[31:0] registers[31:0];

initial begin
		$readmemb("registers.mem", registers);
end


always @ ( posedge clk ) begin
  if(opcode==6'b000011)//jal
  begin
    registers[31]=pc+3'b100;
  end
end

always @ ( writeData ) begin

  if(regWrite)
  begin
    if(opcode == 6'b100000)//lb
    begin
      registers[read1][7:0]=writeData[7:0];
    end
    else if(opcode == 6'b100001)//lh
    begin
      registers[read1][15:0]=writeData[15:0];
    end
    else if(opcode == 6'b001111 )//lui
    begin
      registers[read1]={immediate,16'b0000000000000000}
    end
    else
    begin
      registers[read1]=writeData;
    end
  end
  $writememb("registers.mem",registers);
end

always @ ( read1, read2 ) begin
  if (RegRead) begin
    registers[read1]=out1;
    registers[read2]=out2;
  end
end


endmodule

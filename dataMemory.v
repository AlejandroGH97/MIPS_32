module DataMemory([7:0]readAddress,//de la alu
  [31:0]writeData,
  [5:0]opcode,
  memRead,
  memWrite,
  clk,
  [31:0]out);

input[7:0] readAddress;
input[31:0] writeData;
input[5:0] opcode;
input memRead,memWrite,clk;
output[31:0] out;


wire[7:0] readAddress;
wire[31:0] writeData;
wire[5:0] opcode;
wire memRead,memWrite,clk;
reg[31:0] out;


reg [31:0] memory [255:0];


initial begin
  $readmemb("data_mem.txt",memory);
end

always @ ( readAddress ) begin
  if(memRead)
  begin
    if(opcode==6'b101000)//sb
    begin
      memory[readAddress][7:0]=writeData[7:0];
    end
    else if(opcode==6'b101001)//sh
    begin
      memory[readAddress][15:0]=writeData[15:0];
    end
    else
    begin
      memory[readAddress]=writeData;
    end
    $writememb("data_mem.txt", memory);
  end
end

always @ (negedge clk ) begin
  if(memWrite)
  begin
    memory[readAddress] = writeData;
  end
end

endmodule

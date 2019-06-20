module DataMemory([7:0]readAddress,
  [31:0]writeData,
  memRead,
  memWrite,
  clk,
  [31:0]out);
  
input[7:0] readAddress;
input[31:0] writeData;
input memRead,memWrite,clk;
output[31:0] out;

reg [31:0] memory [255:0];


initial begin
  $readmemb("data_mem.txt",memory);
end

always @ ( readAddress or clk ) begin
  if(memRead)
  begin
    out = memory[readAddress];
  end
end

always @ (negedge clk ) begin
  if(memWrite)
  begin
    memory[readAddress] = writeData;
  end
end

endmodule

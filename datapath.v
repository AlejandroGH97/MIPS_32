module datapath(clk);
input clk;

wire[31:0] instruction;

reg[31:0] pc = 32'b0;

//variables
wire[5:0] opcode,funct;
wire[4:0] rs,rt,rd;
wire[25:0] address;
wire[15:0] immediate;

//https://inst.eecs.berkeley.edu/~cs61c/resources/MIPS_Green_Sheet.pdf


//senales
wire RegWrite, ALUSrc, MemRead, MemWrite, MemToReg, Branch, rt_rd;
wire[1:0] PCSrc;

//registros
wire[31:0] rs_reg, rt_reg, rd_reg, mem_read;

InstructionMemory getInstruction(pc,instruction);

instruction_process processInstruction(instruction,opcode,rs,rt,rd,funct,immediate,address);



always @ ( clk ) begin
if(PCSrc==2'b01)
begin
  if(opcode==6'b000000 && funct ==6'b001000)//JR
  begin
    PC = rs_reg;
  end
  else if(opcode==6'b000010)//J
  begin
    PC=address;
  end

  else if(opcode==6'b000011)//JAL
  begin
    PC = address;
  end
end//end JUMPS

else if(PCSrc==2'b10)
begin
  PC = PC + 1 + $signed(address);
end//end BRANCHES

else begin//PC+1
  PC = PC + 1'b1;
end//NO JUMP or BRANCH

end

endmodule

//Use J for calling subroutines
//Use Jal for calling functions
//Use Jr for ending a subroutine by jumping to the return address (ra)

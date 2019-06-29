module datapath(clk);
input clk;

wire[31:0] instruction;

reg[31:0] pc = 31'b00000000000000000000000000000000;

//variables
wire[5:0] opcode,funct;
wire[4:0] rs,rt,rd;
wire[25:0] address;
wire[15:0] immediate;


//https://inst.eecs.berkeley.edu/~cs61c/resources/MIPS_Green_Sheet.pdf


//senales
wire RegWrite, RegRead, toReg, MemRead, MemWrite, Branch;//toReg nos dice si excribir de ALU o de memoria (0 de ALU 1 de mem)
wire[1:0] PCSrc;

//datos
wire[31:0] rs_reg, rt_reg, writeData, mem_read_data, ALU_result;

InstructionMemory getInstruction(pc,instruction);

InstructionProcess processInstruction(instruction,opcode,rs,rt,rd,funct,immediate,address);

Registers RegOperations(pc,rs, rt, rd, opcode, immediate, regWrite, RegRead, writeData, rs_reg, rt_reg,clk);

DataMemory MemOperations(ALU_result,rt_reg,opcode,memRead,memWrite,clk,immediate,mem_read_data);//revisar parametros

ALU ALUop(opcode,rs_reg,rt_reg,immediate,Branch,funct,Branch,ALU_result);

ControlUnit signals(RegWrite, RegRead, MemRead, MemWrite, Branch,toReg, opcode, funct);

MemToReg regData(toReg, ALU_result, mem_read, writeData);


always @ ( negedge clk ) begin
  if(opcode==6'b000000 && funct ==6'b001000)//JR
  begin
    PC = rs_reg;
  end
  else if(opcode==6'b000010 | opcode==6'000011)//J
  begin
    PC= {(pc+3'b100)[31:28], address,2'b00};
  end
  else if(Branch==1'b1)//branch
  begin
    PC = PC + 4 + $signed(writeData);
  end
  else
  begin//PC+1
    PC = PC + 3'b100;
  end
end



endmodule

//Use J for calling subroutines
//Use Jal for calling functions
//Use Jr for ending a subroutine by jumping to the return address (ra)

//No clock en reg!----------------!
//GUARDAR JAL

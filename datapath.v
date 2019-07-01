module datapath(clk);
input clk;
wire clk;

wire[31:0] instruction;

reg[31:0] PC = 32'b00000000000000000000000000000000;

//variables
wire[5:0] opcode,funct;
wire[4:0] rs,rt,rd;
wire[25:0] address;
wire[15:0] immediate;


//https://inst.eecs.berkeley.edu/~cs61c/resources/MIPS_Green_Sheet.pdf


//senales
wire RegWrite, RegRead, toReg, MemRead, MemWrite, Branch,rt_rd;//toReg nos dice si excribir de ALU o de memoria (0 de ALU 1 de mem)
wire[1:0] PCSrc;

//datos
wire[31:0] rs_reg, rt_reg, writeData, mem_read_data, ALU_result;

InstructionMemory getInstruction(PC,instruction);

InstructionProcess processInstruction(instruction,opcode,rs,rt,rd,funct,immediate,address);

Registers RegOperations(PC,rs, rt, rd, opcode, immediate, RegWrite, RegRead, writeData, rs_reg, rt_reg,clk,rt_rd);

DataMemory MemOperations(ALU_result,rt_reg,opcode,MemRead,MemWrite,clk,immediate,mem_read_data);//revisar parametros

ALU ALUop(opcode,rs_reg,rt_reg,immediate,Branch,funct,ALU_result);

ControlUnit signals(RegWrite, RegRead, MemRead, MemWrite,toReg,rt_rd, opcode, funct);

MemToReg regData(toReg, ALU_result, mem_read_data, writeData);


always @ (posedge clk) begin
$display("PC calc");
  if(opcode==6'b000000 && funct ==6'b001000)//JR
  begin
    $display("Jump to register: %b\n",rs_reg);
    PC = rs_reg;
  end
  else if(opcode==6'b000010 || opcode==6'b000011)//J y JAL
  begin
    $display("Jump with value: %b\n",{PC[31:28],address,2'b00});
    PC = PC + 3'b100;
    PC= {PC[31:28],address,2'b00};
  end
  else if(Branch==1'b1)//branch
  begin
    PC = PC + 4 + $signed(writeData);
    $display("Branch to: %b\n",PC);
  end
  else
  begin//PC+4
    $display("PC + 4");
    PC = PC + 3'b100;
  end
end


endmodule

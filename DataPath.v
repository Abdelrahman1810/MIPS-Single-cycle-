////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Author: Abdelrahman Mohamed (SalBy)
// 
// Project: MIPS Core Processor Single cycle 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module DataPath(
    input clk, rst
);

wire RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
wire [1:0] ALUOp;

wire [31:0] PCResult;
wire [31:0] PCNext;

ProgramCounter pc (
    .clk(clk),
    .rst(rst),
    .PCNext(PCNext),

    .PCResult(PCResult)
);

wire [31:0] PCadderResult;
PCadder pcAdder(
    .PCResult(PCResult),
    .PCadderResult(PCadderResult)
);


wire [31:0] Instruction;

InstructionMemory insMem(
    .ReadAddress(PCResult),

    .Instruction(Instruction)
);

wire [4:0] ReadRegister1, ReadRegister2, WriteRegister; 
wire [31:0] WriteData;
wire [31:0] ReadData1, ReadData2;
assign ReadRegister1 = Instruction[25:21];
assign ReadRegister2 = Instruction[20:16];

muxNbit_2_1 #(
    .N(5)
)writeRegMux(
     .sel(RegDst),
     .in1(ReadRegister2), .in2(Instruction[15:11]),
     .out(WriteRegister)
);

RegisterFile regfile(
    .clk(clk),
    .ReadRegister1(ReadRegister1),
    .ReadRegister2(ReadRegister2),
    .WriteRegister(WriteRegister),
    .WriteData(WriteData),
    .RegWrite(RegWrite), 

     .ReadData1(ReadData1),
     .ReadData2(ReadData2)
);

wire [15:0] SignExtendIn;
wire [31:0] SignExtendOut;
assign SignExtendIn = Instruction[15:0];

SignExtend signEx(
  .in(SignExtendIn),
  .out(SignExtendOut)
);

wire [5:0] ALUControlIn;
assign ALUControlIn = Instruction[5:0];
wire [3:0] ALUControlResult;

ALUControl alucontrol(
    .ALUOp(ALUOp), 
    .FunctionCode(ALUControlIn),

    .ALUControlResult(ALUControlResult) 
);

wire [31:0] MainALUin1, MainALUin2;
wire [31:0] ALUResult;
wire zero;
assign MainALUin1 = ReadData1;
assign MainALUin2 = (ALUSrc)? SignExtendOut : ReadData2;

MainALU mainALU(
    .OperandA(MainALUin1),
    .OperandB(MainALUin2), 
    .ALUControlResult(ALUControlResult),
    .shamt(Instruction[10:6]),

    .zero(zero),
    .ALUResult(ALUResult)
);

ControlUnit control(
    .operation(Instruction[31:26]),

    .RegDst(RegDst),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp)
);

wire [31:0] BranchTarget;
BranchTargetAddress branchtarget(
    .PCadderResult(PCadderResult),
    .SignExtendOut(SignExtendOut),
    
    .BranchTarget(BranchTarget)
);

wire [31:0] ReadData;

DataMemory #(
    //parameters
   .MEM_DEPTH(1024)
)datamem(
    .clk(clk),
    .Address(ALUResult),
    .WriteData(ReadData2),
    .MemWrite(MemWrite),
    .MemRead(MemRead),

    .ReadData(ReadData)
);

assign WriteData = (MemtoReg)? ReadData : ALUResult;
assign PCNext = (Branch & zero)? BranchTarget : PCadderResult;
endmodule
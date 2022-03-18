module Processor (
    input wire CLK,RST,
    output wire [15:0] test_value
);
    
/* PC IP-OP */
wire[31:0] PC_IN,PC_OUT;

/* Instruction Memory Input- Output */
wire[31:0] Instruction_Memory_Output;

/* Register File Input - Output */
wire[31:0] RegFile_RD1,RegFile_RD2;


/* Sign Extend Input-Output*/
 wire [31:0] Sign_Extend_Output;

/* Control Unit Input-Output*/
 wire [5:0] Control_Unit_OpCode, Control_Unit_Funct;
 wire Control_Unit_Jump,Control_Unit_MemtoReg,Control_Unit_MemWrite,Control_Unit_Branch,Control_Unit_ALUSrc,Control_Unit_RegDst,Control_Unit_RegWrite;
 wire [2:0] Control_Unit_ALUControl;

/* ALU Input-Output */
 wire [31:0] ALU_ALUResult;
 wire ALU_ZeroFlag;


/* DATA MEMORY  Input-Output*/
 wire [31:0] DATA_Memory_RD;

/* MUXES Input - Output*/
 wire [31:0] MUX_ALU_OUT;
 wire [4:0] MUX_RegFile_OUT;
 wire [31:0] MUX_DataMemory_OUT;
 wire [31:0] MUX_PC_L_OUT;

/* Shift by left Input - Output*/
 wire [31:0] Shift_Left_Twice_PCBranch_Out; /* here */
 wire [27:0] Shift_Left_Twice_Mux_Out;


/* Adder Input-Output */
 wire [31:0] PC_PLUS_4;
 wire [31:0] Adder_R_Output;

PC U0_PC(
   
.CLK(CLK),
.RST(RST),
.PC_INPUT(PC_IN),
.PC_OUTPUT(PC_OUT)

);

Instruction_Memory U0_Instruction_Memory(

   .PC_Entry(PC_OUT),
   .Instr(Instruction_Memory_Output)

);


MUX U0_Mux_ALU(

    .SEL(Control_Unit_ALUSrc),
    .in1(Sign_Extend_Output),
    .in2(RegFile_RD2),
    .out(MUX_ALU_OUT)
);


MUX #(

    .WIDTH(5)

) U0_Mux_RegFile(

    .SEL(Control_Unit_RegDst),
    .in1(Instruction_Memory_Output[15:11]),
    .in2(Instruction_Memory_Output[20:16]),
    .out(MUX_RegFile_OUT)

);

MUX U0_Mux_DataMemory(

    .SEL(Control_Unit_MemtoReg),
    .in1(DATA_Memory_RD),
    .in2(ALU_ALUResult),
    .out(MUX_DataMemory_OUT)

);

wire signal;
assign signal = (ALU_ZeroFlag & Control_Unit_Branch);
MUX U0_Mux_PC_L(

    .SEL(signal),
    .in1(Adder_R_Output),
    .in2(PC_PLUS_4),
    .out(MUX_PC_L_OUT)

);


MUX U0_Mux_PC_R(

    .SEL(Control_Unit_Jump),
    .in1({ PC_PLUS_4[31:28] , Shift_Left_Twice_Mux_Out}),
    .in2(MUX_PC_L_OUT),
    .out(PC_IN) 
);

Sign_Extend U0_Sign_Extend(

    .Instr(Instruction_Memory_Output[15:0]),
    .Output(Sign_Extend_Output)
);


Register_File U0_Register_File(

    .A1(Instruction_Memory_Output[25:21]),
    .A2(Instruction_Memory_Output[20:16]),
    .A3(MUX_RegFile_OUT),
    .WD3(MUX_DataMemory_OUT),
    .CLK(CLK),
    .WE3(Control_Unit_RegWrite),
    .RST(RST),
    .RD1(RegFile_RD1),
    .RD2(RegFile_RD2)

);


Control_Unit U0_Control_Unit(

    .OpCode(Instruction_Memory_Output[31:26]),
    .Funct(Instruction_Memory_Output[5:0]),
    .Jump(Control_Unit_Jump),
    .MemtoReg(Control_Unit_MemtoReg),
    .MemWrite(Control_Unit_MemWrite),
    .Branch(Control_Unit_Branch),
    .ALUSrc(Control_Unit_ALUSrc),
    .RegDst(Control_Unit_RegDst),
    .RegWrite(Control_Unit_RegWrite),
    .ALUControl(Control_Unit_ALUControl)
);

ALU U0_ALU(

    .SrcA(RegFile_RD1),
    .SrcB(MUX_ALU_OUT),
    .ALUControl(Control_Unit_ALUControl),
    .ZeroFlag(ALU_ZeroFlag),
    .ALUResult(ALU_ALUResult)

);

DATA_Memory U0_DATA_Memory(

    .Address(ALU_ALUResult),
    .WD(RegFile_RD2),
    .CLK(CLK),
    .RST(RST),
    .WE(Control_Unit_MemWrite),
    .RD(DATA_Memory_RD),
    .test_value(test_value)

);

Shift_Left_Twice U0_MUX(

    .in(Instruction_Memory_Output[25:0]),
    .out(Shift_Left_Twice_Mux_Out)
);

Shift_Left_Twice #(

    .WIDTH_INPUT(32),
    .WIDTH_OUTPUT(32)

) U0_PCBranch(

    .in(Sign_Extend_Output),
    .out(Shift_Left_Twice_PCBranch_Out)
);


Adder U0_LEFT(
    .A(PC_OUT),
    .B(32'd4),
    .C(PC_PLUS_4)
);

Adder U0_RIGHT(

    .A(Shift_Left_Twice_PCBranch_Out),
    .B(PC_PLUS_4),
    .C(Adder_R_Output)
);


endmodule
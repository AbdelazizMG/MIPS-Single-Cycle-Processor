module Control_Unit (
    input wire[5:0] OpCode, Funct,
    output reg Jump,MemtoReg,MemWrite,Branch,ALUSrc,RegDst,RegWrite,
    output reg [2:0] ALUControl
);
    

reg [1:0] ALUOP;


always @(*) 
    begin
    
    case(OpCode)

    6'b10_0011 : 

        begin 
        Jump = 1'b0;
        ALUOP = 2'b00;
        MemWrite = 1'b0;
        RegWrite = 1'b1;
        RegDst = 1'b0;
        ALUSrc = 1'b1;
        MemtoReg = 1'b1;
        Branch = 1'b0;
        end
    6'b10_1011 : 

        begin 
        Jump = 1'b0;
        ALUOP = 2'b00;
        MemWrite = 1'b1;
        RegWrite = 1'b0;
        RegDst = 1'b0;
        ALUSrc = 1'b1;
        MemtoReg = 1'b1;
        Branch = 1'b0;
        end
    
    6'b00_0000 : 

        begin 
        Jump = 1'b0;
        ALUOP = 2'b10;
        MemWrite = 1'b0;
        RegWrite = 1'b1;
        RegDst = 1'b1;
        ALUSrc = 1'b0;
        MemtoReg = 1'b0;
        Branch = 1'b0;
        end

    6'b00_1000 : 

        begin 
        Jump = 1'b0;
        ALUOP = 2'b00;
        MemWrite = 1'b0;
        RegWrite = 1'b1;
        RegDst = 1'b0;
        ALUSrc = 1'b1;
        MemtoReg = 1'b0;
        Branch = 1'b0;
        end
    
    6'b00_0100 : 

        begin 
        Jump = 1'b0;
        ALUOP = 2'b01;
        MemWrite = 1'b0;
        RegWrite = 1'b0;
        RegDst = 1'b0;
        ALUSrc = 1'b0;
        MemtoReg = 1'b0;
        Branch = 1'b1;
        end

    6'b00_0010 : 

        begin 
        Jump = 1'b1;
        ALUOP = 2'b00;
        MemWrite = 1'b0;
        RegWrite = 1'b0;
        RegDst = 1'b0;
        ALUSrc = 1'b0;
        MemtoReg = 1'b0;
        Branch = 1'b0;
        end    

    default : 

        begin 
        Jump = 1'b0;
        ALUOP = 2'b00;
        MemWrite = 1'b0;
        RegWrite = 1'b0;
        RegDst = 1'b0;
        ALUSrc = 1'b0;
        MemtoReg = 1'b0;
        Branch = 1'b0;
        end   
    endcase
    end


    always @(*)
    
     begin
        
    case(ALUOP)

    2'b00:
    ALUControl = 3'b010;

    2'b01:
    ALUControl = 3'b100;

    2'b10:
        begin
        case(Funct)

        6'b10_0000: ALUControl = 3'b010;
        6'b10_0010: ALUControl = 3'b100;
        6'b10_1010: ALUControl = 3'b110;
        6'b01_1100: ALUControl = 3'b101;

        default:
        ALUControl = 3'b010;

 
        endcase
        end

    default:
    ALUControl = 3'b010;

        endcase
     end



endmodule
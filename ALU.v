module ALU (
    input wire [31:0] SrcA,
    input wire [31:0] SrcB,
    input wire [2:0] ALUControl,
    output wire ZeroFlag,
    output reg [31:0] ALUResult
);


assign ZeroFlag = ~(|ALUResult);


always @(*)

    begin
    
     case (ALUControl)

     3'b000: ALUResult = SrcA & SrcB;
     3'b001: ALUResult = SrcA | SrcB;
     3'b010: ALUResult = SrcA + SrcB;
     3'b100: ALUResult = SrcA - SrcB;
     3'b101: ALUResult = SrcA * SrcB;
     3'b110: 
            begin
             if ( SrcA < SrcB)
              ALUResult = 32'd1;
            else
              ALUResult = 32'd0;

            end
     

         default: 

         ALUResult = 32'd10;

     endcase


     end

    
endmodule
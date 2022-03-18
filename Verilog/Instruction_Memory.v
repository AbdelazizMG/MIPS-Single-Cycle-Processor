module Instruction_Memory (
    
    input wire [31:0] PC_Entry,
    output wire [31:0] Instr
);
    
reg [31:0] ROM [0:99];


initial 
    begin
    
    $readmemh("Program 1_Machine Code.txt",ROM);    

    end

assign Instr = ROM[PC_Entry>>2];

endmodule
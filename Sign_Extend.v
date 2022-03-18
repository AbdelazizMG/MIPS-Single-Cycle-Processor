module Sign_Extend (
    input wire [15:0] Instr,
    output reg [31:0] Output
);
    

always @(*)


    begin

    if(Instr[15])
   
    Output = {16'hFFFF,Instr};
      

    else
    Output = {16'h0000,Instr};

    end

endmodule
module PC (
    input wire CLK,
    input wire RST,
    input wire [31:0] PC_INPUT,
    output reg [31:0] PC_OUTPUT
);


 always @( posedge CLK , negedge RST) 
    
    begin

    if (!RST)
    PC_OUTPUT <= 32'd0;

    else
    PC_OUTPUT <= PC_INPUT;

    end  

endmodule
module Shift_Left_Twice #(
       parameter WIDTH_INPUT = 26,
       parameter WIDTH_OUTPUT = 28
)
(
      input wire[WIDTH_INPUT-1:0] in,
      output reg [WIDTH_OUTPUT-1:0] out
);
    

always @(*) 

    begin
        
    out = in << 2;    

    end

endmodule
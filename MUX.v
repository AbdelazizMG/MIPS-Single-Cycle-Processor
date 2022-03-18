module MUX #(

    parameter WIDTH = 32
    
)
(
    input wire SEL,
    input wire[WIDTH-1:0] in1,in2,
    output reg [WIDTH-1:0] out
    
);


always @(*)

     begin
    

         if(SEL)
         out = in1;

         else
         out = in2;

    end


endmodule
module DATA_Memory #(
 
       parameter WIDTH = 32,
       parameter DEPTH = 100 

)
(
    input wire [WIDTH-1:0] Address,
    input wire [WIDTH-1:0] WD,
    input wire CLK, RST, WE,
    output wire [WIDTH-1:0] RD,
    output wire [15:0] test_value

);
    
reg [WIDTH-1:0 ] RAM [0:DEPTH-1];

assign RD = RAM[Address];

assign test_value = RAM[0];

integer i;

always @(posedge CLK , negedge RST)
    begin
    
    if (!RST)
    begin
        for ( i = 0 ; i < DEPTH ; i = i + 1 )
        begin

        RAM [i] <= 32'd0;

        end
    end

    else
        if(WE)
          RAM[Address] <= WD;    


    end

endmodule
module Register_File #(
    parameter WIDTH = 32,
    parameter DEPTH = 32
)
(
    input wire[4:0] A1,A2,A3,
    input wire[31:0] WD3,
    input wire CLK,WE3,RST,
    output wire[31:0] RD1,RD2
);

reg [WIDTH-1:0] RegFile [0:DEPTH-1];


assign RD1 = RegFile[A1];
assign RD2 = RegFile[A2];


integer i;

always @(posedge CLK , negedge RST) 
    begin
    
    if(!RST)
        begin
        for ( i = 0 ; i < DEPTH ; i = i + 1)
            begin
            RegFile[i] <= 'd0;    /*{WIDTH {1'd0}}*/
            end
        end

    else
    if(WE3)
    RegFile[A3] <= WD3;


    end

    
endmodule
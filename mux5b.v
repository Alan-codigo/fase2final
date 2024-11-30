`timescale 1ns/1ns

module mux5b(

    //inputs
    input sel,
    input [4:0] A,
    input [4:0] B,

    //outputs
    output reg[4:0] C

);

always @*
begin
    if(sel)
    begin 
        C=B;
    end
    else
    begin
        C=A;
    end
end

endmodule

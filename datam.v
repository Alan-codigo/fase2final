`timescale 1ns/1ns


module DataMemory(
    
    //inputs
    input [31:0] DataIn,
    input memwrite,
    input memread,
    input [4:0]adress, 

    //outputs
    output reg [31:0] outdatamemory

);

reg [31:0] DataMemory [0:3];

always @*
begin
    if(memwrite)
    begin
        DataMemory[adress] = DataIn;
    end
    
    if(memread)
    begin
        outdatamemory = DataMemory[adress];
    end
end

endmodule
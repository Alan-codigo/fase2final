`timescale 1ns/1ns

module alu(
    
    //inputs
    input [31:0] DR1,
    input [31:0] DR2,
    input [2:0] ALUControl,

    //outputs
    output reg zero,
    output reg[31:0] ALUOutput
);
// add, sub, slt, and, or, xor, nor
always @*
begin
    case (ALUControl)

        //ADD
        3'b001:
        begin
            zero = 1'b0;
            ALUOutput = DR1 + DR2;
        end  

        //SUB
        3'b010:
        begin
            zero = 1'b0;
            ALUOutput = DR1 - DR2;
        end

        //SLT
        3'b011:
        begin
            zero = 1'b0;
            ALUOutput = DR1 > DR2 ? 1 : 0;
        end

        //AND
        3'b100:
        begin
            zero = 1'b0;
            ALUOutput = DR1 & DR2;
        end

        //OR
        3'b101:
        begin
            zero = 1'b0;
            ALUOutput = DR1 | DR2;
        end

        //XOR
        3'b110:
        begin
            zero = 1'b0;
            ALUOutput = DR1 ^ DR2;
        end

        //NOR
        3'b111:
        begin
            zero = 1'b0;
            ALUOutput = ~(DR1 | DR2);
        end

    endcase 
end


endmodule

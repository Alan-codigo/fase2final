`timescale 1ns/1ns

module control(

    //inputs
    input [5:0] OpCode,

    //output
    output reg regdst,
    output reg branch,
    output reg memread,
    output reg memtoreg,
    output reg [2:0] aluop,
    output reg memwrite,
    output reg alusrc,
    output reg regwrite
    


);

always @*
begin 
    case (OpCode)
        6'b000000: //type R
            begin 

                regdst = 1'b1;
                branch = 1'b0;
                memread = 1'b0;
                memtoreg = 1'b0;
                aluop = 3'b000;
                memwrite = 1'b0;
                alusrc = 1'b0;
                regwrite = 1'b1;

            end
            
            6'b001000: //type  addi
            begin 

                regdst = 1'b0;
                branch = 1'b0;
                memread = 1'b0;
                memtoreg = 1'b0;
                aluop = 3'b000;
                memwrite = 1'b0;
                alusrc = 1'b1;
                regwrite = 1'b1;

            end

            6'b100111: //type lww
            begin 

                regdst = 1'b0;
                branch = 1'b0;
                memread = 1'b1;
                memtoreg = 1'b1;
                aluop = 3'b000;
                memwrite = 1'b0;
                alusrc = 1'b1;
                regwrite = 1'b1;

            end

                6'b101011: //type store word
            begin 

                regdst = 1'b0;
                branch = 1'b0;
                memread = 1'b0;
                memtoreg = 1'b0;
                aluop = 3'b000;
                memwrite = 1'b1;
                alusrc = 1'b1;
                regwrite = 1'b0;

            end

            6'b000100: //type store word
            begin 

                regdst = 1'b0;
                branch = 1'b1;
                memread = 1'b0;
                memtoreg = 1'b0;
                aluop = 3'b111;
                memwrite = 1'b1;
                alusrc = 1'b1;
                regwrite = 1'b0;

            end

            
    endcase
end

endmodule
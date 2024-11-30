`timescale 1ns/1ns

module registers(

    //inputs

    input regwrite,
    input [4:0] rd1,
    input [4:0] rd2,
    input [4:0] wr,
    input [31:0] writedata,

    //outputs
    output reg [31:0] out1,
    output reg [31:0] out2
);

    reg [31:0] registers [0:31];

    initial 
        begin
            $readmemb("registers.txt", registers);  // Cargar datos desde el archivo
        end

    always @* 
    begin
        if (regwrite) 
        begin 
            registers[wr] = writedata; 
        end

        // Leer valores de los registros
        out1 = registers[rd1];
        out2 = registers[rd2];
    end

endmodule

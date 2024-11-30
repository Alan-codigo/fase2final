`timescale 1ns/1ns

module intructionM(
    input [31:0]readadress,
    output reg [31:0] out_intructionM
);

    reg [7:0] intructionM [0:31];

    initial 
        begin
            $readmemb("dataintructionM_formateado.txt", intructionM);  // Cargar datos desde el archivo
        end

    always @* 
    begin


        // concatenar los valores que tengo desde la direccion readadress hasta 3 direcciones arriba
        out_intructionM = {intructionM[readadress], 
                           intructionM[readadress + 1], 
                           intructionM[readadress + 2], 
                           intructionM[readadress + 3]};

    end

endmodule

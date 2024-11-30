`timescale 1ns/1ns

module newadd(
    input [31:0] madd_in,
    input [31:0] madd_in2,
    output reg [31:0] out1  // 'out1' ahora es un registro
);

    // Bloque always que se ejecuta cuando 'madd_in' o 'madd_four' cambian
    always @ * begin
        out1 = madd_in + madd_in2;
    end

endmodule


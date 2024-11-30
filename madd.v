`timescale 1ns/1ns

module madd(
    input [31:0] madd_in,
    input [31:0] madd_four,
    output reg [31:0] out1  // 'out1' ahora es un registro
);

    // Bloque always que se ejecuta cuando 'madd_in' o 'madd_four' cambian
    always @ * begin
        out1 = madd_in + madd_four;
    end

endmodule

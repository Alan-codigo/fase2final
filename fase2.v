`timescale 1ns/1ns

module fase2 (
    input [31:0] in1,    // Declaración correcta
    input [31:0] in2,
    input [15:0] in13
);

wire [31:0] w1;
wire [31:0] w2;
wire [31:0] w3;
wire [31:0] w4;

// Instancia de madd
madd instancemad(
    .madd_in(in1),       // Puerto correcto
    .madd_four(in2),
    .out1(w1)
);

// Instancia de singE
signE sEinstance(
    .in(in13),           // Uso de in13 en lugar de in3
    .out(w2)
);

// Instancia de sl
sl slintance(
    .in(w2),             // Eliminada la coma extra
    .out(w3)
);

// Instancia de newadd
madd nainstance(
    .madd_in(w1),       // Corregidos los nombres de los puertos
    .madd_four(w3),
    .out1(w4)
);

endmodule

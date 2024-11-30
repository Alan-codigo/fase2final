module sl (
    input wire [31:0] in,   // Entrada de 32 bits
    output wire [31:0] out  // Salida de 32 bits
);
    assign out = in << 2; // Desplazamiento a la izquierda por 2 bits
endmodule


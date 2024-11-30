module signE (
    input wire [15:0] in,  // Entrada de 16 bits
    output wire [31:0] out // Salida de 32 bits
);
    assign out = { {16{in[15]}}, in };
    // {16{in[15]}} replica el bit más significativo 16 veces para la extensión
endmodule


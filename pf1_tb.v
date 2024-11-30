`timescale 1ns/1ns

module pf1_tb();

    // Declaración de señales
    reg clkpf1;
    reg [31:0] out_four;

    // Instanciamos el módulo bajo prueba
    pf1 uut (
        .clkpf1(clkpf1),
        .out_four(out_four)
    );

    // Generación de reloj
    always begin
        #5 clkpf1 = ~clkpf1;  // Reloj con periodo de 10ns (50MHz)
    end

    // Bloque inicial para aplicar estímulos
    initial begin
        // Inicializamos las señales
        clkpf1 = 0;
        out_four = 5;  // Asignamos el valor constante de 4 a 'out_four'


        // Aplicamos el patrón de 0 y 1 en 'clkpf1' durante 6 ciclos
        #10; out_four = 5; // Siempre el valor de out_four es 4
        #10; out_four = 5; 
        #10; out_four = 5; 
        #10; out_four = 5; 
        #10; out_four = 5; 
        #10; out_four = 5; 

        // Finalizamos la simulación después de algunos ciclos
        $stop;
    end

endmodule

`timescale 1ns/1ns

module pc(
    input clk,
    input [31:0] pc_in,
    output reg [31:0] pc_out
);

    initial begin
        pc_out = 32'b1;  // Valor inicial de 0
    end

always @(posedge clk)
begin
    pc_out = pc_in;
end

endmodule

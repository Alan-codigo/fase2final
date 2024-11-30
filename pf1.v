`timescale 1ns/1ns

module pf1(
    input clkpf1,
    input [31:0] out_four
);

//----------------------------------------------------------------
//primero creamos la salida de pc 
//salida
wire [31:0] pc_intructionmemory;
wire [31:0] pc_add;

//ahora la entrada de pc
wire [31:0] mux1_pc;

//add
//ahora creamos entradas y salidad de add
//salida
wire [31:0] add_mux1;

//mux1
wire and_mux1;

//creacion de la primera parte del modulo fase 1
//pc
//add
//mux1

pc pc_instance(
    //entradas
    .clk(clkpf1),
    .pc_in(mux1_pc),
    
    //salida
    .pc_out(pc_add)
);

assign pc_intructionmemory = pc_add;

madd madd_instance(
    //entradas
    .madd_in(pc_add),
    .madd_four(out_four),

    //salida
    .out1(add_mux1)
);

mux mux1(
    //entradas
    .sel(and_mux1),
    .A(add_mux1),
    .B(add_mux1),

    //salida
    .C(mux1_pc)
);

//instruction memory
//salida

wire [31:0] instrucionM_all;

//creacion de la instancia intrucion memory que nos dara solo una salida
intructionM intructionM_instance(
    .readadress(pc_intructionmemory),
    .out_intructionM(instrucionM_all)
);

//creacion de los cables en los que se divide la intruction15_intruction
wire [5:0] instruccion1;
wire [4:0] instruccion2;
wire [4:0] instruccion3;
wire [4:0] instruccion4;
wire [15:0] instruccion5;

//el cable que se divide del cable
wire [5:0] instruccion6;

//----------------------------------------------------------------
//asignamos los valores que les corresponden

assign instruccion1 = instrucionM_all[31:26];
assign instruccion2 = instrucionM_all[25:21];
assign instruccion3 = instrucionM_all[20:16];
assign instruccion4 = instrucionM_all[15:11];
assign instruccion5 = instrucionM_all[15:0];

//cable mas chiquito
assign  instruccion6 = instruccion5[5:0];

//control
wire control_mux2;
wire control_and;
wire control_memorydata_memread;
wire control_mux4;
wire [2:0] control_alucontrol_aluop;
wire control_memorydata_memwrite;
wire control_mux3;
wire control_registers;

//intancia control
control control_instance(
    //entrada
    .OpCode(instruccion1),

    //salidas
    .regdst(control_mux2),
    .branch(control_and),
    .memread(control_memorydata_memread),
    .memtoreg(control_mux4),
    .aluop(control_alucontrol_aluop),
    .memwrite(control_memorydata_memwrite),
    .alusrc(control_mux3),
    .regwrite(control_registers)
);

//me quede en que tengo que hacer el mux2 
//hacer su cable de salida y despues de eso hacer los dos cables de salida 
//el registers 

wire [4:0] mux2_registers;

mux5b mux2_instancia(
    //entradas
    .sel(control_mux2),
    .A(instruccion3),
    .B(instruccion4),

    //salidas
    .C(mux2_registers)
);

//cables de salida de registers
wire [31:0]registers_alu;
wire [31:0]registers_mux3;

//entrada
wire [31:0] mux4_registers;

//y despues hacer la instancia de registers
//instancia registers
registers registers_instancia(
    //entradas
    .regwrite(control_registers),
    .rd1(instruccion2),
    .rd2(instruccion3),
    .wr(mux2_registers),
    .writedata(mux4_registers),

    //salidas
    .out1(registers_alu),
    .out2(registers_mux3)
);

//hacer los cables de alu control
//salida
wire [2:0] alucontrol_alu;

//hacer la intancia de alu control
alucontrol alucontrol_instancia(
    //entradas
    .controlrequest(control_alucontrol_aluop),
    .funct(instruccion6),

    //salidas
    .OpALU(alucontrol_alu)
);

//cable de mux3
wire [31:0] mux3_alu;

//instancia de mux3
mux mux3(
    //entradas
    .sel(control_mux3),
    .A(registers_mux3),
    .B(registers_mux3),

    //salidas
    .C(mux3_alu)
);

//cables de alu
wire alu_and;
wire [31:0] alu_doble;

//instancia de alu
alu alu_instancia(
    //entradas
    .DR1(registers_alu),
    .DR2(mux3_alu),
    .ALUControl(alucontrol_alu),

    //salidas
    .zero(alu_and),
    .ALUOutput(alu_doble)

);

//cables de data memory
//salida
wire [31:0] datamemory_mux4;

//instancia de data DataMemory

//cables de mux4

//instancia de mux 4;
mux mux4(
    //entradas
    .sel(control_mux4),
    .A(alu_datamemory),
    .B(alu_datamemory),

    //salidas
    .C(mux4_registers)

);
//cables del and

//instancia del and
cand cand_instancia(
    .in1(control_and),
    .in2(alu_and),

    .out1(and_mux1)
);

endmodule
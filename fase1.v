`timescale 1ns/1ns

module fase1(
    input clkfase1
);

//pc to intruction memory
wire [31:0] pc_intructionmemory_instruction;
wire [31:0] pc_add_intruction;

//add to mux
wire [31:0] add_mux;
wire [31:0] wirefour;

//mux to pc
wire [31:0] mux1_pc;

//wires instruction memory to all
//wires instruction memory

wire [31:0] instruction_all;

wire [5:0] instruction_control;
wire [4:0] instruction_registers_rs;
wire [4:0] instruction_registers_rt;
wire [4:0] instruction_mux_ad;
wire [5:0]instruction_intruction15;
wire intruction15_intruction5;

//wires control
wire control_mux2_regdst;
wire control_and_branch;
wire control_datamemory_memread;
wire control_mux4_memtoreg;
wire [2:0] control_alucontrol_aluop;
wire control_datamomory_memwrite;
wire control_mux3_alusrc;
wire control_registers_regwrite;

//wire and to mux1
wire and_mux;

//registers
wire [31:0]registers_alu_readdata1;
wire [31:0]registers_mux3_readdata2;

//mux3;
wire [31:0]mux3_alu_readdata2;
wire sing_mux3;

//alu
wire alu_and;
wire [31:0] alu_mux4;

wire [5:0]adress_datamemory;
wire [31:0]alu_datamemory;

//data memory
wire [31:0] datamemory_mux4;

//mux4;
wire [31:0] mux4_registers;

//mux2
wire [4:0] mux2_registers;

//alucontro_
wire [2:0] alucontro_alu_opalu;

pc pcinstance(
    .clk(clkfase1),
    .pc_in(mux1_pc),
    .pc_out(pc_intructionmemory_instruction)
);

assign pc_add_intruction = pc_intructionmemory_instruction;

assign wirefour = 32'd4;

madd addinstance(
    .redadress(pc_add_intruction),
    .four(wirefour),
    .add_out(add_mux)
);


mux muxinstance1(
    .sel(and_mux),
    .A(add_mux),
    .B(add_mux),
    .C(mux1_pc)
);

intructionM instructionMinstance(
    .readadress(pc_intructionmemory_instruction),
    .out_intructionM(instruction_all)
);

assign instruction_control      = instruction_all[31:26];
assign instruction_registers_rs = instruction_all[25:21];
assign instruction_registers_rt = instruction_all[20:16];
assign instruction_mux_ad       = instruction_all[15:11];
assign instruction_intruction15 = instruction_all[15:0];
assign intruction15_intruction5 = instruction_intruction15[5:0];

control controlinstance(

    .OpCode(instruction_control),
    .regdst(control_mux2_regdst),
    .branch(control_and_branch),
    .memread(control_datamemory_memread),
    .memtoreg(control_mux4_memtoreg),
    .aluop(control_alucontrol_aluop),
    .memwrite(control_datamemory_memread),
    .alusrc(control_mux3_alusrc),
    .regwrite(control_registers_regwrite)

);

mux5b mux2(
    .sel(control_mux2_regdst),
    .A(instruction_registers_rt),
    .B(instruction_mux_ad),
    .C(mux2_registers)
);

registers registersinstance(
    .regwrite(control_registers_regwrite),
    .rd1(instruction_registers_rs),
    .rd2(instruction_registers_rt),
    .wr(mux2_registers),
    .writedata(mux4_registers),
    
    .out1(registers_alu_readdata1),
    .out2(registers_mux3_readdata2)
);

mux mux3(
    .sel(control_mux3_alusrc),
    
    //ojo aqui que es el mismo porque todavia no existe sing_mux3
    .A(registers_mux3_readdata2),
    .B(registers_mux3_readdata2),
    .C(mux3_alu_readdata2)
);

alucontrol alucontrolintance(
    .controlrequest(control_alucontrol_aluop),
    .funct(intruction15_intruction5),
    .OpALU(alucontro_alu_opalu)
);

alu aluinstance(
    .DR1(registers_alu_readdata1),
    .DR2(mux3_alu_readdata2),
    .ALUControl(alucontro_alu_opalu),

    .zero(alu_and),
    .ALUOutput(alu_datamemory)
);

assign adress_datamemory = instruction_mux_ad;

DataMemory datamemoryinstance(
    .DataIn(alu_datamemory),
    .memwrite(control_datamomory_memwrite),
    .memread(control_datamemory_memread),
    .adress(adress_datamemory),
    .outdatamemory(datamemory_mux4)
);

mux mux4(
    .sel(control_mux4_memtoreg),
    .A(alu_datamemory),
    .B(alu_datamemory),

    .C(mux4_registers)
);

cand candinstance(
    .in1(control_and_branch),
    .in2(alu_and),

    .out1(and_mux)
);

endmodule
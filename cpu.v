//main module 
`include "instr_mem.v"
`include "decode.v"         //its not decode_unit.v
`include "alu.v"
`include "write_back.v"

module cpu(
    output [15:0] out,
    output [5:0] pc_out,
    input [5:0]pc ,
    input clk,reset
);
wire [31:0]instr;
wire [5:0] alu_op;
wire reg_write;
wire zero;
wire [15:0] alu_out, alu_out2;      //2nd out is data for 2nd dst
wire [15:0] a,b;

instr_mem i(.pc(pc), .instruction(instr));
decode d( .instr(instr),
          .reset(reset),
          .clk(clk),
          .alu_op(alu_op),
          .reg_write(reg_write),
          .a(a),
          .b(b)
);

alu al( .a(a), .b(b), .alu_control(alu_op),.dst(alu_out), .dst2(alu_out2), .zero(zero));

write_back write( 
                .clk(clk),
                .write_data(alu_out), 
                .write_data2(alu_out2), 
                .reg_write(reg_write), 
                .write_addr(instr[25:16])
                );

always @(*)
    $display("\tin cpu.v : a = %b , b = %b, alu_op = %b",a,b,alu_op);


assign out = alu_out2;
assign pc_out = pc + 6'd2;

endmodule
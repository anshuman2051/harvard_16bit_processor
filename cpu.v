//main module 
`include "instr_mem.v"
`include "decode.v"         //its not decode_unit.v
`include "alu.v"
`include "write_back.v"

module cpu(
    output [15:0] out,
    output [15:0] pc_out,
    input [6:0]pc ,
    input clk,reset,
    input [15:0] a,b
);
wire [31:0]instr;
wire [1:0] alu_op;
wire reg_write;
wire zero;
wire [15:0] alu_out;

instr_mem i(.pc(pc), .instruction(instr));
decode d( .opcode(instr),
          .reset(reset),
          .clk(clk),
          .alu_op(alu_op),
          .reg_write(reg_write)
);

alu a( .a(a), .b(b), .alu_control(alu_op), .result(alu_out), .zero(zero));

write_back write( .write_data(alu_out), .reg_write(reg_write));


assign out = alu_out;
assign pc_out = pc + 6'd2;

endmodule
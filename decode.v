//decode(control) unit with 3 bit opcodes
//now just for add and subtract
//
//
//TODO make instruction size to 32 bit with 6 bit of opcode
`include "register_file.v"

module decode( input [31:0] instr,
                input reset,clk,
                output reg [1:0] alu_op,
                output reg reg_write,
                output [15:0] a, b
            );

register_file r(
    .clk(clk),
    .rst(reset),
    .reg_write_en(1'b0),
    .reg_read_addr_1(instr[5:0]),
    .reg_read_data_1(a),
    .reg_read_addr_2(instr[11:6]),
    .reg_read_data_2(b)
);

    always @(*)
    begin
        if( reset == 1'b1) begin
            alu_op = 2'b0;
            reg_write = 1'b0;
        end
        else 
        begin
            case(instr[31:26])
                6'b0:     //add
                begin
                    alu_op = 2'b01;
                    reg_write = 1'b1;
                end
            endcase
        end
    end
endmodule
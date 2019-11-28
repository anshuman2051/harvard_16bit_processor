//decode(control) unit with 6 bit opcodes
//gives 3 bit of alu fun code as output
//now just for add and subtract
//
//
`include "register_file.v"

module decode( input [31:0] instr,
                input reset,clk,
                output reg [2:0] alu_op,
                output reg reg_write,
                output [15:0] a, b
            );

register_file r(
    .clk(clk),
    .rst(reset),
    .reg_write_en(1'b0),
    .reg_read_addr_1(instr[4:0]),
    .reg_read_data_1(a),
    .reg_read_addr_2(instr[9:5]),
    .reg_read_data_2(b)
);

    always @(*)
    begin
        if( reset == 1'b1) begin
            alu_op <= 3'b0;
            reg_write <= 1'b0;
        end
        else 
        begin
            case(instr[31:26])
                6'b0:     //add
                begin
                    alu_op <= 3'b001;
                    reg_write <= 1'b1;
                end
            endcase
        end
    end

    always @(*)
        $display("in decode, alu_op = %b, a = %b , b = %b",alu_op,a,b);
endmodule
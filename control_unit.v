//control unit with 3 bit opcodes
//now just for add and subtract
//
//
//TODO make instruction size to 32 bit with 6 bit of opcode

module control( input [2:0] opcode,
                input reset,
                output reg[1:0] reg_dst, mem_to_reg,alu_op,
                output reg jump, branch, mem_read, mem_write, alu_src, reg_write, sign_or_zero
            );

    always @(*)
    begin
        if( reset == 1'b1) begin
            reg_dst = 2'b00;
            mem_to_reg = 2'b00;
            alu_op = 2'b00;
            jump = 1'b0;
            branch = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            alu_src = 1'b0;
            reg_write = 1'b0;
            sign_or_zero = 1'b1;
        end
        else 
        begin
            case(opcode)
                3'b000:     //add
                begin
                    reg_dst = 2'b01;
                    mem_to_reg = 2'b00;
                    alu_op = 2'b00;
                    jump = 1'b0;
                    branch = 1'b0;
                    mem_read = 1'b0;
                    mem_write = 1'b0;
                    alu_src = 1'b0;
                    reg_write = 1'b1;
                    sign_or_zero = 1'b1;
                end
            endcase
        end
    end
endmodule

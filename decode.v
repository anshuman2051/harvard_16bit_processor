//decode(control) unit with 6 bit opcodes
//gives 3 bit of alu fun code as output
//now just for add and subtract
//
//
`include "register_file.v"

module decode( input [31:0] instr,
                input reset,clk,
                output reg [5:0] alu_op,
                output reg reg_write,
                output reg [15:0] a, b
            );
reg reg_read_en;
reg mem_read_en;
wire [15:0] abar, bbar;

//for reading from register file
register_file r(
    .clk(clk),
    .rst(reset),
    .reg_write_en(1'b0),
    .reg_read_en(reg_read_en),
    .reg_read_addr_1(instr[4:0]),
    .reg_read_data_1(abar),
    .reg_read_addr_2(instr[9:5]),
    .reg_read_data_2(bbar)
);
//for reading from memory file
data_memory mem_read(
    .clk(clk),
    .mem_read(mem_read_en),
    .mem_write_en(1'b0),
    .mem_addr({8'b0,instr[7:0]}),
    .mem_read_data(abar)
);


    always @(*)
    begin
        a <= abar;
        b <= bbar;
    end
    always @(*)
    begin
        if( reset == 1'b1) begin
            alu_op <= 6'b111111;
            reg_write <= 1'b0;
            reg_read_en <= 1'b0;
            mem_read_en <= 1'b0;
        end
        else 
        begin
            alu_op <= instr[31:26];         //alu op is always common
            mem_read_en <= 1'b0;

            if(instr[31:26]== 6'b0)         //immediate move instr
            begin
                a <= instr[15:0];
                reg_write <= 1'b1;
                reg_read_en <= 1'b0;
            end
            else if(instr[31:26] == 6'b000011)                       //store instr
            begin
                reg_write <= 1'b0;                  //will allow mem_write
                reg_read_en <= 1'b1;
            end
            else if(instr[31:26] == 6'b000010)                               //load instr
            begin
                reg_write <= 1'b1;
                reg_read_en <= 1'b0;                //reading from memory
                mem_read_en <= 1'b1;
            end
            else
            begin
                reg_write <= 1'b1;
                reg_read_en <= 1'b1;
                mem_read_en <= 1'b0;
                //case(instr[31:26])
                //   6'b0:     //add
                //  begin
                //     alu_op <= 4'b0001;
                    //    reg_write <= 1'b1;
                    //end
                //endcase
           end
        end
    end

    always @(*)
        $display("in decode, alu_op = %b, a = %b , b = %b, reg_write = %b",alu_op,a,b,reg_write);
endmodule
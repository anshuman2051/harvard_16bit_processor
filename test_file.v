`include "alu.v"
`include "instr_mem.v"
`include "register_file.v" 

module test_file;
//for alu test
reg [15:0] a, b;
reg [2:0] al_ctrl;
wire [15:0] res;
wire zero;

//for instr mem
reg [5:0] pc;
wire [31:0] instr;

//for reg_file
reg clk,reset;
reg [4:0] addr_1, addr_2;
wire [15:0] val1, val2;


alu a1(a,b,al_ctrl,res, zero);
instr_mem i1(pc, instr);
//just tested for reading
register_file r_f(.clk(clk), .rst(reset), .reg_read_addr_1(addr_1), .reg_read_addr_2(addr_2), .reg_read_data_1(val1), .reg_read_data_2(val2));

    initial
        begin
            $display("start of test");
            clk = 1'b0;
            reset = 1'b1;
            #15
            //a = 16'd15; b = 16'd15; al_ctrl = 3'b001;
            //pc = 6'b0;
            reset = 1'b0;
            addr_1 = 5'b00000;
            addr_2 = 5'b00001;
            #15
            //pc = 6'd5;
            //a = 16'd13; b = 16'd11; al_ctrl = 3'b000;
            addr_1 = 5'b00011;
            addr_2 = 5'b00010;
            #150
            $display("end of test");
            $finish;
        end

//using clock
    always
        #5
        clk = ~clk;
    initial
        //$monitor($time, "  %d, %d , out = %d, zero = %d",a,b,res,zero);
        //$monitor($time, "  %b, instr = %b ",pc,instr);
        $monitor($time, " a = %b ,b = %b",val1,val2);

endmodule
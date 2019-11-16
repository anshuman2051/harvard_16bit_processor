//write_back module to decide whether to write on disk or memory
//assign proper clock

//`include "register_file.v" removed because this include is already used in decode.v
`include "data_mem.v"

module write_back(
    input [15:0] write_data,
    input reg_write
);
wire mem_write = 1'b0;

data_memory d_mem( .clk(1'b1), .mem_write_en(mem_write), .mem_write_data(write_data), .mem_addr(16'b0));         
register_file r_file(.clk(1'b1), .reg_write_en(reg_write), .reg_write_dest(5'b0),.reg_write_data(write_data));

assign  mem_write = (reg_write) ? 1'b0 : 1'b1;
endmodule
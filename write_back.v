//write_back module to decide whether to write on disk or memory
//assign proper clock

//`include "register_file.v" removed because this include is already used in decode.v
`include "data_mem.v"

module write_back(
    input clk,
    input [15:0] write_data,write_data2,
    input reg_write,
    input [9:0] write_addr          //5 5 bits if reg write or 8 bit if mem write
);
wire mem_write = 1'b0;

data_memory d_mem( .clk(clk), .mem_write_en(mem_write), .mem_write_data(write_data2), .mem_addr({ 8'b0,write_addr[9:2]}));  
register_file r_file1(.clk(clk), .reg_write_en(reg_write), .reg_write_dest(write_addr[4:0]),.reg_write_data(write_data));      //dest1 data
register_file r_file2(.clk(clk), .reg_write_en(reg_write), .reg_write_dest(write_addr[9:5]),.reg_write_data(write_data2));      //dest2 data
always @(*)
    $display("Inside write back mem_write = %b, reg_write = %b, write_data = %b",mem_write,reg_write,write_data2);

assign  mem_write = (reg_write) ? 1'b0 : 1'b1;          //write to mem if not writing to reg
endmodule
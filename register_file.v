//tested for reading
//16 bit wide register file with 32 registers


module register_file(
    input clk,
    input rst,

    input reg_write_en,
    input reg_read_en,
    input [4:0] reg_write_dest,
    input [15:0] reg_write_data,

    input [4:0] reg_read_addr_1,
    output reg [15:0] reg_read_data_1,

    input [4:0] reg_read_addr_2,
    output reg [15:0] reg_read_data_2
);

    //defining register memory
    reg [15:0] reg_array [31:0];
    integer i;

    always @ ( posedge clk or posedge rst)
    begin
        reg_array[0] <= 16'd5;
        reg_array[1] <= 16'd4;

        if(rst)     //clear registers
        begin
            for( i = 0 ; i < 31; i++)       //replace loop later on
                reg_array[i] <= 16'b0;
        end
        else
        begin
            if( reg_write_en)
                reg_array[reg_write_dest] <= reg_write_data;
            else if(reg_read_en )
            begin
                reg_read_data_1 <= ( reg_read_addr_1 > 16'd31) ? 16'b0 : reg_array[reg_read_addr_1];
                reg_read_data_2 <= ( reg_read_addr_2 > 16'd31) ? 16'b0 : reg_array[reg_read_addr_2];
            end
        end
        //$display("in reg. read enable = %b, file write_en = %b, write_data= %b, reg_array[3] = %b",reg_read_en,reg_write_en,reg_write_data,reg_array[3]);
    end


endmodule
//16 bit wide data memory with 256 locations

module data_memory(
    input clk,
    input [15:0] mem_addr, mem_write_data,
    input mem_read, mem_write_en,
    output [15:0]  mem_read_data
);


    integer i;
    reg [15:0] ram[255:0];
    wire [7:0] ram_addr = mem_addr[8:1];            //why only one part assigned

    //initializing ram addr with zeros

    initial begin
        for( i = 0; i < 256; i = i+1)
            ram[i] <= 16'd0;
    end

    always @(posedge clk)
    begin
        if ( mem_write_en)
            ram[ram_addr] <= mem_write_data;
    end

    assign mem_read_data = (mem_read == 1'b1) ? ram[ram_addr] : 16'd0;
endmodule

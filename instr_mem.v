//tested

module instr_mem(
    input [5:0] pc,
    output wire [31:0]  instruction
);

wire [5:0] rom_addr = pc;

reg [31:0] rom[63:0];
integer i ;

initial
begin
    //initializing instr_mem with zero . can even put code here
    for ( i = 0; i < 63; i++)
        rom[i] = 31'b0;
    rom[0] = 32'b00010000010000110000000000100000;
    //rom[0] = 31'b00011000000000000000000000100000;        //for multiply
    rom[5] = 32'b00000000000000000000000000110001;
end

assign instruction = (pc < 32 ) ? rom[rom_addr] : 31'd0;
endmodule

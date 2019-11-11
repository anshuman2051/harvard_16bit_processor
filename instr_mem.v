//make it 32 bit wide
//

module instr_mem(
    input [15:0] pc,
    output wire [15:0]  instruction
);

wire [3:0] rom_addr = pc[4:1];

reg [15:0] rom[63:0];
integer i ;

initial
begin
    //initializing instr_mem with zero . can even put code here
    for ( i = 0; i < 63; i++)
        rom[i] = 16'b0;
end

assign instruction = (pc[15:0] < 32 ) ? rom[rom_addr[3:0]] : 16'd0;
endmodule

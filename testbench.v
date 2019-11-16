`include "cpu.v"

module testbench;
wire [15:0] out;
wire [5:0]  pc_out;
reg [5:0] pc;
reg clk, reset;

cpu cpu_inst(
    .out(out),
    .pc_out(pc_out),
    .pc(pc),
    .clk(clk),
    .reset(reset)
);

initial
    $monitor($time, " output = %b, pc_out = %b",out, pc_out);

initial 
begin
    $display("started program");
    pc = 1'b0;
    clk = 1'b0;
    reset = 1'b0;
    #50
    $finish;
end

always
    #10 clk = ~clk;

endmodule
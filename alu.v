//tested 
module alu(
    input [15:0] a, b,
    input [2:0] alu_control,        //function select
    output reg [15:0] result,
    output zero
);

always @(*)
begin
    case(alu_control)
        3'b000: result <= a + b; //add
        3'b001 : result <= a-b;
        default: result <= a + b;
    endcase
    //$display("\tinside alu  %d + %d = %d",a,b,result);
end

assign zero = (result == 16'd0) ? 1'b1 : 1'b0;      //returns zero flag value
endmodule

//TODO
//test for all alu operations
//add custom adder , subtractor , multiplier and log or barrel shifter
module alu(
    input [15:0] a, b,
    input [5:0] alu_control,        //function select
    output reg [15:0] dst,dst2,
    output zero
);

always @(*)
begin
    dst <= 16'b0;
    case(alu_control)
        6'b000000 : dst2 <= a;     //immediate move
        6'b000001 : dst2 <= a;     //register move
        6'b000010 : dst2 <= a;     //load 
        6'b000011 : dst2 <= a;     //store
        6'b000100: dst2 <= a + b; //add
        6'b000101 :
            begin
                if(b)
                    dst2 <= b-a;      //subtraction
                else
                    dst2 <= ~a;       //negation
            end
        6'b000110 : {dst,dst2} <= a*b;      //multiplication   exchange dst with dst2 later
        6'b000111 : dst2 <= a/b;      //division
        6'b001000 : dst2 <= a|b;      //or
        6'b001001 : dst2 <= a^b;      //xor
        6'b001010 : dst2 <= ~(a&b);   //nand
        6'b001011 : dst2 <= ~(a|b);   //nor
        6'b001100 : dst2 <= ~(a^b);   //xnor
        6'b001101 : dst2 <= ~a;       //not
        6'b001110 : dst2 <= a<<b;       //lshift
        6'b001111 : dst2 <= a>>b;       //rshift
        default: dst2 <= a + b;
    endcase
    //$display("\tinside alu  %d + %d = %d",a,b,dst2);
end

assign zero = (dst2 == 16'd0) ? 1'b1 : 1'b0;      //returns zero flag value
endmodule

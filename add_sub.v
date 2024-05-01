module add_sub(
    input [2:0] a,   // 1 bit for sign, other 2 are the value
    input [2:0] b,   // 1 bit for sign, other 2 are the value
    input s,                // control variable, 0 for addition, 1 for subtraction
    output [3:0] c,     // 1 bit for sign, other 3 are the value
    output [2:0] cout  //carry out
);

wire [2:0] a_comp;
wire [2:0] b_comp;
wire [3:0] c_temp;

assign a_comp=~a + 1'b1;
assign b_comp=~b + 1'b1;

full_adder f1(
    .a(a_comp[0]),
    .b(b_comp[0]^s),
    .cin(s),
    .cout(cout[0]),
    .sum(c_temp[0])
);

full_adder f2(
    .a(a_comp[1]),
    .b(b_comp[1]^s),
    .cin(cout[0]),
    .cout(cout[1]),
    .sum(c_temp[1])
);



full_adder f3(
    .a(a_comp[2]),
    .b(b_comp[2]^s),
    .cin(cout[1]),
    .cout(cout[2]),
    .sum(c_temp[2])
);

assign c_temp[3]=(cout[2]^cout[1])^c_temp[2];

assign c[3:0]=~c_temp[3:0] + 1'b1;   

endmodule

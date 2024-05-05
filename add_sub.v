module add_sub(
    input [2:0] a,   // 1 bit for sign, other 2 are the value
    input [2:0] b,   // 1 bit for sign, other 2 are the value
    input s,                // control variable, 0 for addition, 1 for subtraction
    output [4:0] c     // 1 bit for sign, other 3 are the value
);

wire [2:0] cout;

wire [2:0] a_comp;
wire [2:0] b_comp;
wire [3:0] c_temp;

assign a_comp[0] = a[0];
wire x1 = ~a[0] & a[1];
wire y1 = a[2] ^ a[1];
assign a_comp[1] = x1 | y1;
assign a_comp[2] = a[2];

assign b_comp[0] = b[0];
wire x2 = ~b[0] & b[1];
wire y2 = b[2] ^ b[1];
assign b_comp[1] = x2 | y2;
assign b_comp[2] = b[2];

full_adder f1(
    .a(a_comp[0]),
    .b(b_comp[0] ^ s),
    .cin(s),
    .cout(cout[0]),
    .sum(c_temp[0])
);

full_adder f2(
    .a(a_comp[1]),
    .b(b_comp[1] ^ s),
    .cin(cout[0]),
    .cout(cout[1]),
    .sum(c_temp[1])
);

full_adder f3(
    .a(a_comp[2]),
    .b(b_comp[2] ^ s),
    .cin(cout[1]),
    .cout(cout[2]),
    .sum(c_temp[2])
);

assign c_temp[3]= ((cout[2] ^ cout[1]) ^ c_temp[2]);
assign c[0] = c_temp[0];
assign c[1] = c_temp[1] ^ (c_temp[3] & c_temp[0]);
assign c[2] = (c_temp[3] ^ c_temp[2]) | (c_temp[2] & ~c_temp[1] & ~c_temp[0]);
assign c[3] = 0;
assign c[4] = c_temp[3];
endmodule

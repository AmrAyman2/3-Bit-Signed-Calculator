module mul(
    input [2:0] a, b, //inputs
    output [4:0] product   //product of both inputs
);

wire x = a[0] & b[1];
wire y = a[1] & b[0];
wire z = a[1] & b[1];
wire s1;
wire c4;
wire ab;

assign product[0]= a[0] & b[0];
assign notzero= (a[0] | a[1]) & (b[1] | b[0]);
assign product[4]= (a[2] ^ b[2]) & notzero;

half_adder h1(
    .a(x),
    .b(y),
    .sum(product[1]),
    .cout(s1)
);
half_adder h2(
    .a(z),
    .b(s1),
    .sum(product[2]),
    .cout(product[3])
);

endmodule
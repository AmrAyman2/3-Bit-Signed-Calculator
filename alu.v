module alu(
    input [2:0] a,
    input [2:0] b,
    input [1:0] s,
    output reg divbyzeroflag,
    output reg zeroflag,
    output reg signflag,
    output reg [4:0] c
);

wire [4:0] addc,subc,mulc,remc;
wire divbyzeroflagtemp;
add_sub add(
    .a(a),
    .b(b),
    .c(addc),
    .s(s[0])
);

add_sub sub(
    .a(a),
    .b(b),
    .c(subc),
    .s(s[0])
);

mul multiplication(
    .a(a),
    .b(b),
    .product(mulc)
);

rem remainder(
    .a(a),
    .b(b),
    .rem(remc),
    .divbyzeroflag(divbyzeroflagtemp)
);

always@(*) begin

zeroflag=0;
if(s==2'b00) begin
    c=addc;
    divbyzeroflag=0;
end

if(s==2'b01) begin
    c=subc;
    divbyzeroflag=0;
end

if(s==2'b10) begin
    c=mulc;
    divbyzeroflag=0;
end

if(s==2'b11) begin
    c=remc;
    divbyzeroflag=divbyzeroflagtemp;
end

if(c==0)
zeroflag=1;

signflag=c[4];

end
endmodule
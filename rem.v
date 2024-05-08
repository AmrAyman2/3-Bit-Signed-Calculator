module rem(
    input [2:0] a,
    input [2:0] b,
    output [4:0] rem,
    output divbyzeroflag
);

wire x2,y2,x1,y1;

assign x2=a[1] & ~a[0];
assign y2=b[1] & b[0];
assign x1=a[0] & b[1];
assign y1=~(b[0] & a[1]);
assign rem[0]=x1 & y1;
assign rem[1]=x2 & y2;
assign rem[2]=0;
assign rem[3]=0;
assign rem[4] = a[2] & (rem[1] | rem[0]);
assign divbyzeroflag= ~(b[0] | b[1]);


endmodule
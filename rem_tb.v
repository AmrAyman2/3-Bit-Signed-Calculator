module rem_tb;
    // inputs
    reg [2:0] a, b;

    // output
    wire [4:0] rem;
    wire divbyzeroflag;

rem DUT(
    .a(a),
    .b(b),
    .rem(rem),
    .divbyzeroflag(divbyzeroflag)
);

reg[4:0] expected;
reg divexpected;
integer i, j,n;
    initial begin
        n = $fopen("rem.txt","w");
        // Iterate over all possible combinations of 3-bit inputs
        for (i = -3; i < 4; i = i + 1) begin
            for (j = -3; j < 4; j = j + 1) begin
                a[2:0] = i;
                b[2:0] = j;
                divexpected=0;
                if(b==3'b000) begin
                expected=0;
                divexpected=1;
                end
                else if(b==3'b101 || b==3'b001)
                expected=5'b00000;
                else if(a[1:0]==b[1:0])
                expected=5'b00000;
                else begin
                expected[3:0]=a[1:0]%b[1:0];
                expected[4]=a[2];
                end
                #100;

                if(rem==expected && divbyzeroflag==divexpected) begin
                $display("success a = %b, b = %b, remainder = %b divbyzero=%b", a, b, rem,divbyzeroflag);
                $fwrite(n,"%b mod %b = %b dividebyzero: %b \n",a,b,rem,divbyzeroflag);
                end
                else begin
                $display("fail a = %b, b = %b, remainder = %b, expected =%b", a, b, rem,expected);
                end
        end
        end
        $fclose(n);
        $finish;
    end

endmodule
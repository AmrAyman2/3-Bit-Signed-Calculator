module add_sub_tb;

    // inputs
    reg signed [2:0] a;
    reg signed [2:0] b;
    reg s;
    // outputs
    wire signed [4:0] c;
    wire [2:0] cout;

    add_sub DUT (
        .a(a),
        .b(b),
        .s(s),
        .c(c)
    );

    reg [4:0] expected;
    integer i, j,n;

    initial begin
    n = $fopen("addsub.txt","w");
        // iterate on all possible combinations
        for (i = -3; i < 4; i = i + 1) begin
            for (j = -3; j < 4; j = j + 1) begin
                a = i;
                b = j;
                s = 1'b0;
                if(a[2]==0 & b[2]==0) begin
                    expected[3:0]=a[1:0]+b[1:0];
                    expected[4]=0;
                end
                if(a[2]==1 & b[2]==1) begin
                    expected[3:0]=a[1:0] + b[1:0];
                    expected[4]=1;
                end
                if(a[2]==1 & b[2]==0 & a[1:0]>b[1:0]) begin
                expected[3:0]=a[1:0]-b[1:0];
                expected[4]=1;
                end
                if(a[2]==1 & b[2]==0 & a[1:0]<b[1:0]) begin
                expected[3:0]=b[1:0]-a[1:0];
                expected[4]=0;
                end
                if(a[2]==0 & b[2]==1 & a[1:0]<b[1:0]) begin
                expected[3:0]=b[1:0]-a[1:0];
                expected[4]=1;
                end
                if(a[2]==0 & b[2]==1 & a[1:0]>b[1:0]) begin
                expected[3:0]=a[1:0]-b[1:0];
                expected[4]=0;
                end
                if(a[2] != b[2] & a[1:0]==b[1:0])
                expected=5'b00000;

                #100;

                if (c == expected) begin
                    $display("Success a=%b, b=%b, s=%b, sum=%b", a, b, s, c);
                    $fwrite(n,"%b + %b = %b \n",a,b,c);
                end
                else begin
                    $display("Fail a=%b, b=%b, s=%b, sum=%b, expected=%b", a, b, s, c, expected);
                end
                a = i;
                b = j;
                s = 1'b1;
                if(a[2]==0 & b[2]==0 & a[1:0]>b[1:0]) begin
                    expected[3:0]=a[1:0]-b[1:0];
                    expected[4]=0;
                end
                if(a[2]==0 & b[2]==0 & a[1:0]<b[1:0]) begin
                    expected[3:0]=b[1:0]-a[1:0];
                    expected[4]=s;
                end
                if(a[2]==1 & b[2]==0) begin
                expected[3:0]=a[1:0]+b[1:0];
                expected[4]=1;
                end
                if(a[2]==0 & b[2]==1) begin
                expected[3:0]=a[1:0]+b[1:0];
                expected[4]=0;
                end
                if(a[2]==1 & b[2]==1 & a[1:0]>b[1:0]) begin
                expected[3:0]=a[1:0]-b[1:0];
                expected[4]=1;
                end
                if(a[2]==1 & b[2]==1 & a[1:0]<b[1:0]) begin
                expected[3:0]=b[1:0]-a[1:0];
                expected[4]=0;
                end
                if(a[2]==b[2] & b[1:0]==a[1:0]) begin
                expected=5'b00000;
                end
                #100;

                if (c == (expected)) begin
                    $display("Success a=%b, b=%b, s=%b, difference=%b", a, b, s, c);
                    $fwrite(n,"%b - %b = %b \n",a,b,c);
                end
                else
                    $display("Fail a=%b, b=%b, s=%b, difference=%b, expected=%b", a, b, s, c, expected);
            end
        end
        $fclose(n);
        $finish;
    end

endmodule
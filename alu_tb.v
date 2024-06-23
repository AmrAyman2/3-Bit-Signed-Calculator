module alu_tb;
    // inputs
    reg signed [2:0] a;
    reg signed [2:0] b;
    reg [1:0] s;
    // outputs
    wire signed [4:0] c;
    wire zeroflag;
    wire signflag;
    wire divbyzeroflag;

alu DUT(
    .a(a),
    .b(b),
    .s(s),
    .c(c),
    .divbyzeroflag(divbyzeroflag),
    .signflag(signflag),
    .zeroflag(zeroflag)
    );
reg [4:0] expected;
integer i, j,n;
reg divexpected;
    
initial begin
    n = $fopen("alu.txt","w");
        // iterate on all possible combinations
        for (i = -3; i < 4; i = i + 1) begin
            for (j = -3; j < 4; j = j + 1) begin
                a = i;
                b = j;
                s = 2'b00;
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
                    $display("Success a=%b, b=%b, s=%b, sum=%b, zero flag=%b, sign flag=%b", a, b, s, c,zeroflag,signflag);
                    $fwrite(n,"%b + %b = %b, zero flag=%b, sign flag=%b, dzf=%b \n",a,b,c,zeroflag,signflag,divbyzeroflag);
                end
                else begin
                    $display("Fail a=%b, b=%b, s=%b, sum=%b, expected=%b, zero flag=%b, sign flag=%b", a, b, s, c, expected,zeroflag,signflag);
                end
                a = i;
                b = j;
                s = 2'b01;
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
                    $display("Success a=%b, b=%b, s=%b, difference=%b, zero flag=%b, sign flag=%b", a, b, s, c,zeroflag,signflag);
                    $fwrite(n,"%b - %b = %b, zero flag=%b, sign flag=%b, dzf=%b \n",a,b,c,zeroflag,signflag,divbyzeroflag);
                end
                else begin
                    $display("Fail a=%b, b=%b, s=%b, difference=%b, expected=%b, zero flag=%b, sign flag=%b", a, b, s, c, expected,zeroflag,signflag);
                end

                s=2'b10;
                a[2:0] = i;
                b[2:0] = j;
                expected[3:0] = a[1:0] * b[1:0];
                expected[4] = (a[2] ^ b[2]) & ((a[0] | a[1]) & (b[1] | b[0]));
                #100;

                if(c==expected) begin
                $display("success a = %b, b = %b, product = %b, zero flag=%b, sign flag=%b", a, b, c,zeroflag,signflag);
                $fwrite(n,"%b * %b = %b, zero flag=%b, sign flag=%b, dzf=%b \n",a,b,c,zeroflag,signflag,divbyzeroflag);

                end
                else begin
                $display("fail a = %b, b = %b, product = %b, expected =%b, zero flag=%b, signflag=%b", a, b, c,expected,zeroflag,signflag);
                end
                a[2:0] = i;
                b[2:0] = j;
                s=2'b11;
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

                if(c==expected && divbyzeroflag==divexpected) begin
                $display("success a = %b, b = %b, remainder = %b divbyzero=%b, zero flag=%b, sign flag=%b", a, b, c,divbyzeroflag,zeroflag,signflag);
                $fwrite(n,"%b %% %b = %b, zero flag=%b, sign flag=%b, dzf=%b \n",a,b,c,zeroflag,signflag,divbyzeroflag);
                end
                else begin
                $display("fail a = %b, b = %b, remainder = %b, expected =%b, zero flag=%b, sign flag=%b", a, b, c,expected,zeroflag,signflag);
                end
        end
        end
        $fclose(n);
        $finish;
    end


endmodule
// module add_sub_tb;

//     // Inputs
//     reg [2:0] a;
//     reg [2:0] b;
//     reg s;

//     wire [3:0] c;
//     wire [2:0] cout;

//     add_sub DUT (
//         .a(a),
//         .b(b),
//         .s(s),
//         .c(c),
//         .cout(cout)
//     );

//     integer i, j, expected;
//     initial begin
//         // iterate on all possible combinations
//         for (i = -3; i < 3; i = i + 1) begin
//             for (j = -3; j < 3; j = j + 1) begin
//                 a = i;
//                 b = j;
//                 s = 1'b0;
//                 expected=a+b;
//                 #100;

//                 if (c == expected)
//                     $display("Success a=%b, b=%b, s=%b, c=%b", a, b, s, c);
//                 else
//                     $display("Fail a=%b, b=%b, s=%b, c=%b, expected=%d", a, b, s, c,expected);

//                 a = i;
//                 b = j;
//                 s = 1'b1;
//                 expected=a-b;
//                 #100;

//                 if (c == (expected))
//                     $display("Success a=%b, b=%b, s=%b, c=%b", a, b, s, c);
//                 else
//                     $display("Fail a=%b, b=%b, s=%b, c=%b, expected=%d", a, b, s, c,expected);
//             end
//         end
//         $finish;
//     end

// endmodule

module add_sub_tb;

    // inputs
    reg signed [2:0] a;
    reg signed [2:0] b;
    reg s;
    // outputs
    wire signed [3:0] c;
    wire [2:0] cout;

    add_sub DUT (
        .a(a),
        .b(b),
        .s(s),
        .c(c),
        .cout(cout)
        
    );

    integer i, j,expected;
    initial begin
        // iterate on all possible combinations
        for (i = -3; i < 3; i = i + 1) begin
            for (j = -3; j < 3; j = j + 1) begin
                a = i;
                b = j;
                s = 1'b0;
                expected=a+b;
                #100;

                if (c == expected)
                    $display("Success a=%0d, b=%0d, s=%0d, c=%0d", a, b, s, c);
                else
                    $display("Fail a=%0d, b=%0d, s=%0d, c=%0d, expected=%0d", a, b, s, c, expected);

                a = i;
                b = j;
                s = 1'b1;
                expected=a-b;
                #100;

                if (c == (expected))
                    $display("Success a=%d, b=%d, s=%d, c=%0d", a, b, s, c);
                else
                    $display("Fail a=%d, b=%d, s=%d, c=%0d, expected=%0d", a, b, s, c, expected);
            end
        end
        $finish;
    end

endmodule
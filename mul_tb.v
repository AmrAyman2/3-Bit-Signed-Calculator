module mul_tb;

    // Inputs
    reg signed [2:0] a, b;

    // Outputs
    wire signed [4:0] product;

    mul UUT (
        .a(a), 
        .b(b), 
        .product(product)
    );
    reg [4:0] expected;

integer i, j;
    initial begin
        // Iterate over all possible combinations of 3-bit inputs
        for (i = -3; i < 4; i = i + 1) begin
            for (j = -3; j < 4; j = j + 1) begin
                a[2:0] = i;
                b[2:0] = j;
                expected[3:0] = a[1:0] * b[1:0];
                expected[4] = (a[2] ^ b[2]) & ((a[0] | a[1]) & (b[1] | b[0]));
                #100;  // Wait for the output to stabilize

                // Print the inputs and the output
                if(product==expected) begin
                $display("success a = %b, b = %b, product = %b", a, b, product);
                end
                else begin
                $display("fail a = %b, b = %b, product = %b, expected =%b", a, b, product,expected);
                end
        end
        end
        // Finish the simulation
        $finish;
    end
      
endmodule
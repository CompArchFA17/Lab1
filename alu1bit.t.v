// 1 Bit alu test bench
`timescale 1 ns / 1 ps
`include "alu1bit.v"

module testALU1bit ();
  wire     out, cout;
  reg     a, b, cin;
  reg[2:0] op;
  integer i, j;

  ALU1bit alu (out,cout,a,b,cin,op);
  initial begin

    // Test ADD
    op=3'b000;
    // without cin
    cin = 0;
    for (i=0; i<2; i=i+1) begin
        for (j=0; j<2; j=j+1) begin
            a=i;b=j;#1000
            if ((a + b == out) & (a & b == cout)) begin
                $display("Passed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
            end
            else begin
                $display("Failed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
            end
        end
    end
    // with cin
    cin = 1;
    for (i=0; i<2; i=i+1) begin
        for (j=0; j<2; j=j+1) begin
            a=i;b=j;#1000
            if ((a ^ b == out) & (a | b == cout)) begin
                $display("Passed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
            end
            else begin
                $display("Failed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
            end
        end
    end

    // Test SUB
    op=3'b001;
    // without cin
    cin = 0;
    for (i=0; i<2; i=i+1) begin
        for (j=0; j<2; j=j+1) begin
            a=i;b=j;#1000
            if ((a - b == out) & (a < b == cout)) begin
                $display("Passed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
            end
            else begin
                $display("Failed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
            end
        end
    end
    // with cin
    cin = 1;
    for (i=0; i<2; i=i+1) begin
        for (j=0; j<2; j=j+1) begin
            a=i;b=j;#1000
            if ((a ~^ b == out) & (a > b == cout)) begin
                $display("Passed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
            end
            else begin
                $display("Failed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
            end
        end
    end


    // Test XOR
    op=3'b010; cin = 0;
    for (i=0; i<2; i=i+1) begin
        for (j=0; j<2; j=j+1) begin
            a=i;b=j;#1000
            if (a ^ b == out) begin
                $display("Passed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
            end
            else begin
                $display("Failed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
            end
        end
    end

    // Test SLT
    // TOOD: SLT tests

    // Test AND
    op=3'b100; cin = 0;
    for (i=0; i<2; i=i+1) begin
        for (j=0; j<2; j=j+1) begin
            a=i;b=j;#1000
            if (a & b == out) begin
                $display("Passed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
            end
            else begin
                $display("Failed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
            end
        end
    end

    // Test NAND
    op=3'b101; cin = 0;
    for (i=0; i<2; i=i+1) begin
        for (j=0; j<2; j=j+1) begin
            a=i;b=j;#1000
            if (~(a&b) == out) begin
                $display("Passed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
            end
            else begin
                $display("Failed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
            end
        end
    end

    // Test NOR
    op=3'b110; cin = 0;
    for (i=0; i<2; i=i+1) begin
        for (j=0; j<2; j=j+1) begin
            a=i;b=j;#1000
            if (a ~| b == out) begin
                $display("Passed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
            end
            else begin
                $display("Failed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
            end
        end
    end

    // Test OR
    op=3'b111; cin = 0;
    for (i=0; i<2; i=i+1) begin
        for (j=0; j<2; j=j+1) begin
            a=i;b=j;#1000
            if (a|b == out) begin
                $display("Passed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
            end
            else begin
                $display("Failed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
            end
        end
    end

    end
endmodule

// 1 Bit alu test bench
`timescale 1 ns / 1 ps
`include "alu.v"

module testALU ();
  wire[31:0] out;
  wire       zero, overflow, cout;
  reg[31:0]  a, b;
  reg[2:0]   op;

  integer passed_tests = 0;
  integer tests = 0;

  ALU alu (out,cout,zero,overflow,a,b,op);

  function integer test;
    input test_case;
    integer test_case;
    input show_extras;
    begin
      if (test_case) begin
        test = 1;
        $display("Passed test with:");
      end
      else begin
        test = 0;
        $display("Failed test with:");
      end
      $display("a:   %b", a);
      $display("b:   %b", b);
      $display("out: %b", out);
      if (show_extras) begin
        $display("Cout: %b, Overflow: %b", cout, overflow);
      end
    end
  endfunction


  initial begin
    $dumpfile("alu.vcd");
    $dumpvars;

    // Test Add
    $display("\nAddition");
    $display("-----------------------------------------------------------------");
    op=3'b000;
    a=32'b00000000000011111111111111111111; b=32'b0000000000000000000000000000001;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(((a + b) == out) && (overflow == 0) && (cout == 0), 1);

    a=32'b11111111111111111111111111111111; b=32'b0000000000000000000000000000000;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(((a + b) == out) && (overflow == 0) && (cout == 0), 1);

    a=32'b11111111111111111111111111111111; b=32'b0000000000000000000000000000001;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(((a + b) == out) && (overflow == 0) && (cout == 1), 1);

    // Overflow
    a=32'b10110000000000000000000000000000; b=32'b11000000000000000000000000000001;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(((a + b) == out) && (overflow == 1), 1);

    a=32'b10000000000000001100011010101100; b=32'b11000000000010101010000000000001;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(((a + b) == out) && (overflow == 1), 1);

    // Test Subtract
    $display("Subtraction");
    $display("-----------------------------------------------------------------");
    op=3'b001;
    a=32'b00000000000011111111111111111111; b=32'b0000000000000000000000000000001;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(((a - b) == out) && (overflow == 0) && (cout == 0), 1);

    a=32'b11111111111111111111111111111111; b=32'b0000000000000000000000000000000;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(((a - b) == out) && (overflow == 0) && (cout == 0), 1);

    a=32'b10110000000000000000000000000000; b=32'b11000000000000000000000000000001;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(((a - b) == out) && (overflow == 0), 1);

    a=32'b10000000000000001100011010101100; b=32'b11000000000010101010000000000001;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(((a - b) == out) && (overflow == 0), 1);

    a=32'b01000000000000000000000000000000; b=32'b10000000000010101010000000000001;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(((a - b) == out) && (overflow == 1), 1);

    a=32'b10000000000000000000000000000000; b=32'b01000000000010101010000000000001;#1000
    tests = tests + 1;
    passed_tests = passed_tests + test(((a - b) == out) && (overflow == 1), 1);

    // Test XOR
    $display("\nXOR");
    $display("-----------------------------------------------------------------");
    op=3'b010;
    $display("op: %b", op);
    a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000001;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test((a ^ b) == out, 0);

    // Test SLT
    $display("\nSLT");
    $display("-----------------------------------------------------------------");
    op=3'b011;
    $display("op: %b", op);
    // SLT(a,b) = 1 where a<b
    a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000010;#2000
    tests = tests + 1;

    passed_tests = passed_tests + test(out == 1, 1);
    // SLT(a,b) = 0 where a>b
    a=32'b00000000000000000000000000001000; b=32'b00000000000000000000000000000010;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(out == 0, 1);

    // SLT(a,b) = 1 where a(is negative)<b(is positive)
    a=32'b10000000000000000000000000001000; b=32'b00000000000000000000000000000010;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(out == 1, 1);
    // SLT(a,b) = 0 where a(is positive)>b(is negative)
    a=32'b00000000000000000000000000001000; b=32'b10000000000000000000000000000010;#2000
    tests = tests + 1;

    passed_tests = passed_tests + test(out == 0, 1);
    // SLT(a,b) = 1 where a(is negative)>b(is negative)
    a=32'b10000000000000000000000000001000; b=32'b10000000000000000000001000000000;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(out == 1, 1);

    // SLT(a,b) = 1 where a(is negative)>b(is negative)
    a=32'b10000000000000000000000000001000; b=32'b00000000001000000000000000000000;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(out == 1, 1);

    // small pos / large pos = 1
    a=32'b00000000000000000000000000001000; b=32'b01110000001000000000000000000000;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(out == 1, 1);
    // large pos / small pos = 0
    a=32'b01110000000000000000000000001000; b=32'b00000000001000000000000000000000;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(out == 0, 1);
    // equal positives = 0
    a=32'b01110000000000000000000000001000; b=32'b01110000000000000000000000000000;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(out == 0, 1);

    // small neg / large neg = 0
    a=32'b11111111000000000000000000001000; b=32'b10000000000000000000000000000111;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(out == 0, 1);
    // large neg / small neg = 1
    a=32'b10000000000000000000000000000111; b=32'b11111111000000000000000000001000;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(out == 1, 1);
    // equal negatives = 0
    a=32'b10000000000000000000000000000111; b=32'b10000000000000000000000000000111;#2000
    tests = tests + 1;
    passed_tests = passed_tests + test(out == 0, 1);

    // positive overflow: large pos / large neg : 0
    a=32'b01000000000000000000000000000001; b=32'b10000000000000000000000000010000;#1000
    tests = tests + 1;
    passed_tests = passed_tests + test(out == 0, 1);
    // negative overflow: large neg / large pos : 1
    a=32'b10000000000000000000000000000001; b=32'b00000100000000000000000000000000;#1000
    tests = tests + 1;
    passed_tests = passed_tests + test(out == 1, 1);

    a=32'b00000000000000000000000000001000; b=32'b00000000001000000000000000000000;#1000
    tests = tests + 1;
    passed_tests = passed_tests + test(out == 1, 1);

    a=32'b0010000000000000000-000000000001; b=32'b10000000000000000000000000000000;#1000
    tests = tests + 1;
    passed_tests = passed_tests + test(out == 0, 1);


    $display("%2d/%2d Test Cases Passed", passed_tests, tests);

    end
endmodule

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

  initial begin


    // Test XOR
    op=3'b010;
    a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000001;#1000
    tests = tests + 1;
    if ((a ^ b) == out) begin
        passed_tests = passed_tests + 1;
        $display("Passed test with op: %b", op);
    end
    else begin
        $display("Failed test with op: %b", op);
    end
    $display("a:   %b", a);
    $display("b:   %b", b);
    $display("out: %b", out);
    
    // Test SLT
    op=3'b011;
    a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000010;#1000
    tests = tests + 1;
    if ((a < b) == out) begin
        passed_tests = passed_tests + 1;
        $display("Passed test with op: %b", op);
    end
    else begin
        $display("Failed test with op: %b", op);
    end
    $display("a:   %b", a);
    $display("b:   %b", b);
    $display("out: %b", out);


    $display("%2d/%2d Test Cases Passed", passed_tests, tests);

    end
endmodule

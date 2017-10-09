// 1 Bit alu test bench
`timescale 1 ns / 1 ps
`include "alu.v"

module testALU ();
  wire[31:0] out, a, b;
  reg        zero, overflow, cout;
  reg[2:0]   op;

  integer passed_tests = 0;
  integer tests = 0;

  ALU alu (out,cout,zero,overflow,a,b,op);

  initial begin


    // Test XOR
    op=3'b010;
    a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000000;#1000
    tests = tests + 1;
    $display("                  op   a  b cin|out cout ");
    if ((a ^ b) == out) begin
        passed_tests = passed_tests + 1;
        $display("Passed test with: %b  %b  %b | %b  %b", op, a, b, out, cout);
    end
    else begin
        $display("Failed test with: %b  %b  %b | %b  %b*", op, a, b, out, cout);
    end


    $display("%2d/%2d Test Cases Passed", passed_tests, tests);

    end
endmodule

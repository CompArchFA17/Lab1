`timescale 1 ns / 1 ps
`include "alu.v"

module testALU();
    reg signed[31:0] a;
    reg signed[31:0] b;
    reg[2:0]    command;
    wire        carryout;
    wire        zero;
    wire        overflow;
    wire signed[31:0]  result;

    ALU dut(result, carryout, zero, overflow, a, b, command);

    initial begin
      command = 3'd2;
      a = -4;
      b = -4; #10000000
      $display("%d %d %d", a, b, result);
      a = -3;
      b = -4; #10000000
      $display("%d %d %d", a, b, result);
      a = -4;
      b = -3; #10000000
      $display("%d %d %d", a, b, result);
      a = 4;
      b = 4; #10000000
      $display("%d %d %d", a, b, result);
      a = 3;
      b = 4; #10000000
      $display("%d %d %d", a, b, result);
      a = 4;
      b = 3; #10000000
      $display("%d %d %d", a, b, result);
      a = 3;
      b = 0; #10000000
      $display("%d %d %d", a, b, result);
      a = 0;
      b = 3; #10000000
      $display("%d %d %d", a, b, result);
      a = -3;
      b = 0; #10000000
      $display("%d %d %d", a, b, result);
      a = 0;
      b = -3; #10000000
      $display("%d %d %d", a, b, result);
      a = 4;
      b = -3; #10000000
      $display("%d %d %d", a, b, result);
      a = -4;
      b = 3; #10000000
      $display("%d %d %d", a, b, result);
    end
endmodule

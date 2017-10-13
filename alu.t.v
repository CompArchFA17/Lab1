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
      $dumpfile("alu.vcd");
      $dumpvars(0, testALU);
        command = 3'd0;
        a = -4;
        b = 4; #1000000
        if (result != 0 || overflow || !zero) begin
            $display("FAIL %d %d %d |cmd: %d |ovf: %d |0: %d |co: %d", a, b, result, command, overflow, zero, carryout);
        end
        a = 31'h7fffffff;
        b = 1; #1000000
        if (result != 31'h80000000 || !overflow || zero) begin
            $display("FAIL %d %d %d |cmd: %d |ovf: %d |0: %d |co: %d", a, b, result, command, overflow, zero, carryout);
        end

        command = 3'd1;
        a = 4;
        b = 4; #1000000
        if (result != 0 || overflow || !zero) begin
            $display("FAIL %d %d %d |cmd: %d |ovf: %d |0: %d |co: %d", a, b, result, command, overflow, zero, carryout);
        end
        a = 31'h80000000;
        b = 1; #1000000
        if (result != 31'h7fffffff || !overflow || zero) begin
            $display("FAIL %d %d %d |cmd: %d |ovf: %d |0: %d |co: %d", a, b, result, command, overflow, zero, carryout);
        end
    end
endmodule

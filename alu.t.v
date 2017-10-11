`timescale 1 ns / 1 ps
`include "alu.v"

`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

module testALU():
    reg [31:0] operandA;
    reg [31:0] operandB;
    reg [2:0] command;
    wire [31:0] result;
    wire carryout;
    wire zero;
    wire overflow;

    ALU alu (result, carryout, zero, overflow, operandA, operandB, command);

    initial begin
    $display("testing ADD")

    $display("operandA operandB command | result carryout zero overflow | expected outputs");
    
    a=32'b00000000000000000000000000000010;b=32'b00000000000000000000000000000001;c=ADD; #1000
    $display("%b  %b  %b  |  %b  %b  %b  %b | 00000000000000000000000000000011  0  0  0", result, carryout, zero, overflow);

    a=32'b11111111111111111111111111111111;b=32'b11111111111111111111111111111111;c=ADD; #1000
    $display("%b  %b  %b  |  %b  %b  %b  %b | 11111111111111111111111111111110 1 0 0", result, carryout, zero, overflow);

    a=32'b00000000000000000000000000000000;b=32'b00000000000000000000000000000000;c=ADD; #1000
    $display("%b  %b  %b  |  %b  %b  %b  %b | 00000000000000000000000000000000 0 1 0", result, carryout, zero, overflow);

    a=32'b01111111111111111111111111111111;b=32'b00000000000000000000000000000001;c=ADD; #1000
    $display("%b  %b  %b  |  %b  %b  %b  %b | 10000000000000000000000000000000  0  0  1", result, carryout, zero, overflow);

    $display("testing SUB")

    a=32'b00000000000000000000000000000011;b=32'b00000000000000000000000000000001;c=SUB; #1000
    $display("%b  %b  %b  |  %b  %b  %b  %b  |  00000000000000000000000000000010  0  0  0", result, carryout, zero, overflow);

    a=32'b10000000000000000000000000000000;b=32'b00000000000000000000000000000001;c=SUB; #1000
    $display("%b  %b  %b  |  %b  %b  %b  %b  |  01111111111111111111111111111111  1  0  1", result, carryout, zero, overflow);

    a=32'b00000000000000000000000000000000;b=32'b00000000000000000000000000000000;c=SUB; #1000
    $display("%b  %b  %b  |  %b  %b  %b  %b  |  00000000000000000000000000000000  0  1  0", result, carryout, zero, overflow);

    a=32'hFFFFFFFF;b=32'hFFFFFFFF;c=SUB; #1000
    $display("%b  %b  %b  |  %b  %b  %b  %b  |  32'h00000000  1  1  0", result, carryout, zero, overflow);

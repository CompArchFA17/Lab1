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
    
    a=32'h00000002;b=32'h00000001;c=ADD; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     | 00000000000000000000000000000011  0  0  0", result, carryout, zero, overflow);

    a=32'hFFFFFFFF;b=32'hFFFFFFFF;c=ADD; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     | 11111111111111111111111111111110 1 0 0", result, carryout, zero, overflow);

    a=32'h00000000;b=32'h00000000;c=ADD; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     | 00000000000000000000000000000000 0 1 0", result, carryout, zero, overflow);

    a=32'h7FFFFFFF;b=32'h00000001;c=ADD; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     | 10000000000000000000000000000000  0  0  1", result, carryout, zero, overflow);

    $display("testing SUB")

    a=32'h00000003;b=32'h00000001;c=SUB; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  00000000000000000000000000000010  0  0  0", result, carryout, zero, overflow);

    a=32'h80000000;b=32'h00000001;c=SUB; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  01111111111111111111111111111111  1  0  1", result, carryout, zero, overflow);

    a=32'h00000000;b=32'h00000000;c=SUB; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  00000000000000000000000000000000  0  1  0", result, carryout, zero, overflow);

    a=32'hFFFFFFFF;b=32'hFFFFFFFF;c=SUB; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  32'h00000000  1  1  0", result, carryout, zero, overflow);

    $display("testing XOR")
    
    a=32'hAA550055;b=32'hAAFF55AA;c=XOR; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  00000000101010100101010111111111  0  0  0", result, carryout, zero, overflow);
    
    a=32'hFF00FF00;b=32'h00FF00FF;c=XOR; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  11111111111111111111111111111111  0  0  0", result, carryout, zero, overflow);

    $display("testing SLT")

    a=32'h555555AA;b=32'h55AA55AA;c=SLT; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  00000000000000000000000000000001  0  0  0", result, carryout, zero, overflow);

    a=32'h555555AA;b=32'h555555AA;c=SLT; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  00000000000000000000000000000000  0  0  0", result, carryout, zero, overflow);

    a=32'h00FF00FF;b=32'hFF00FF00;c=SLT; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  00000000000000000000000000000000  0  0  0", result, carryout, zero, overflow);

    a=32'hFFFFFF00;b=32'h0000FFFF;c=SLT; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  00000000000000000000000000000001  0  0  0", result, carryout, zero, overflow);

    a=32'hAAAA55AA;b=32'hAA5555AA;c=SLT; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  00000000000000000000000000000001  0  0  0", result, carryout, zero, overflow);

    a=32'hFF55FF00;b=32'hFFFF5500;c=SLT; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  00000000000000000000000000000000  0  0  0", result, carryout, zero, overflow);

    a=32'hFF55FF00;b=32'hFFFF5500;c=SLT; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  00000000000000000000000000000001  0  0  0", result, carryout, zero, overflow);

    $display("testing AND")

    a=32'hFF00FF00;b=32'h00FF00FF;c=AND; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  00000000000000000000000000000001  0  0  0", result, carryout, zero, overflow);

    a=32'hFF00AA55;b=32'hAAAA55AA;c=AND; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  10101010000000000000000000000001  0  0  0", result, carryout, zero, overflow);

    $display("testing NAND")

    a=32'hFF00FF00;b=32'h00FF00FF;c=NAND; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  11111111111111111111111111111111  0  0  0", result, carryout, zero, overflow);

    a=32'hFF00AA55;b=32'hAAAA55AA;c=NAND; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  01010101111111111111111111111111  0  0  0", result, carryout, zero, overflow);

    $display("testing NOR")

    a=32'h55550055;b=32'hAAFF55AA;c=NOR; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  00000000000000000101010100000000  0  0  0", result, carryout, zero, overflow);

    a=32'hFF00FF00;b=32'h00FF00FF;c=NOR; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  00000000000000000000000000000000  0  0  0", result, carryout, zero, overflow);

    $display("testing OR")

    a=32'h55FFAA00;b=32'hAAAA55AA;c=OR; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  11111111111111111111111111111111  0  0  0", result, carryout, zero, overflow);

    a=32'hFF00FF00;b=32'h00FF00FF;c=OR; #1000
    $display("%b       %b      %b     |  %b    %b     %b   %b     |  11111111111111111111111111111111  0  0  0", result, carryout, zero, overflow);

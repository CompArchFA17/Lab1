`timescale 1 ns / 1 ps

`include "alu.v"

module testALU();
    reg [31:0] a;
    reg [31:0] b;
    reg [2:0] c;
    wire [31:0] result;
    wire carryout;
    wire zero;
    wire overflow;

    ALU alu (result, carryout, zero, overflow, a, b, c);

    initial begin
    $display("testing ADD");

    $display("operandA operandB command |              result             carryout zero overflow| expected outputs");
    
    a=32'h00000002;b=32'h00000001;c=``ADD; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 00000000000000000000000000000011  0  0  0", a, b, c, result, carryout, zero, overflow);

    a=32'hFFFFFFFF;b=32'hFFFFFFFF;c=``ADD; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 11111111111111111111111111111110  1  0  0", a, b, c, result, carryout, zero, overflow);

    a=32'h00000000;b=32'h00000000;c=`ADD; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 00000000000000000000000000000000  0  1  0", a, b, c, result, carryout, zero, overflow);

    a=32'h7FFFFFFF;b=32'h00000001;c=`ADD; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 10000000000000000000000000000000  0  0  1", a, b, c, result, carryout, zero, overflow);

    $display("testing SUB");

    a=32'h00000003;b=32'h00000001;c=`SUB; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 00000000000000000000000000000010  0  0  0", a, b, c, result, carryout, zero, overflow);

    a=32'h80000000;b=32'h00000001;c=`SUB; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 01111111111111111111111111111111  1  0  1", a, b, c, result, carryout, zero, overflow);

    a=32'h00000000;b=32'h00000000;c=`SUB; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 00000000000000000000000000000000  0  1  0", a, b, c, result, carryout, zero, overflow);

    a=32'hFFFFFFFF;b=32'hFFFFFFFF;c=`SUB; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 00000000000000000000000000000000  1  1  0", a, b, c, result, carryout, zero, overflow);

    $display("testing XOR");
    
    a=32'hAA550055;b=32'hAAFF55AA;c=`XOR; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 00000000101010100101010111111111  0  0  0", a, b, c, result, carryout, zero, overflow);
    
    a=32'hFFFF0000;b=32'h00FF00FF;c=`XOR; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 11111111000000000000000011111111  0  0  0", a, b, c, result, carryout, zero, overflow);

    $display("testing SLT");

    a=32'h555555AA;b=32'h55AA55AA;c=`SLT; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 00000000000000000000000000000001  0  0  0", a, b, c, result, carryout, zero, overflow);

    a=32'h555555AA;b=32'h555555AA;c=`SLT; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 00000000000000000000000000000000  0  0  0", a, b, c, result, carryout, zero, overflow);

    a=32'h00FF00FF;b=32'hFF00FF00;c=`SLT; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 00000000000000000000000000000000  0  0  0", a, b, c, result, carryout, zero, overflow);

    a=32'hFFFFFF00;b=32'h0000FFFF;c=`SLT; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 00000000000000000000000000000001  0  0  0", a, b, c, result, carryout, zero, overflow);

    a=32'hAAAA55AA;b=32'hAA5555AA;c=`SLT; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 00000000000000000000000000000001  0  0  0", a, b, c, result, carryout, zero, overflow);

    a=32'hFF55FF00;b=32'hFFFF5500;c=`SLT; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 00000000000000000000000000000000  0  0  0", a, b, c, result, carryout, zero, overflow);

    a=32'hFF55FF00;b=32'hFFFF5500;c=`SLT; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 00000000000000000000000000000001  0  0  0", a, b, c, result, carryout, zero, overflow);

    $display("testing AND");

    a=32'hFFFF0000;b=32'h00FF00FF;c=`AND; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 00000000111111110000000000000000  0  0  0", a, b, c, result, carryout, zero, overflow);

    a=32'hFF00AA55;b=32'hAAAA55AA;c=`AND; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 10101010000000000000000000000000  0  0  0", a, b, c, result, carryout, zero, overflow);

    $display("testing NAND");

    a=32'hFFFF0000;b=32'h00FF00FF;c=`NAND; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 11111111000000001111111111111111  0  0  0", a, b, c, result, carryout, zero, overflow);

    a=32'hFF00AA55;b=32'hAAAA55AA;c=`NAND; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 01010101111111111111111111111111  0  0  0", a, b, c, result, carryout, zero, overflow);

    $display("testing NOR");

    a=32'h55550055;b=32'hAAFF55AA;c=`NOR; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 00000000000000000101010100000000  0  0  0", a, b, c, result, carryout, zero, overflow);

    a=32'hFFFF0000;b=32'h00FF00FF;c=`NOR; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 00000000111111110000000000000000  0  0  0", a, b, c, result, carryout, zero, overflow);

    $display("testing OR");

    a=32'h55FFAA00;b=32'hAAAA55AA;c=`OR; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 11111111111111111111111110101010  0  0  0", a, b, c, result, carryout, zero, overflow);

    a=32'hFFFF0000;b=32'h00FF00FF;c=`OR; #1000000
    $display("%h %h %h       | %b    %b     %b   %b       | 11111111111111110000000011111111  0  0  0", a, b, c, result, carryout, zero, overflow);
    end
endmodule
// Adder_subtacter testbench

`timescale 1 ns / 1 ps
`include "adder_subtracter.v"

module test32bitAdder();
    reg[31:0] a;
    reg[31:0] b;
    reg[2:0] carryin;
    wire[31:0] ans;
    wire carryout, overflow;

    adder_subtracter adder0(ans[31:0], carryout, overflow, a[31:0], b[31:0], carryin[2:0]);

    initial begin
       $display("Input A                          Input B                          Command | Output                         Flag  Carryout");

        // Addition tests
        a=32'b00000000000000000000000000000001;
        b=32'b00000000000000000000000000000001;
        carryin=3'b100; #5000 
        $display("%b  %b  %b |  %b  %b    %b", a[31:0],b[31:0],carryin,ans[31:0],carryout, overflow);

        a=32'b10000000000000000000000000000001;
        b=32'b10000000000000000000000000000001;
        carryin=3'b000; #5000 
        $display("%b  %b  %b |  %b  %b    %b", a[31:0],b[31:0],carryin,ans[31:0],carryout, overflow);

        // Subtraction Tests
        a=32'b00000000000000000000000000000001;
        b=32'b00000000000000000000000000000001;
        carryin=3'b001; #5000 
        $display("%b  %b  %b |  %b  %b    %b", a[31:0],b[31:0],carryin,ans[31:0],carryout, overflow);

        a=32'b00000000001000000000000000000000;
        b=32'b00000000000000000000000010000000;
        carryin=3'b001; #5000 
        $display("%b  %b  %b |  %b  %b    %b", a[31:0],b[31:0],carryin,ans[31:0],carryout, overflow);

        a=32'b10000000001000010000000000000000;
        b=32'b10000000000000010000000010000000;
        carryin=3'b001; #5000 
        $display("%b  %b  %b |  %b  %b    %b", a[31:0],b[31:0],carryin,ans[31:0],carryout, overflow);

        a=32'b10000000000000000000000000000001;
        b=32'b10000000000000000000000000000001;
        carryin=3'b001; #5000 
        $display("%b  %b  %b |  %b  %b    %b", a[31:0],b[31:0],carryin,ans[31:0],carryout, overflow);

        a=32'b00000000000000000000000000000000;
        b=32'b10000000000000000000000000000001;
        carryin=3'b001; #5000 
        $display("%b  %b  %b |  %b  %b    %b", a[31:0],b[31:0],carryin,ans[31:0],carryout, overflow);

        a=32'b10000000000000000000000000000001;
        b=32'b10000000000000000000000000000001;
        carryin=3'b000; #5000 
        $display("%b  %b  %b |  %b  %b    %b", a[31:0],b[31:0],carryin,ans[31:0],carryout, overflow);
    end
endmodule
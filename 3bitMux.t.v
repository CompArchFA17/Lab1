`define NANDgate nand #10
`define ANDgate and #20
`define NORgate nor #10
`define ORgate  or  #20
`define NOTgate not #10
`define XORgate xor #30

`timescale 1 ns / 1 ps
`include "3bitMux.v"

module test3BitMux ();
    reg[2:0] addr;
    reg[7:0] inputs;
    wire out;

    threeBitMux mux (out, addr, inputs);

    initial begin
    $display("addr inputs | Output");
    addr=3'b000;inputs=8'b00010000; #1000
    $display("%b    %b | %b", addr, inputs, out);
    addr=3'b000;inputs=8'b10000001; #1000
    $display("%b    %b | %b", addr, inputs, out);
    addr=3'b000;inputs=8'b00000000; #1000
    $display("%b    %b | %b", addr, inputs, out);
    addr=3'b011;inputs=8'b01000001; #1000
    $display("%b    %b | %b", addr, inputs, out);
    addr=3'b010;inputs=8'b00001101; #1000
    $display("%b    %b | %b", addr, inputs, out);
    end
endmodule

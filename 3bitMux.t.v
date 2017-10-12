`timescale 1 ns / 1 ps
`include "3bitMux.v"

module test3BitMux ();
    reg s0, s1, s2;
    reg[7:0] inputs;
    wire out;

    threeBitMux mux (out, s0, s1, s2, inputs);

    initial begin
    $display("s0 s1 s2 inputs | Output");
    s0=0;s1=0;s2=0;inputs=8'b00010000; #1000
    $display("%b %b %b %b | %b", s0, s1, s2, inputs, out);
    s0=0;s1=0;s2=0;inputs=8'b10000001; #1000
    $display("%b %b %b %b | %b", s0, s1, s2, inputs, out);
    s0=0;s1=0;s2=0;inputs=8'b00000000; #1000
    $display("%b %b %b %b | %b", s0, s1, s2, inputs, out);
    s0=0;s1=1;s2=1;inputs=8'b01000001; #1000
    $display("%b %b %b %b | %b", s0, s1, s2, inputs, out);
    s0=0;s1=1;s2=0;inputs=8'b00001101; #1000
    $display("%b %b %b %b | %b", s0, s1, s2, inputs, out);
    end
endmodule

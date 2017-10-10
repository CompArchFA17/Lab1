// Multiplexer testbench
`timescale 1 ns / 1 ps
`include "multiplexer.v"

module testMultiplexer ();
    reg[2:0] address;
    reg[7:0] in;
    reg na;
    wire out;
    //behavioralMultiplexer decoder (out, addr0, addr1, in0, in1, in2, in3);
    structuralMultiplexer decoder (out, address, in); // Swap after testing

    initial begin
    $dumpfile("multiplexer.vcd");
    $dumpvars(0, address, in, out);
    $display("A0 A1 | I0 I1 I2 I3 | Out ");
    address = 0; #1000
    $display(" %b  %b |  %b  %b  %b  %b |   %b ", address[0], address[1], in[0], in[1], in[2], in[3], out);
    in[0] = 0;
    address = 0; #1000
    $display(" %b  %b |  %b  %b  %b  %b |   %b ", address[0], address[1], in[0], in[1], in[2], in[3], out);
    in[0] = 1;
    address = 0; #1000
    $display(" %b  %b |  %b  %b  %b  %b |   %b ", address[0], address[1], in[0], in[1], in[2], in[3], out);
    in[0] = na;
    in[1] = 0;
    address = 1; #1000
    $display(" %b  %b |  %b  %b  %b  %b |   %b ", address[0], address[1], in[0], in[1], in[2], in[3], out);
    in[1] = 1;
    address = 1; #1000
    $display(" %b  %b |  %b  %b  %b  %b |   %b ", address[0], address[1], in[0], in[1], in[2], in[3], out);
    in[1] = na;
    in[2] = 0;
    address = 2; #1000
    $display(" %b  %b |  %b  %b  %b  %b |   %b ", address[0], address[1], in[0], in[1], in[2], in[3], out);
    in[2] = 1;
    address = 2; #1000
    $display(" %b  %b |  %b  %b  %b  %b |   %b ", address[0], address[1], in[0], in[1], in[2], in[3], out);
    end
endmodule

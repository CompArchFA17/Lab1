// Intermediate testbench
`timescale 1 ns / 1 ps
`include "alu.v"

module testMultiplexer ();

wire AndNandOut;
reg A, B;
reg[2:0] Command; 

    AndNand newpotato(AndNandOut, A, B, Command); 

initial begin

    $display("A B| Command |output command?| Expected Output");
    A=1;B=1;Command=3'b000; #1000 
    $display("%b  %b |   %b |  %b  %b | 1", A, B, Command, Command[0], AndNandOut);
    A=1;B=1;Command=3'b000; #1000 
    $display("%b  %b |   %b |  %b  %b | 0", A, B, Command, Command[1], AndNandOut);
    A=1;B=1;Command=3'b000; #1000 
    $display("%b  %b |   %b |  %b  %b | 0", A, B, Command, Command[2], AndNandOut);

    end


endmodule

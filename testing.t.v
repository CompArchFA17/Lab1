// Intermediate testbench
`timescale 1 ns / 1 ps
`include "alu.v"

module testMultiplexer ();

wire AndNandOut;
reg A, B;
reg[2:0] Command;
reg S;

    AndNand newpotato(AndNandOut, A, B, Command); 

	OrNorXor ortest(OrNorXorOut, A, B, Command);
initial begin

// Exhaustively testing AND/NAND 
    $display("A B| Command | command0 Output | Expected Output - AND TESTS");
    A=1;B=1;Command=3'b000; #1000 
    $display("%b  %b |   %b |  %b  %b | 1", A, B, Command, Command[0], AndNandOut);
    A=1;B=1;Command=3'b001; #1000 
    $display("%b  %b |   %b |  %b  %b | 0", A, B, Command, Command[1], AndNandOut);
    A=0;B=1;Command=3'b000; #1000 
    $display("%b  %b |   %b |  %b  %b | 0", A, B, Command, Command[0], AndNandOut);
    A=1;B=0;Command=3'b001; #1000 
    $display("%b  %b |   %b |  %b  %b | 1", A, B, Command, Command[1], AndNandOut);


// Exhaustively testing OR/NOR/XOR
    $display("A B | Command | Output | Expected Output - OR TESTS");
	A=1; B=1; Command=3'b111; #1000
	$display("%b %b |    %b  |  %b   | 1 - OR TEST", A, B, Command, OrNorXorOut);
	A=1; B=0; Command=3'b111; #1000
	$display("%b %b |    %b  |  %b   | 1 - OR TEST", A, B, Command, OrNorXorOut);
	A=0; B=1; Command=3'b111; #1000
	$display("%b %b |    %b  |  %b   | 1 - OR TEST", A, B, Command, OrNorXorOut);
	A=0; B=0; Command=3'b111; #1000
	$display("%b %b |    %b  |  %b   | 0 - OR TEST", A, B, Command, OrNorXorOut);


	A=1; B=1; Command=3'b110; #1000
	$display("%b %b |    %b  |  %b   | 0 - NOR TEST", A, B, Command, OrNorXorOut);
	A=1; B=0; Command=3'b110; #1000
	$display("%b %b |    %b  |  %b   | 0 - NOR TEST", A, B, Command, OrNorXorOut);
	A=0; B=1; Command=3'b110; #1000
	$display("%b %b |    %b  |  %b   | 0 - NOR TEST", A, B, Command, OrNorXorOut);
	A=0; B=0; Command=3'b110; #1000
	$display("%b %b |    %b  |  %b   | 1 - NOR TEST", A, B, Command, OrNorXorOut);

	A=1; B=1; Command=3'b010; #1000
	$display("%b %b |    %b  |  %b   | 0 - XOR TEST", A, B, Command, OrNorXorOut);
	A=1; B=0; Command=3'b010; #1000
	$display("%b %b |    %b  |  %b   | 1 - XOR TEST", A, B, Command, OrNorXorOut);
	A=0; B=1; Command=3'b010; #1000
	$display("%b %b |    %b  |  %b   | 1 - XOR TEST", A, B, Command, OrNorXorOut);
	A=0; B=0; Command=3'b010; #1000
	$display("%b %b |    %b  |  %b   | 0 - XOR TEST", A, B, Command, OrNorXorOut);

    end


endmodule

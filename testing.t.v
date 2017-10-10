// Intermediate testbench
`timescale 1 ns / 1 ps
`include "alu.v"


module testBasicFunctions();
// we begin by testing the basic AND/NAND, OR/NOR/XOR, and ADD/SUB/SLT modules
wire AndNandOut;
reg A, B;
reg[2:0] Command;
//reg S;
wire OneBitFinalOut;
wire AddSubSLTSum, carryout, subtract; //overflow - we don't calculate overflow except with the most significant bit, so we don't worry about it here
reg carryin;
wire OrNorXorOut;
reg S0, S1;
reg in0, in1, in2, in3;
wire muxout;
// test mux functionality: 	
	FourInMux testmux(muxout, S0, S1, in0, in1, in2, in3);
// test ADD/SUB/SLT
	MiddleAddSubSLT testadd(AddSubSLTSum, carryout, subtract, A, B, Command, carryin);
// test AND/NAND
    AndNand testand(AndNandOut, A, B, Command); 
// test OR/NOR/XOR
	OrNorXor testor(OrNorXorOut, A, B, Command);
initial begin
// test mux
	$display("Four Input Multiplexer");
	$display("S0 S1 |in0 in1 in2 in3| Output");
	S0 = 0; S1 = 0; in0 = 1'bx; in1 = 0; in2 = 0; in3 = 0; #1000
	$display(" %b %b  | %b   %b   %b   %b | %b", S0, S1, in0, in1, in2, in3, muxout);
	S0 = 1; S1 = 0; in0 = 0; in1 = 1'bx; in2 = 0; in3 = 0; #1000
	$display(" %b %b  | %b   %b   %b   %b | %b", S0, S1, in0, in1, in2, in3, muxout);
	S0 = 0; S1 = 1; in0 = 0; in1 = 0; in2 = 1'bx; in3 = 0; #1000
	$display(" %b %b  | %b   %b   %b   %b | %b", S0, S1, in0, in1, in2, in3, muxout);
	S0 = 1; S1 = 1; in0 = 0; in1 = 0; in2 = 0; in3 = 1'bx; #1000
	$display(" %b %b  | %b   %b   %b   %b | %b", S0, S1, in0, in1, in2, in3, muxout);
// just the adder - proper behavior
	$display("Adder/Subtractor");
    $display("A B | Command |Out|ExpectOut|Carryout-Add");
	// adding
    A=1;B=1;Command=3'b000; carryin = 0; #1000 
    $display("%b  %b |   %b |  %b | 0 | %b", A, B, Command, AddSubSLTSum, carryout);
    A=1;B=0;Command=3'b000; carryin = 0; #1000 
    $display("%b  %b |   %b |  %b | 1 | %b", A, B, Command, AddSubSLTSum, carryout);
    A=0;B=1;Command=3'b000; carryin = 0; #1000 
    $display("%b  %b |   %b |  %b | 1 | %b", A, B, Command, AddSubSLTSum, carryout);   					 
	A=0;B=0;Command=3'b000; carryin = 0; #1000 
    $display("%b  %b |   %b |  %b | 0 | %b", A, B, Command, AddSubSLTSum, carryout);
	// subtracting - carrying must be set to 1 for subtraction
    $display("A B | Command |Out|ExpectOut|Carryout-Sub");
    A=1;B=1;Command=3'b001; carryin = 1; #1000 
    $display("%b  %b |   %b |  %b | 0 | %b", A, B, Command, AddSubSLTSum, carryout);
    A=1;B=0;Command=3'b001; carryin = 1; #1000 
    $display("%b  %b |   %b |  %b | 1 | %b", A, B, Command, AddSubSLTSum, carryout);
    A=0;B=1;Command=3'b001; carryin = 1; #1000 
    $display("%b  %b |   %b |  %b | 1 | %b", A, B, Command, AddSubSLTSum, carryout);   					 
	A=0;B=0;Command=3'b001; carryin = 1; #1000 
    $display("%b  %b |   %b |  %b | 0 | %b", A, B, Command, AddSubSLTSum, carryout);
	// SLT - this should look exactly like the subtraction, since nothing has been done to distinguish one from the other
    $display("A B | Command |Out|ExpectOut|Carryout-SLT");
    A=1;B=1;Command=3'b011; carryin = 1; #1000 
    $display("%b  %b |   %b |  %b | 0 | %b", A, B, Command, AddSubSLTSum, carryout);
    A=1;B=0;Command=3'b011; carryin = 1; #1000 
    $display("%b  %b |   %b |  %b | 1 | %b", A, B, Command, AddSubSLTSum, carryout);
    A=0;B=1;Command=3'b011; carryin = 1; #1000 
    $display("%b  %b |   %b |  %b | 1 | %b", A, B, Command, AddSubSLTSum, carryout);   					 
	A=0;B=0;Command=3'b011; carryin = 1; #1000 
    $display("%b  %b |   %b |  %b | 0 | %b", A, B, Command, AddSubSLTSum, carryout);
// Exhaustively testing AND/NAND 
    $display("A B |Command|Out|ExpectOut-AND");
    A=0;B=0;Command=3'b100; #1000 
    $display("%b  %b |   %b |  %b  | 0", A, B, Command, AndNandOut);
    A=0;B=1;Command=3'b100; #1000 
    $display("%b  %b |   %b |  %b  | 0", A, B, Command, AndNandOut);
    A=1;B=0;Command=3'b100; #1000 
    $display("%b  %b |   %b |  %b  | 0", A, B, Command, AndNandOut);
    A=1;B=1;Command=3'b100; #1000 
    $display("%b  %b |   %b |  %b  | 1", A, B, Command, AndNandOut);
    $display("A B |Command|Out|ExpectOut-NAND");
    A=0;B=0;Command=3'b101; #1000 
    $display("%b  %b |   %b |  %b  | 1", A, B, Command, AndNandOut);
    A=0;B=1;Command=3'b101; #1000 
    $display("%b  %b |   %b |  %b  | 1", A, B, Command, AndNandOut);
    A=1;B=0;Command=3'b101; #1000 
    $display("%b  %b |   %b |  %b  | 1", A, B, Command, AndNandOut);
    A=1;B=1;Command=3'b101; #1000 
    $display("%b  %b |   %b |  %b  | 0", A, B, Command, AndNandOut);
// Exhaustively testing OR/NOR/XOR
    $display("A B |Command|Out|ExpectOut-OR");
	A=1; B=1; Command=3'b111; #1000
	$display("%b %b |    %b  |  %b   | 1", A, B, Command, OrNorXorOut);
	A=1; B=0; Command=3'b111; #1000
	$display("%b %b |    %b  |  %b   | 1", A, B, Command, OrNorXorOut);
	A=0; B=1; Command=3'b111; #1000
	$display("%b %b |    %b  |  %b   | 1", A, B, Command, OrNorXorOut);
	A=0; B=0; Command=3'b111; #1000
	$display("%b %b |    %b  |  %b   | 0", A, B, Command, OrNorXorOut);
    $display("A B |Command|Out|ExpectOut-NOR");
	A=1; B=1; Command=3'b110; #1000
	$display("%b %b |    %b  |  %b   | 0", A, B, Command, OrNorXorOut);
	A=1; B=0; Command=3'b110; #1000
	$display("%b %b |    %b  |  %b   | 0", A, B, Command, OrNorXorOut);
	A=0; B=1; Command=3'b110; #1000
	$display("%b %b |    %b  |  %b   | 0", A, B, Command, OrNorXorOut);
	A=0; B=0; Command=3'b110; #1000
	$display("%b %b |    %b  |  %b   | 1", A, B, Command, OrNorXorOut);
    $display("A B |Command|Out|ExpectOut-XOR");
	A=1; B=1; Command=3'b010; #1000
	$display("%b %b |    %b  |  %b   | 0", A, B, Command, OrNorXorOut);
	A=1; B=0; Command=3'b010; #1000
	$display("%b %b |    %b  |  %b   | 1", A, B, Command, OrNorXorOut);
	A=0; B=1; Command=3'b010; #1000
	$display("%b %b |    %b  |  %b   | 1 ", A, B, Command, OrNorXorOut);
	A=0; B=0; Command=3'b010; #1000
	$display("%b %b |    %b  |  %b   | 0", A, B, Command, OrNorXorOut);
end
endmodule


/*
module test32Adder();
parameter size = 32; 
output  [size-1:0] OneBitFinalOut;
output [size-1:0] OrNorXorOut;
output [size-1:0] AndNandOut;
wire [size-1:0] AddSubSLTSum; 
wire carryout; 
wire overflow; 
wire SLTflag;
wire [size-1:0]ZeroFlag;
wire AllZeros;
wire [size-1:0] subtract; 
reg [size-1:0] A, B; 
reg [2:0] Command;
reg [size-1:0]carryin; 
wire Cmd0Start [size-1:0];
wire Cmd1Start [size-1:0]; 
wire [size-1:0] CarryoutWire;

AddSubSLT32 trial(AddSubSLTSum, carryout, overflow, SLTflag, subtract, A, B, Command, carryin);

AndNand32 trial1(AndNandOut, A, B, Command);

OrNorXor32 trial2(OrNorXorOut, A, B, Command);

Bitslice32 superalu(OneBitFinalOut, AddSubSLTSum, carryout, overflow, SLTflag,  OrNorXorOut, AndNandOut, subtract, ZeroFlag, AllZeros, A, B, Command, carryin);

initial begin
	$dumpfile("FullALU.vcd");
	$dumpvars();

$display("Test 4 Bit Adder Functionality");
// there are too many possibilities even for just a four bit adder/subtractor, which means we need to choose our test cases strategically
$display(" A   | B    |Command| Out|ExpectedOut|Cout|OF"); 

//Pos + Pos < 7 | 2 + 4 = 6 | 2 = 0010 | 4 = 0100 | 6 = 0110 | NO OVERFLOW
A = 4'b0010; B = 4'b0100; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect 0110| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

//Pos + Pos < 7 | 1 + 6 = 7 | 1 = 0001 | 6 = 0110 | 7 = 0111 | NO OVERFLOW
A = 4'b0001; B = 4'b0110; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect 0111| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

//Pos + Neg > 0 | 5 + -3 = 2 | 5 = 0101 | -3 = 1101 | 2 = 0010 | NO OVERFLOW
A = 4'b0101; B = 4'b1101; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect 0010| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

//Pos + Neg > 0 | 2 + -1 = 1 | 2 = 0010 | -1 = 1111 | 1 = 0001 | NO OVERFLOW
A = 4'b0010; B = 4'b1111; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect 0001| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

//Pos + Neg < 0 | -8 + 3 = -5 | -8 = 1000 | 3 = 0011 | -5 = 1011 | NO OVERFLOW
A = 4'b1000; B = 4'b0011; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect 1011| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

//Pos + Neg < 0 | -4 + 2 = -2 | -4 = 1100 | 2 = 0010 | -2 = 1110 | NO OVERFLOW
A = 4'b1100; B = 4'b0010; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect 1110| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

//Pos + Neg = 0 | -5 + 5 = 0 | -5 = 1101 | 5 = 0101 | 0 = 0000 | NO OVERFLOW
A = 4'b1011; B = 4'b0101; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect 0110| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

//Pos + Neg = 0 | -7 + 7 = 0 | -7 = 1001 | 7 = 0111 | 0 = 0000 | NO OVERFLOW
A = 4'b0111; B = 4'b1001; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect 0000| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

//Neg + Neg > -8 | -3 + -4 = -7 | -3 = 1101 | -4 = 1100 | -7 = 1001 | NO OVERFLOW
A = 4'b1101; B = 4'b1100; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect 1001| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

//Neg + Neg > -8 | -2 + -6 = -8 | -2 = 1110 | -6 = 1010 | -8 = 1000 | NO OVERFLOW
A = 4'b1110; B = 4'b1010; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect 1000| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

//Pos + Pos > 7 | 5 + 6 = 11 | 5 = 0101 | 6 = 0110 |  | OVERFLOW
A = 4'b0101; B = 4'b0110; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect XXXX| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

//Pos + Pos > 7 | 2 + 7 = 9 | 2 = 0010 | 7 = 0111 |  | OVERFLOW
A = 4'b0010; B = 4'b0111; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect XXXX| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

//Pos + Pos > 7 | 7 + 7 = 14 | 7 = 0111 | 7 = 0111 |  | OVERFLOW
A = 4'b0111; B = 4'b0111; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect XXXX| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

//Neg + Neg < -8 | -8 + -1 = -9 | -8 = 1000 | -1 = 1111 |  | OVERFLOW
A = 4'b1000; B = 4'b1111; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect XXXX| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

//Neg + Neg < -8 | -8 + -3 = -11 | -8 = 1000 | -3 = 1101 |  | OVERFLOW
A = 4'b1000; B = 4'b1101; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect XXXX| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

//Neg + Neg < -8 | -5 + -4 = -9 | -5 = 1011 | -4 = 1100 |  | OVERFLOW
A = 4'b1011; B = 4'b1100; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect XXXX| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

$display("Test 4 Bit SLT Functionality");
// there are too many possibilities even for just a four bit adder/subtractor, which means we need to choose our test cases strategically. We chose to not specifically test the subtractor, since it is part of the SLT, and if the SLT is working, then the subtractor is, too.
$display(" A   | B    |Command| Out|ExpectedOut|Cout|OF |SLTflag"); 

// A < B, A > 0 | B > 0 | No Overflow | A = 2 = 0010 | B = 4 = 0100
A = 4'b0010; B = 4'b0100; Command =3'b011; #1000
$display("%b | %b | %b | %b | Expect 1110| %b | %b | %b", A, B, Command, AddSubSLTSum, carryout, overflow, SLTflag);

// A > B, A > 0 | B > 0 | No Overflow | A = 4 = 0100 | B = 2 = 0010
A = 4'b0100; B = 4'b0010; Command =3'b011; #1000
$display("%b | %b | %b | %b | Expect 0010| %b | %b | %b", A, B, Command, AddSubSLTSum, carryout, overflow, SLTflag);

// A < B, A < 0 | B > 0 | No Overflow | A = -2 = 1110 | B = 4 = 0100
A = 4'b1110; B = 4'b0100; Command =3'b011; #1000
$display("%b | %b | %b | %b | Expect 1010| %b | %b | %b", A, B, Command, AddSubSLTSum, carryout, overflow, SLTflag);

// A > B, A > 0 | B < 0 | No Overflow | A = 4 = 0100| B = -2 = 1110
A = 4'b0100; B = 4'b1110; Command =3'b011; #1000
$display("%b | %b | %b | %b | Expect 0110| %b | %b | %b", A, B, Command, AddSubSLTSum, carryout, overflow, SLTflag);

// A < B, A < 0 | B < 0 | No Overflow | A = -2 = 1110 | B = -1 = 1111
A = 4'b1110; B = 4'b1111; Command =3'b011; #1000
$display("%b | %b | %b | %b | Expect 1111| %b | %b | %b", A, B, Command, AddSubSLTSum, carryout, overflow, SLTflag);

// A > B, A < 0 | B < 0 | No Overflow | A = -1 = 1111 | B = -2 = 1110
A = 4'b1111; B = 4'b1110; Command =3'b011; #1000
$display("%b | %b | %b | %b | Expect 0001| %b | %b | %b", A, B, Command, AddSubSLTSum, carryout, overflow, SLTflag);

// A = B, A < 0 | B < 0 | No Overflow | A = -3 = 1101 | B = -3 = 1101
A = 4'b1101; B = 4'b1101; Command =3'b011; #1000
$display("%b | %b | %b | %b | Expect 0000| %b | %b | %b", A, B, Command, AddSubSLTSum, carryout, overflow, SLTflag);

// A = B, A > 0 | B > 0 | No Overflow | A = 5 = 0101 | B = 5 = 0101
A = 4'b0101; B = 4'b0101; Command =3'b011; #1000
$display("%b | %b | %b | %b | Expect 0000| %b | %b | %b", A, B, Command, AddSubSLTSum, carryout, overflow, SLTflag);

// A < B, A < 0 | B > 0 | Overflow | A = -7 = 1001 | B = 5 = 0101
A = 4'b1001; B = 4'b0101; Command =3'b011; #1000
$display("%b | %b | %b | %b | Expect XXXX| %b | %b | %b", A, B, Command, AddSubSLTSum, carryout, overflow, SLTflag);

$display("Test 4 Bit AND/NAND Functionality");
// there are too many possibilities even for just a four bit AND/NAND, which means we need to choose our test cases strategically. 
$display(" A   | B    |Command| Out    |ExpectedOut-AND"); 

// A = B | A = 1111 | AND = 1111
    A=4'b1111;B=4'b1111;Command=3'b100; #1000 
    $display("%b | %b |   %b |  %b  | 1111", A, B, Command, AndNandOut);

//  A = 1111 | B = 1010 | AND = 1010
    A=4'b1111;B=4'b1010;Command=3'b100; #1000 
    $display("%b | %b |   %b |  %b  | 1010", A, B, Command, AndNandOut);

//  A = 1111 | B = 0101 | AND = 0101
    A=4'b1111;B=4'b0101;Command=3'b100; #1000 
    $display("%b | %b |   %b |  %b  | 0101", A, B, Command, AndNandOut);

//  A = 1111 | B = 0000 | AND = 0000
    A=4'b1111;B=4'b0000;Command=3'b100; #1000 
    $display("%b | %b |   %b |  %b  | 0000", A, B, Command, AndNandOut);


$display(" A   | B    |Command| Out    |ExpectedOut-NAND"); 

// A = B | A = 1111 | NAND = 0000
    A=4'b1111;B=4'b1111;Command=3'b101; #1000 
    $display("%b | %b |   %b |  %b  | 0000", A, B, Command, AndNandOut);

//  A = 1111 | B = 1010 | NAND = 0101
    A=4'b1111;B=4'b1010;Command=3'b101; #1000 
    $display("%b | %b |   %b |  %b  | 0101", A, B, Command, AndNandOut);

//  A = 1111 | B = 0101 | NAND = 1010
    A=4'b1111;B=4'b0101;Command=3'b101; #1000 
    $display("%b | %b |   %b |  %b  | 1010", A, B, Command, AndNandOut);

//  A = 1111 | B = 0000 | NAND = 1111
    A=4'b1111;B=4'b0000;Command=3'b101; #1000 
    $display("%b | %b |   %b |  %b  | 1111", A, B, Command, AndNandOut);

$display("Test 4 Bit OR/NOR/XOR Functionality");
// there are too many possibilities even for just a four bit AND/NAND, which means we need to choose our test cases strategically. 
$display(" A   | B    |Command  | Out     |ExpectedOut-OR"); 

// A = 1010 | B = 0101 | OR = 1111
	A=4'b1010; B=4'b0101; Command=3'b111; #1000
	$display("%b | %b |    %b  |  %b   | 1111", A, B, Command, OrNorXorOut);

// A = 1111 | B = 0101 | OR = 1111
	A=4'b1111; B=4'b0101; Command=3'b111; #1000
	$display("%b | %b |    %b  |  %b   | 1111", A, B, Command, OrNorXorOut);

// A = 1011 | B = 0000 | OR = 1011
	A=4'b1011; B=4'b0000; Command=3'b111; #1000
	$display("%b | %b |    %b  |  %b   | 1011", A, B, Command, OrNorXorOut);

$display(" A   | B    |Command  | Out     |ExpectedOut-NOR"); 

// A = 1010 | B = 0101 | NOR = 0000
	A=4'b1010; B=4'b0101; Command=3'b110; #1000
	$display("%b | %b |    %b  |  %b   | 0000", A, B, Command, OrNorXorOut);

// A = 1111 | B = 0101 | NOR = 0000
	A=4'b1111; B=4'b0101; Command=3'b110; #1000
	$display("%b | %b |    %b  |  %b   | 0000", A, B, Command, OrNorXorOut);

// A = 1011 | B = 0000 | NOR = 0100
	A=4'b1011; B=4'b0000; Command=3'b110; #1000
	$display("%b | %b |    %b  |  %b   | 0100", A, B, Command, OrNorXorOut);

$display(" A   | B    |Command  | Out     |ExpectedOut-XOR"); 

// A = 1010 | B = 0101 | XOR = 1111
	A=4'b1010; B=4'b0101; Command=3'b010; #1000
	$display("%b | %b |    %b  |  %b   | 1111", A, B, Command, OrNorXorOut);

// A = 1111 | B = 0101 | XOR = 1010
	A=4'b1111; B=4'b0101; Command=3'b010; #1000
	$display("%b | %b |    %b  |  %b   | 1010", A, B, Command, OrNorXorOut);

// A = 1011 | B = 0000 | XOR = 1011
	A=4'b1011; B=4'b0000; Command=3'b010; #1000
	$display("%b | %b |    %b  |  %b   | 1011", A, B, Command, OrNorXorOut);

$display("Test 4 Bit ALU Functionality");
// there are too many possibilities even for just a four bit AND/NAND, which means we need to choose our test cases strategically. 
$display(" A   | B    |Command     | Out     |ExpectedOut | COut | OF |SLT|Zero"); 

// Test AND
// A = B | A = 1111 | AND = 1111
    A=4'b1111;B=4'b1111;Command=3'b100; #1000 
    $display("%b | %b | %b - AND  |  %b   | 1111       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);

// Test NAND
//  A = 1111 | B = 0000 | NAND = 1111
    A=4'b1111;B=4'b0000;Command=3'b101; #1000 
    $display("%b | %b | %b - NAND |  %b   | 1111       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);

// Test OR
// A = 1111 | B = 0101 | OR = 1111
	A=4'b1111; B=4'b0101; Command=3'b111; #1000
    $display("%b | %b | %b - OR   |  %b   | 1111       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);

// Test NOR
// A = 1011 | B = 0000 | NOR = 0100
	A=4'b1011; B=4'b0000; Command=3'b110; #1000
    $display("%b | %b | %b - NOR  |  %b   | 0100       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);

// Test XOR
// A = 1011 | B = 0000 | XOR = 1011
	A=4'b1011; B=4'b0000; Command=3'b010; #1000
    $display("%b | %b | %b - XOR  |  %b   | 1011       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);

// Test ADD
//Pos + Pos < 7 | 2 + 4 = 6 | 2 = 0010 | 4 = 0100 | 6 = 0110 | NO OVERFLOW
A = 4'b0010; B = 4'b0100; Command =3'b000; #1000
    $display("%b | %b | %b - ADD  |  %b   | 0110       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);

//Neg + Neg < -8 | -5 + -4 = -9 | -5 = 1011 | -4 = 1100 |  | OVERFLOW
A = 4'b1011; B = 4'b1100; Command =3'b000; #1000
    $display("%b | %b | %b - ADD  |  %b   | XXXX       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);

// Test SUB
// A < B, A > 0 | B > 0 | No Overflow | A = 2 = 0010 | B = 4 = 0100
A = 4'b0010; B = 4'b0100; Command =3'b001; #1000
    $display("%b | %b | %b - SUB  |  %b   | 1110       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);

// A < B, A < 0 | B > 0 | Overflow | A = -7 = 1001 | B = 3 = 0011
A = 4'b1001; B = 4'b0011; Command =3'b001; #1000
    $display("%b | %b | %b - SUB  |  %b   | XXXX       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);

// Test SLT

// A > B, A > 0 | B > 0 | No Overflow | A = 4 = 0100 | B = 2 = 0010
A = 4'b0100; B = 4'b0010; Command =3'b011; #1000
    $display("%b | %b | %b - SLT  |  %b   | 0010       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);

// A < B, A < 0 | B > 0 | Overflow | A = -7 = 1001 | B = 5 = 0101
A = 4'b1001; B = 4'b0101; Command =3'b011; #1000
    $display("%b | %b | %b - SLT  |  %b   | XXXX       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);

// Test Zero 


    A=4'b0000;B=4'b1111;Command=3'b100; #1000 
    $display("%b | %b | %b - AND  |  %b   | 0000       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);

    A=4'b1111;B=4'b1111;Command=3'b101; #1000 
    $display("%b | %b | %b - NAND |  %b   | 0000       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);

	A=4'b0000; B=4'b0000; Command=3'b111; #1000
    $display("%b | %b | %b - OR   |  %b   | 0000       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);
	A=4'b1011; B=4'b0100; Command=3'b110; #1000
    $display("%b | %b | %b - NOR  |  %b   | 0000       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);

	A=4'b1011; B=4'b1011; Command=3'b010; #1000
    $display("%b | %b | %b - XOR  |  %b   | 0000       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);

A = 4'b0010; B = 4'b1110; Command =3'b000; #1000
    $display("%b | %b | %b - ADD  |  %b   | 0000       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);

A = 4'b0010; B = 4'b0010; Command =3'b001; #1000
    $display("%b | %b | %b - SUB  |  %b   | 0000       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);


A = 4'b0000; B = 4'b0000; Command =3'b011; #1000
    $display("%b | %b | %b - SLT  |  %b   | 0000       | %b    | %b  | %b | %b", A, B, Command, OneBitFinalOut, carryout, overflow, SLTflag, AllZeros);
 
end

endmodule
*/




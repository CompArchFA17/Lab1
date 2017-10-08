// Intermediate testbench
`timescale 1 ns / 1 ps
`include "alu2.v"

module test32Adder();

parameter size = 4; 
output  [size-1:0] OneBitFinalOut;
output [size-1:0] OrNorXorOut;
output [size-1:0] AndNandOut;
wire [size-1:0] AddSubSLTSum; 
wire carryout; 
wire overflow; 
wire SLTflag;
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

Bitslice32 superalu(OneBitFinalOut, AddSubSLTSum, carryout, overflow, SLTflag,  OrNorXorOut, AndNandOut, subtract, A, B, Command, carryin);


initial begin
$display("Test ALU - Add");
$display(" A   | B   |Command|Output | ExpectOut|Cout|OF|subtract|SLTflag"); 
A = 4'b1000; B = 4'b0001; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect 1001| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

$display(" A   | B   |Command|Output | ExpectOut|Cout|OF|subtract|SLTflag"); 
A = 4'b1000; B = 4'b0001; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect 1001| %b | %b ", A, B, Command, OneBitFinalOut, carryout, overflow);
/*
A = 4'b1010; B = 4'b0001; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect 1011| %b | %b | %b", A, B, Command, AddSubSLTSum, carryout, overflow, subtract);

A = 4'b1010; B = 4'b0001; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect 1011| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

A = 4'b1010; B = 4'b0111; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect 0001| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

A = 4'b1010; B = 4'b0111; Command =3'b001; #1000
$display("%b | %b | %b | %b | Expect 0011| %b | %b | %b", A, B, Command, AddSubSLTSum, carryout, overflow, subtract);

A = 4'b1010; B = 4'b0111; Command =3'b011; #1000
$display("%b | %b | %b | %b | Expect 0011| %b | %b | %b | %b", A, B, Command, AddSubSLTSum, carryout, overflow, subtract, SLTflag);

A = 4'b0111; B = 4'b1010; Command =3'b011; #1000
$display("%b | %b | %b | %b | Expect 0011| %b | %b | %b | %b", A, B, Command, AddSubSLTSum, carryout, overflow, subtract, SLTflag);


A = 4'b0001; B = 4'b0010; Command =3'b011; #1000
$display("%b | %b | %b | %b | Expect xxxx| %b | %b | %b | %b", A, B, Command, AddSubSLTSum, carryout, overflow, subtract, SLTflag);


$display("AND/NAND");
$display("A | B | Command | Output | ExpectedOut");
A = 4'b0001; B = 4'b0010; Command =3'b100; #1000
$display("%b | %b | %b | %b | Expect 0000", A, B, Command, AndNandOut);

$display("A | B | Command | Output | ExpectedOut");
A = 4'b0001; B = 4'b0010; Command =3'b101; #1000
$display("%b | %b | %b | %b | Expect 1111", A, B, Command, AndNandOut);

$display("OR/NOR/XOR");
$display("A | B | Command | Output | ExpectedOutXOR");
A = 4'b0001; B = 4'b0010; Command =3'b010; #1000
$display("%b | %b | %b | %b | Expect 0011", A, B, Command, OrNorXorOut);

$display("A | B | Command | Output | ExpectedOutNOR");
A = 4'b0001; B = 4'b0010; Command =3'b110; #1000
$display("%b | %b | %b | %b | Expect 1100", A, B, Command, OrNorXorOut);

$display("A | B | Command | Output | ExpectedOutOR");
A = 4'b0001; B = 4'b0010; Command =3'b111; #1000
$display("%b | %b | %b | %b | Expect 0011", A, B, Command, OrNorXorOut);
*/

end

endmodule


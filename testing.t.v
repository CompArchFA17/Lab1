// Intermediate testbench
`timescale 1 ns / 1 ps
`include "alu2.v"

module test32Adder();

parameter size = 4; 
wire [size-1:0] AddSubSLTSum; 
wire carryout; 
wire overflow; 
wire SLTflag;
wire [size-1:0] subtract; 
reg [size-1:0] A, B; 
reg [2:0] Command;
reg [size-1:0]carryin; 

wire [size-1:0] CarryoutWire;
AddSubSLT32 trial(AddSubSLTSum, carryout, overflow, SLTflag, subtract, A, B, Command, carryin);

initial begin
$display(" A   | B   |Command|Output | exOut|Cout|OF|subtract|SLTflag"); 
A = 4'b1000; B = 4'b0001; Command =3'b000; #1000
$display("%b | %b | %b | %b | Expect 1001| %b | %b ", A, B, Command, AddSubSLTSum, carryout, overflow);

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
$display("%b | %b | %b | %b | Expect x| %b | %b | %b | %b", A, B, Command, AddSubSLTSum, carryout, overflow, subtract, SLTflag);

end

endmodule


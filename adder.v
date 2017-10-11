// Adder circuit

// define gates with delays
`define AND and #30
`define OR or #30
`define NOT not #10
`define NAND nand #20
`define NOR nor #20
`define XOR xor #30


 /* 
Module: structuralFullAdder
Adds three bits(a, b, and carryin) and returns the sum of those bits with output (sum and carryout) 
using two XOR gates for the sum and two AND gates and one OR gate for the carryout
  */
module structuralFullAdder // Full Adder using XOR gates
(
    output sum, // Single bit inputs and outputs
    output carryout,
    input a, 
    input b, 
    input carryin
);

    wire ab; // Calculate the sum
    `XOR aXORb(ab, a, b);
    `XOR abXORc(sum, ab, carryin);

    wire aAndb, oneAndC; // Calculate the carryout (if it exists)
    `AND aANDb(aAndb, a, b);
    `AND aXORbANDc(oneAndC, ab, carryin);
    `OR aorborc(carryout, aAndb, oneAndC);
    
endmodule

 /* 
Module: FullAdder4bit
Takes advantage of the structuralFullAdder module by inputting corresponding (same-index) bits of a and b
outputs the 4-bit sum and 1-bit carryout and overflow
  */
module FullAdder4bit
(
  output[3:0] sum, // 2's complement sum of a and b
  output carryout, // Carry out of the summation of a and b
  output overflow, // True if calc resulted in overflow
  input[3:0] a,    // First operand in 2's complement format
  input[3:0] b,     // Second operand in 2's complement format
  input carryin
);
    wire carry0, carry1, carry2; // The only additional wires connect the FullAdder components, carryout to carryin.

    structuralFullAdder add0 (sum[0], carry0, a[0], b[0], carryin); // First adder will not have a carry in.
    structuralFullAdder add1 (sum[1], carry1, a[1], b[1], carry0);
    structuralFullAdder add2 (sum[2], carry2, a[2], b[2], carry1);
    structuralFullAdder add3 (sum[3], carryout, a[3], b[3], carry2); // Final adder has the last carryout 
    `XOR overflowCheck(overflow, carry2, carryout); // Returns 1 if there is overflow by comparing carryin and carryout of last adder
endmodule

 /* 
Module: FullAdder32bit
Takes advantage of the FullAdder4bit module by inputting corresponding 4-bit groups of a and b 
outputs the 32-bit sum and 1-bit carryout and overflow
*/
module FullAdder32bit
(
  output[31:0] sum, // 2's complement sum of a and b
  output carryout, // Carry out of the summation of a and b
  output overflow, // True if calc resulted in overflow
  input[31:0] a,    // First operand in 2's complement format
  input[31:0] b     // Second operand in 2's complement format
);
    wire[6:0] carry; // The only additional wires connect the FullAdder components, carryout to carryin.
    wire[6:0] over; // never gets used, only there to make the program run
    FullAdder4bit add0 (sum[3:0], carry[0], over[0], a[3:0], b[3:0], 0); // First adder will not have a carry in.
    FullAdder4bit add1 (sum[7:4], carry[1], over[1], a[7:4], b[7:4], carry[0]);
    FullAdder4bit add2 (sum[11:8], carry[2], over[2], a[11:8], b[11:8], carry[1]);
    FullAdder4bit add3 (sum[15:12], carry[3], over[3], a[15:12], b[15:12], carry[2]); // Final adder has the last carryout 
    FullAdder4bit add4 (sum[19:16], carry[4], over[4], a[19:16], b[19:16], carry[3]); // First adder will not have a carry in.
    FullAdder4bit add5 (sum[23:20], carry[5], over[5], a[23:20], b[23:20], carry[4]);
    FullAdder4bit add6 (sum[27:24], carry[6], over[6], a[27:24], b[27:24], carry[5]);
    FullAdder4bit add7 (sum[31:28], carryout, overflow, a[31:28], b[31:28], carry[6]); // Final adder has the last carryout 

    `XOR overflowCheck(overflow, carry[6], carryout); // Returns 1 if there is overflow by comparing carryin and carryout of last adder
endmodule

 /* 
Module: Subtractor32bit
Takes advantage of the FullAdder32bit module by converting input b to the signed negation of itself
outputs the 32-bit sum (or subtraction in this case) and 1-bit carryout and overflow
*/
module Subtractor32bit
(
  input[31:0] a, b,
  output[31:0] sum,
  output carryout, overflow
);

  wire[31:0] notb, b2comp;
  wire unusedCarryout, unusedOverflow;

  not32 notbgate (notb, b);
  FullAdder32bit add1tob(b2comp, unusedCarryout, unusedOverflow, notb, 32'd1);
  FullAdder32bit getsum(sum, carryout, overflow, a, b2comp);
endmodule
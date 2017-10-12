// ALU main circuit
// Calculates the solutions for addition, subtraction, SLT. xor, and, nand, nor, or
// but doesn't include MUX
// Note: this also doesn't fully manage the carryout, something else must determine
// wheter or not to pass the "carryAND" out the carryout line.
// external reqirements:
//    i0 is the 2^0 digit of the control signal (according to the spec)
//    c can only be true if carryout is allowed (for all bits)
`define NAND nand #20
`define NOR nor #20
`define XOR2 xor #20
`define XOR3 xor #30

module aluBit
(
    output sumXOR,
    output carryAND,
    output nab,
    output orNOR,
    input a, 
    input b, 
    input carryin,
    input i0
);
    wire nab;
    wire nbc;
    wire nac;
    wire sumXOR;
    wire ab;
    wire carryout;
    wire anorb;
    wire orNOR;
    wire carryAND;
    // level 1 for plus/minus, nand, and
    `NAND aNANDb(nab, a, b);
    `NAND bNANDc(nbc, b, carryin);
    `NAND aNANDc(nac, a, carryin);
    // level 2 for plus/minus, and
    nand #30 cand(carryAND, nab, nac, nbc);
    // xor/sum
    `XOR3 sumxor(sumXOR, a, b, carryin);
    // or/nor
    `NOR aNORb(anorb, a, b);
    `XOR2 ornor(orNOR, anorb, i0);
    
    
endmodule

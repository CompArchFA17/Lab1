`define AND and #30
`define OR or #30
`define NOT not #10
`define XOR xor #30
`define NOR nor #20
`define NAND nand #20

module Adder1bit
(
    output sum,
    output carryout,
    input a,
    input b,
    input carryin
);
    wire aandb, aorb;
    wire s, _carryin;
    wire outputIfCarryin, outputIf_Carryin;
    `XOR(s, a, b);
    `XOR(sum, s, carryin);
    `AND(aandb, a, b);
    `OR(aorb, a, b);
    `NOT(_carryin, carryin);
    `AND(outputIfCarryin, aandb, _carryin);
    `AND(outputIf_Carryin, aorb, carryin);
    `OR(carryout, outputIfCarryin, outputIf_Carryin);
endmodule

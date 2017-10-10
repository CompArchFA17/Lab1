`define AND and #30
`define OR or #30
`define NOT not #10
`define XOR xor #30
`define NOR nor #20
`define NAND nand #20

module Subtractor1bit
(
    output diff,
    output borrowout,
    input a,
    input b,
    input borrowin
);
    wire axorb;
    `XOR(axorb, a, b);
    `XOR(diff, axorb, borrowin);
    wire nota, noteaandb, notaxorb, notaxorbandborrowin;
    `NOT(nota, a);
    `AND(notaandb, nota, b);
    `NOT(notaxorb, axorb);
    `AND(notaxorbandborrowin, notaxorb, borrowin);
    `OR(borrowout, notaandb, notaxorbandborrowin);
endmodule

// Adder circuit

`define AND and #20
`define OR or #20
`define XOR xor #20

module fullAdder
(
    output sum,
    output carryout,
    input a,
    input b,
    input carryin
);
    wire axorb, axorb_andcarryin, aandb;

    `XOR xorab (axorb, a, b);
    `XOR xorsumout (sum, carryin, axorb);
    `AND andab (aandb, a, b);
    `AND andaxorbcarryin (axorb_andcarryin, axorb, carryin);
    `OR orcarryout (carryout, aandb, axorb_andcarryin);

endmodule

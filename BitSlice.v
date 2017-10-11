//Single bit slice module for ALU
`define NAND nand #20
`define NOR nor #20
`define NOT not #10
`define XOR xor #30
`define OR or #30
`define NAND7 nand #70

`include "adder.v"

module BitSlice
(
    output cout, sum, res,
    input ADD, SUB, XOR, SLT, AND, NAND, NOR, OR, A, B, CIN
);
    // internal wires
    wire sum, sub_slt, b_inv, xor_ab, and_ab, nand_ab, nor_ab, or_ab;
    // individual outputs into nand collector
    wire add_out, sub_out, xor_out, and_out, nand_out, nor_out, or_out;

    // individual operator blocks
    `OR or_sub_slt (sub_slt, SUB, SLT);
    `XOR inv_input (b_inv, B, sub_slt);
    fullAdder adder (sum, cout, A, b_inv, CIN);
    `XOR xor_operator (xor_ab, A, B);
    `NAND nand_operator (nand_ab, A, B);
    `NOR nor_operator (nor_ab, A, B);
    `NOT not_nand (and_ab, nand_ab);
    `NOT not_nor (or_ab, nor_ab);

    // nand control line selectors
    `NAND add_switch (add_out, sum, ADD);
    `NAND sub_switch (sub_out, sum, SUB);
    `NAND xor_switch (xor_out, xor_ab, XOR);
    `NAND and_switch (and_out, and_ab, AND);
    `NAND nand_switch (nand_out, nand_ab, NAND);
    `NAND nor_switch (nor_out, nor_ab, NOR);
    `NAND or_switch (or_out, or_ab, OR);

    // collector for all individual outputs
    `NAND7 collector (res, add_out, sub_out, xor_out, and_out, nand_out, nor_out, or_out);

endmodule

//4 bit ALU module
`define NOR nor #20
`define AND and #30
`define OR or #30
`define XOR xor #30
`define NOR4 nor #40

`include "BitSlice.v"
`include "ALUcontrolLUT.v"

module FourBitALUGenerate
(
    output[3:0] out,
    output carryout, ovf, zero,
    input[3:0] a,
    input[3:0] b,
    input[2:0] cmd
);
    genvar i;
    // control lines
    wire ADD, SUB, XOR, SLT, AND, NAND, NOR, OR;
    // other wires
    wire[2:0] cout;
    wire[3:0] sum;
    wire cin, res0, ovf_raw, cout_raw, zero_raw, slt_raw, slt_out, flag_enable;

    ALUcontrolLUT controlLUT(ADD, SUB, XOR, SLT, AND, NAND, NOR, OR, cmd);

    `OR sub_slt (cin, SUB, SLT);

    BitSlice bitslice0(cout[0], sum[0], res0, ADD, SUB, XOR, SLT, AND, NAND, NOR, OR, a[0], b[0], cin);
    generate
    for (i = 1; i < 3; i = i+1) begin : bitslice_generate
      BitSlice bitslice (cout[i], sum[i], out[i], ADD, SUB, XOR, SLT, AND, NAND, NOR, OR, a[i], b[i], cout[i-1]);
    end
    endgenerate
    BitSlice bitslice3(cout_raw, sum[3], out[3], ADD, SUB, XOR, SLT, AND, NAND, NOR, OR, a[3], b[3], cout[2]);

    `OR add_sub (flag_enable, ADD, SUB);
    `XOR ovf_xor (ovf_raw, cout_raw, cout[2]);
    `NOR4 zero_collector (zero_raw, res0, out);
    `OR slt_or (slt_raw, ovf_raw, sum[3]);

    `AND ovf_enable (ovf, ovf_raw, flag_enable);
    `AND cout_enable (carryout, cout_raw, flag_enable);
    `AND zero_enable (zero, zero_raw, flag_enable);
    `AND slt_enable (slt_out, slt_raw, SLT);
    `OR slt_connect (out[0], res0, slt_out);

endmodule

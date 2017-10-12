//4 bit ALU module
`define NOR nor #20
`define AND and #30
`define OR or #30
`define XOR xor #30

`include "BitSlice.v"
`include "ALUcontrolLUT.v"

module ALU
(
    output[31:0] out,
    output carryout, ovf, zero,
    input[31:0] a,
    input[31:0] b,
    input[2:0] cmd
);
    genvar i;
    genvar j;
    // control lines
    wire ADD, SUB, XOR, SLT, AND, NAND, NOR, OR;
    // other wires
    wire[31:0] cout;
    wire[31:0] sum;
    wire[30:0] zero_out;
    wire cin, res0, ovf_raw, zero_raw, slt_raw, slt_out, flag_enable;

    // control LUT, decodes command signal into one-hot control lines
    ALUcontrolLUT controlLUT(ADD, SUB, XOR, SLT, AND, NAND, NOR, OR, cmd);

    // the first bitslice's carryin should be 1 if using sub or slt
    `OR sub_slt (cin, SUB, SLT);

    // the first bitslice has slightly different output (for slt op) and cin
    BitSlice bitslice0(cout[0], sum[0], res0, ADD, SUB, XOR, SLT, AND, NAND, NOR, OR, a[0], b[0], cin);
    // all other bitslices cin from the previous cout and output to out[i]
    generate
    for (i = 1; i < 32; i = i+1) begin : bitslice_generate
      BitSlice bitslice (cout[i], sum[i], out[i], ADD, SUB, XOR, SLT, AND, NAND, NOR, OR, a[i], b[i], cout[i-1]);
    end
    endgenerate

    // zero flag checking: or all but last sum line together
    `OR zero_or1(zero_out[1], sum[0], sum[1]);
    generate
    for (j = 2; j < 31; j = j + 1) begin : zero_or_generate
      `OR zero_or (zero_out[j], zero_out[j-1], sum[j]);
    end
    endgenerate
    // high if the whole or string and the last sum are zero
    `NOR zero_nor31(zero_raw, zero_out[30], sum[31]);

    // overflow and slt conditions
    `XOR ovf_xor (ovf_raw, cout[31], cout[30]);
    `XOR slt_xor (slt_raw, ovf_raw, sum[31]);

    // only ADD and SUB set flags
    `OR add_sub (flag_enable, ADD, SUB);
    `AND ovf_enable (ovf, ovf_raw, flag_enable);
    `AND cout_enable (carryout, cout[31], flag_enable);
    `AND zero_enable (zero, zero_raw, flag_enable);

    // SLT sets slt output on the first out line
    `AND slt_enable (slt_out, slt_raw, SLT);
    `OR slt_connect (out[0], res0, slt_out);

endmodule

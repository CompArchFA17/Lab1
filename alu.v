//4 bit ALU module
`define NOR nor #20
`define AND and #30
`define OR or #30
`define XOR xor #30
`define NOR32 nor #320

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
    // control lines
    wire ADD, SUB, XOR, SLT, AND, NAND, NOR, OR;
    // other wires
    wire[31:0] cout;
    wire[31:0] sum;
    wire cin, res0, ovf_raw, zero_raw, slt_raw, slt_out, flag_enable;

    ALUcontrolLUT controlLUT(ADD, SUB, XOR, SLT, AND, NAND, NOR, OR, cmd);

    `OR sub_slt (cin, SUB, SLT);

    BitSlice bitslice0(cout[0], sum[0], res0, ADD, SUB, XOR, SLT, AND, NAND, NOR, OR, a[0], b[0], cin);
    generate
    for (i = 1; i < 32; i = i+1) begin : bitslice_generate
      BitSlice bitslice (cout[i], sum[i], out[i], ADD, SUB, XOR, SLT, AND, NAND, NOR, OR, a[i], b[i], cout[i-1]);
    end
    endgenerate

    `OR add_sub (flag_enable, ADD, SUB);
    `XOR ovf_xor (ovf_raw, cout[31], cout[30]);
    `XOR slt_xor (slt_raw, ovf_raw, sum[31]);

    `AND ovf_enable (ovf, ovf_raw, flag_enable);
    `AND cout_enable (carryout, cout[31], flag_enable);
    `AND zero_enable (zero, zero_raw, flag_enable);
    `AND slt_enable (slt_out, slt_raw, SLT);
    `OR slt_connect (out[0], res0, slt_out);

    `NOR32 zero_collector (zero_raw, out[31], out[30], out[29], out[28], out[27], out[26], out[25], out[24],
      out[23], out[22], out[21], out[20], out[19], out[18], out[17], out[16], out[15], out[14], out[13], out[12],
      out[11], out[10], out[9], out[8], out[7], out[6], out[5], out[4], out[3], out[2], out[1], out[0]);

endmodule

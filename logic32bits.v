// define gates with delays
`define AND and #30
`define OR or #30
`define NOT not #10
`define NAND nand #20
`define NOR nor #20
`define XOR xor #30

module nand32(
	output[31:0] out,
	input[31:0] a,b
);
`NAND get0thbit(out[0],a[0],b[0]);
`NAND get1thbit(out[1],a[1],b[1]);
`NAND get2thbit(out[2],a[2],b[2]);
`NAND get3thbit(out[3],a[3],b[3]);
`NAND get4thbit(out[4],a[4],b[4]);
`NAND get5thbit(out[5],a[5],b[5]);
`NAND get6thbit(out[6],a[6],b[6]);
`NAND get7thbit(out[7],a[7],b[7]);
`NAND get8thbit(out[8],a[8],b[8]);
`NAND get9thbit(out[9],a[9],b[9]);
`NAND get10thbit(out[10],a[10],b[10]);
`NAND get11thbit(out[11],a[11],b[11]);
`NAND get12thbit(out[12],a[12],b[12]);
`NAND get13thbit(out[13],a[13],b[13]);
`NAND get14thbit(out[14],a[14],b[14]);
`NAND get15thbit(out[15],a[15],b[15]);
`NAND get16thbit(out[16],a[16],b[16]);
`NAND get17thbit(out[17],a[17],b[17]);
`NAND get18thbit(out[18],a[18],b[18]);
`NAND get19thbit(out[19],a[19],b[19]);
`NAND get20thbit(out[20],a[20],b[20]);
`NAND get21thbit(out[21],a[21],b[21]);
`NAND get22thbit(out[22],a[22],b[22]);
`NAND get23thbit(out[23],a[23],b[23]);
`NAND get24thbit(out[24],a[24],b[24]);
`NAND get25thbit(out[25],a[25],b[25]);
`NAND get26thbit(out[26],a[26],b[26]);
`NAND get27thbit(out[27],a[27],b[27]);
`NAND get28thbit(out[28],a[28],b[28]);
`NAND get29thbit(out[29],a[29],b[29]);
`NAND get30thbit(out[30],a[30],b[30]);
`NAND get31thbit(out[31],a[31],b[31]);

endmodule

module nor32(
	output[31:0] out,
	input[31:0] a,b
);
`NOR get0thbit(out[0],a[0],b[0]);
`NOR get1thbit(out[1],a[1],b[1]);
`NOR get2thbit(out[2],a[2],b[2]);
`NOR get3thbit(out[3],a[3],b[3]);
`NOR get4thbit(out[4],a[4],b[4]);
`NOR get5thbit(out[5],a[5],b[5]);
`NOR get6thbit(out[6],a[6],b[6]);
`NOR get7thbit(out[7],a[7],b[7]);
`NOR get8thbit(out[8],a[8],b[8]);
`NOR get9thbit(out[9],a[9],b[9]);
`NOR get10thbit(out[10],a[10],b[10]);
`NOR get11thbit(out[11],a[11],b[11]);
`NOR get12thbit(out[12],a[12],b[12]);
`NOR get13thbit(out[13],a[13],b[13]);
`NOR get14thbit(out[14],a[14],b[14]);
`NOR get15thbit(out[15],a[15],b[15]);
`NOR get16thbit(out[16],a[16],b[16]);
`NOR get17thbit(out[17],a[17],b[17]);
`NOR get18thbit(out[18],a[18],b[18]);
`NOR get19thbit(out[19],a[19],b[19]);
`NOR get20thbit(out[20],a[20],b[20]);
`NOR get21thbit(out[21],a[21],b[21]);
`NOR get22thbit(out[22],a[22],b[22]);
`NOR get23thbit(out[23],a[23],b[23]);
`NOR get24thbit(out[24],a[24],b[24]);
`NOR get25thbit(out[25],a[25],b[25]);
`NOR get26thbit(out[26],a[26],b[26]);
`NOR get27thbit(out[27],a[27],b[27]);
`NOR get28thbit(out[28],a[28],b[28]);
`NOR get29thbit(out[29],a[29],b[29]);
`NOR get30thbit(out[30],a[30],b[30]);
`NOR get31thbit(out[31],a[31],b[31]);

endmodule



module not32(

	output[31:0] out,
	input[31:0] a
);
`NOT get0thbit(out[0],a[0]);
`NOT get1thbit(out[1],a[1]);
`NOT get2thbit(out[2],a[2]);
`NOT get3thbit(out[3],a[3]);
`NOT get4thbit(out[4],a[4]);
`NOT get5thbit(out[5],a[5]);
`NOT get6thbit(out[6],a[6]);
`NOT get7thbit(out[7],a[7]);
`NOT get8thbit(out[8],a[8]);
`NOT get9thbit(out[9],a[9]);
`NOT get10thbit(out[10],a[10]);
`NOT get11thbit(out[11],a[11]);
`NOT get12thbit(out[12],a[12]);
`NOT get13thbit(out[13],a[13]);
`NOT get14thbit(out[14],a[14]);
`NOT get15thbit(out[15],a[15]);
`NOT get16thbit(out[16],a[16]);
`NOT get17thbit(out[17],a[17]);
`NOT get18thbit(out[18],a[18]);
`NOT get19thbit(out[19],a[19]);
`NOT get20thbit(out[20],a[20]);
`NOT get21thbit(out[21],a[21]);
`NOT get22thbit(out[22],a[22]);
`NOT get23thbit(out[23],a[23]);
`NOT get24thbit(out[24],a[24]);
`NOT get25thbit(out[25],a[25]);
`NOT get26thbit(out[26],a[26]);
`NOT get27thbit(out[27],a[27]);
`NOT get28thbit(out[28],a[28]);
`NOT get29thbit(out[29],a[29]);
`NOT get30thbit(out[30],a[30]);
`NOT get31thbit(out[31],a[31]);
endmodule

module and32 (
	output[31:0] out,
	input[31:0] a,b
);
wire[31:0] nand_out;
nand32 nandgate (nand_out, a, b);
not32 notgate (out, nand_out);

endmodule

module or32 (
	output[31:0] out,
	input[31:0] a,b
);
wire[31:0] nor_out;
nor32 norgate (nor_out, a, b);
not32 notgate (out, nor_out);

endmodule

module xor32(
	output[31:0] out,
	input[31:0] a,b
);
`XOR get0thbit(out[0],a[0],b[0]);
`XOR get1thbit(out[1],a[1],b[1]);
`XOR get2thbit(out[2],a[2],b[2]);
`XOR get3thbit(out[3],a[3],b[3]);
`XOR get4thbit(out[4],a[4],b[4]);
`XOR get5thbit(out[5],a[5],b[5]);
`XOR get6thbit(out[6],a[6],b[6]);
`XOR get7thbit(out[7],a[7],b[7]);
`XOR get8thbit(out[8],a[8],b[8]);
`XOR get9thbit(out[9],a[9],b[9]);
`XOR get10thbit(out[10],a[10],b[10]);
`XOR get11thbit(out[11],a[11],b[11]);
`XOR get12thbit(out[12],a[12],b[12]);
`XOR get13thbit(out[13],a[13],b[13]);
`XOR get14thbit(out[14],a[14],b[14]);
`XOR get15thbit(out[15],a[15],b[15]);
`XOR get16thbit(out[16],a[16],b[16]);
`XOR get17thbit(out[17],a[17],b[17]);
`XOR get18thbit(out[18],a[18],b[18]);
`XOR get19thbit(out[19],a[19],b[19]);
`XOR get20thbit(out[20],a[20],b[20]);
`XOR get21thbit(out[21],a[21],b[21]);
`XOR get22thbit(out[22],a[22],b[22]);
`XOR get23thbit(out[23],a[23],b[23]);
`XOR get24thbit(out[24],a[24],b[24]);
`XOR get25thbit(out[25],a[25],b[25]);
`XOR get26thbit(out[26],a[26],b[26]);
`XOR get27thbit(out[27],a[27],b[27]);
`XOR get28thbit(out[28],a[28],b[28]);
`XOR get29thbit(out[29],a[29],b[29]);
`XOR get30thbit(out[30],a[30],b[30]);
`XOR get31thbit(out[31],a[31],b[31]);

endmodule

module zero_check(
	output out,
	input[31:0] check
);
wire[30:0] carry_out;
`OR or0(carry_out[0], check[0], check[1]);
`OR or1(carry_out[1], check[2], carry_out[0]);
`OR or2(carry_out[2], check[3], carry_out[1]);
`OR or3(carry_out[3], check[4], carry_out[2]);
`OR or4(carry_out[4], check[5], carry_out[3]);
`OR or5(carry_out[5], check[6], carry_out[4]);
`OR or06(carry_out[6], check[7], carry_out[5]);
`OR or07(carry_out[7], check[8], carry_out[6]);
`OR or08(carry_out[8], check[9], carry_out[7]);
`OR or09(carry_out[9], check[10], carry_out[8]);
`OR or10(carry_out[10], check[11], carry_out[9]);
`OR or11(carry_out[11], check[12], carry_out[10]);
`OR or12(carry_out[12], check[13], carry_out[11]);
`OR or13(carry_out[13], check[14], carry_out[12]);
`OR or14(carry_out[14], check[15], carry_out[13]);
`OR or15(carry_out[15], check[16], carry_out[14]);
`OR or16(carry_out[16], check[17], carry_out[15]);
`OR or17(carry_out[17], check[18], carry_out[16]);
`OR or18(carry_out[18], check[19], carry_out[17]);
`OR or19(carry_out[19], check[20], carry_out[18]);
`OR or20(carry_out[20], check[21], carry_out[19]);
`OR or21(carry_out[21], check[22], carry_out[20]);
`OR or22(carry_out[22], check[23], carry_out[21]);
`OR or23(carry_out[23], check[24], carry_out[22]);
`OR or24(carry_out[24], check[25], carry_out[23]);
`OR or25(carry_out[25], check[26], carry_out[24]);
`OR or26(carry_out[26], check[27], carry_out[25]);
`OR or27(carry_out[27], check[28], carry_out[26]);
`OR or28(carry_out[28], check[29], carry_out[27]);
`OR or29(carry_out[29], check[30], carry_out[28]);
`OR or30(carry_out[30], check[31], carry_out[29]);
`NOT invert(out, carry_out[30]);
endmodule
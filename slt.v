// single bit slt that performs (a<b)?1:0
module single_slt
	(
		output out,
		input a,
		input b,
		input defaultCompare
	);
	wire abxor;
	wire bxorand;
	wire xornot;
	wire xornotand;
	xor #10 axb(abxor, a, b);
	and #20 baxb(bxorand, b, abxor);
	not #10 invxor(xornot, abxor);
	and #20 xorandinput(xornotand, xornot, defaultCompare);
	or #20 compare(out, bxorand, xornotand);
endmodule

// single bit slt that performs (b<a)?1:0
module single_slt_reversed
    (
        output out,
        input a,
        input b,
        input defaultCompare
    );
    wire abxor;
    wire axorand;
    wire xornot;
    wire xornotand;
    xor #10 axb(abxor, a, b);
    and #20 aaxb(axorand, a, abxor);
    not #10 invxor(xornot, abxor);
    and #20 xorandinput(xornotand, xornot, defaultCompare);
    or #20 compare(out, axorand, xornotand);
endmodule

// 32 bit slt that handles two's complement
module full_slt_32bit
	(
		output[31:0] out,
		input[31:0] a,
		input[31:0] b
	);
	wire slt0;
	wire slt1;
    wire slt2;
    wire slt3;
    wire slt4;
    wire slt5;
    wire slt6;
    wire slt7;
    wire slt8;
    wire slt9;
    wire slt10;
    wire slt11;
    wire slt12;
    wire slt13;
    wire slt14;
    wire slt15;
    wire slt16;
    wire slt17;
    wire slt18;
    wire slt19;
    wire slt20;
    wire slt21;
    wire slt22;
    wire slt23;
    wire slt24;
    wire slt25;
    wire slt26;
    wire slt27;
    wire slt28;
    wire slt29;
    wire slt30;
    // each smaller slt feeds into one higher significant bit
    single_slt bit0(slt0, a[0], b[0], 0);
    single_slt bit1(slt1, a[1], b[1], slt0);
    single_slt bit2(slt2, a[2], b[2], slt1);
    single_slt bit3(slt3, a[3], b[3], slt2);
    single_slt bit4(slt4, a[4], b[4], slt3);
    single_slt bit5(slt5, a[5], b[5], slt4);
    single_slt bit6(slt6, a[6], b[6], slt5);
    single_slt bit7(slt7, a[7], b[7], slt6);
    single_slt bit8(slt8, a[8], b[8], slt7);
    single_slt bit9(slt9, a[9], b[9], slt8);
    single_slt bit10(slt10, a[10], b[10], slt9);
    single_slt bit11(slt11, a[11], b[11], slt10);
    single_slt bit12(slt12, a[12], b[12], slt11);
    single_slt bit13(slt13, a[13], b[13], slt12);
    single_slt bit14(slt14, a[14], b[14], slt13);
    single_slt bit15(slt15, a[15], b[15], slt14);
    single_slt bit16(slt16, a[16], b[16], slt15);
    single_slt bit17(slt17, a[17], b[17], slt16);
    single_slt bit18(slt18, a[18], b[18], slt17);
    single_slt bit19(slt19, a[19], b[19], slt18);
    single_slt bit20(slt20, a[20], b[20], slt19);
    single_slt bit21(slt21, a[21], b[21], slt20);
    single_slt bit22(slt22, a[22], b[22], slt21);
    single_slt bit23(slt23, a[23], b[23], slt22);
    single_slt bit24(slt24, a[24], b[24], slt23);
    single_slt bit25(slt25, a[25], b[25], slt24);
    single_slt bit26(slt26, a[26], b[26], slt25);
    single_slt bit27(slt27, a[27], b[27], slt26);
    single_slt bit28(slt28, a[28], b[28], slt27);
    single_slt bit29(slt29, a[29], b[29], slt28);
    single_slt bit30(slt30, a[30], b[30], slt29);
    single_slt_reversed bit31(out, a[31], b[31], slt30);
endmodule
module and_32bit
	(	output[31:0] out,
		input[31:0] a,
		input[31:0] b
	);
	and #20 bit0(out[0], a[0], b[0]);
	and #20 bit1(out[1], a[1], b[1]);
    and #20 bit2(out[2], a[2], b[2]);
    and #20 bit3(out[3], a[3], b[3]);
    and #20 bit4(out[4], a[4], b[4]);
    and #20 bit5(out[5], a[5], b[5]);
    and #20 bit6(out[6], a[6], b[6]);
    and #20 bit7(out[7], a[7], b[7]);
    and #20 bit8(out[8], a[8], b[8]);
    and #20 bit9(out[9], a[9], b[9]);
    and #20 bit10(out[10], a[10], b[10]);
    and #20 bit11(out[11], a[11], b[11]);
    and #20 bit12(out[12], a[12], b[12]);
    and #20 bit13(out[13], a[13], b[13]);
    and #20 bit14(out[14], a[14], b[14]);
    and #20 bit15(out[15], a[15], b[15]);
    and #20 bit16(out[16], a[16], b[16]);
    and #20 bit17(out[17], a[17], b[17]);
    and #20 bit18(out[18], a[18], b[18]);
    and #20 bit19(out[19], a[19], b[19]);
    and #20 bit20(out[20], a[20], b[20]);
    and #20 bit21(out[21], a[21], b[21]);
    and #20 bit22(out[22], a[22], b[22]);
    and #20 bit23(out[23], a[23], b[23]);
    and #20 bit24(out[24], a[24], b[24]);
    and #20 bit25(out[25], a[25], b[25]);
    and #20 bit26(out[26], a[26], b[26]);
    and #20 bit27(out[27], a[27], b[27]);
    and #20 bit28(out[28], a[28], b[28]);
    and #20 bit29(out[29], a[29], b[29]);
    and #20 bit30(out[30], a[30], b[30]);
    and #20 bit31(out[31], a[31], b[31]);
endmodule

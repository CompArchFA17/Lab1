module or_32bit
    (   output[31:0] out,
        input[31:0] a,
        input[31:0] b
    );
    or bit0(out[0], a[0], b[0]);
    or bit1(out[1], a[1], b[1]);
    or bit2(out[2], a[2], b[2]);
    or bit3(out[3], a[3], b[3]);
    or bit4(out[4], a[4], b[4]);
    or bit5(out[5], a[5], b[5]);
    or bit6(out[6], a[6], b[6]);
    or bit7(out[7], a[7], b[7]);
    or bit8(out[8], a[8], b[8]);
    or bit9(out[9], a[9], b[9]);
    or bit10(out[10], a[10], b[10]);
    or bit11(out[11], a[11], b[11]);
    or bit12(out[12], a[12], b[12]);
    or bit13(out[13], a[13], b[13]);
    or bit14(out[14], a[14], b[14]);
    or bit15(out[15], a[15], b[15]);
    or bit16(out[16], a[16], b[16]);
    or bit17(out[17], a[17], b[17]);
    or bit18(out[18], a[18], b[18]);
    or bit19(out[19], a[19], b[19]);
    or bit20(out[20], a[20], b[20]);
    or bit21(out[21], a[21], b[21]);
    or bit22(out[22], a[22], b[22]);
    or bit23(out[23], a[23], b[23]);
    or bit24(out[24], a[24], b[24]);
    or bit25(out[25], a[25], b[25]);
    or bit26(out[26], a[26], b[26]);
    or bit27(out[27], a[27], b[27]);
    or bit28(out[28], a[28], b[28]);
    or bit29(out[29], a[29], b[29]);
    or bit30(out[30], a[30], b[30]);
    or bit31(out[31], a[31], b[31]);
endmodule
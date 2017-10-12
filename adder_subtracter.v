`include "adder.v"

// 32 bit mux
module mux
  (
    output[31:0] out,
    input address,
    input[31:0] in0,
    input[31:0] in1
  );
  wire invaddr;
  wire in00addr; // input 0 bit 0 andded with address
  wire in01addr;
  wire in02addr;
  wire in03addr;
  wire in04addr;
  wire in05addr;
  wire in06addr;
  wire in07addr;
  wire in08addr;
  wire in09addr;
  wire in010addr;
  wire in011addr;
  wire in012addr;
  wire in013addr;
  wire in014addr;
  wire in015addr;
  wire in016addr;
  wire in017addr;
  wire in018addr;
  wire in019addr;
  wire in020addr;
  wire in021addr;
  wire in022addr;
  wire in023addr;
  wire in024addr;
  wire in025addr;
  wire in026addr;
  wire in027addr;
  wire in028addr;
  wire in029addr;
  wire in030addr;
  wire in031addr;
  wire in10addr;
  wire in11addr;
  wire in12addr;
  wire in13addr;
  wire in14addr;
  wire in15addr;
  wire in16addr;
  wire in17addr;
  wire in18addr;
  wire in19addr;
  wire in110addr;
  wire in111addr;
  wire in112addr;
  wire in113addr;
  wire in114addr;
  wire in115addr;
  wire in116addr;
  wire in117addr;
  wire in118addr;
  wire in119addr;
  wire in120addr;
  wire in121addr;
  wire in122addr;
  wire in123addr;
  wire in124addr;
  wire in125addr;
  wire in126addr;
  wire in127addr;
  wire in128addr;
  wire in129addr;
  wire in130addr;
  wire in131addr;

  // inverting address
  not #10 inv(invaddr, address);
  // and all bits in input 0 with inverted address
  and #20 and00(in00addr, in0[0], invaddr);
  and #20 and01(in01addr, in0[1], invaddr);
  and #20 and02(in02addr, in0[2], invaddr);
  and #20 and03(in03addr, in0[3], invaddr);
  and #20 and04(in04addr, in0[4], invaddr);
  and #20 and05(in05addr, in0[5], invaddr);
  and #20 and06(in06addr, in0[6], invaddr);
  and #20 and07(in07addr, in0[7], invaddr);
  and #20 and08(in08addr, in0[8], invaddr);
  and #20 and09(in09addr, in0[9], invaddr);
  and #20 and010(in010addr, in0[10], invaddr);
  and #20 and011(in011addr, in0[11], invaddr);
  and #20 and012(in012addr, in0[12], invaddr);
  and #20 and013(in013addr, in0[13], invaddr);
  and #20 and014(in014addr, in0[14], invaddr);
  and #20 and015(in015addr, in0[15], invaddr);
  and #20 and016(in016addr, in0[16], invaddr);
  and #20 and017(in017addr, in0[17], invaddr);
  and #20 and018(in018addr, in0[18], invaddr);
  and #20 and019(in019addr, in0[19], invaddr);
  and #20 and020(in020addr, in0[20], invaddr);
  and #20 and021(in021addr, in0[21], invaddr);
  and #20 and022(in022addr, in0[22], invaddr);
  and #20 and023(in023addr, in0[23], invaddr);
  and #20 and024(in024addr, in0[24], invaddr);
  and #20 and025(in025addr, in0[25], invaddr);
  and #20 and026(in026addr, in0[26], invaddr);
  and #20 and027(in027addr, in0[27], invaddr);
  and #20 and028(in028addr, in0[28], invaddr);
  and #20 and029(in029addr, in0[29], invaddr);
  and #20 and030(in030addr, in0[30], invaddr);
  and #20 and031(in031addr, in0[31], invaddr);
  // and all bits in input 1 with address
  and #20 and10(in10addr, in1[0], address);
  and #20 and11(in11addr, in1[1], address);
  and #20 and12(in12addr, in1[2], address);
  and #20 and13(in13addr, in1[3], address);
  and #20 and14(in14addr, in1[4], address);
  and #20 and15(in15addr, in1[5], address);
  and #20 and16(in16addr, in1[6], address);
  and #20 and17(in17addr, in1[7], address);
  and #20 and18(in18addr, in1[8], address);
  and #20 and19(in19addr, in1[9], address);
  and #20 and110(in110addr, in1[10], address);
  and #20 and111(in111addr, in1[11], address);
  and #20 and112(in112addr, in1[12], address);
  and #20 and113(in113addr, in1[13], address);
  and #20 and114(in114addr, in1[14], address);
  and #20 and115(in115addr, in1[15], address);
  and #20 and116(in116addr, in1[16], address);
  and #20 and117(in117addr, in1[17], address);
  and #20 and118(in118addr, in1[18], address);
  and #20 and119(in119addr, in1[19], address);
  and #20 and120(in120addr, in1[20], address);
  and #20 and121(in121addr, in1[21], address);
  and #20 and122(in122addr, in1[22], address);
  and #20 and123(in123addr, in1[23], address);
  and #20 and124(in124addr, in1[24], address);
  and #20 and125(in125addr, in1[25], address);
  and #20 and126(in126addr, in1[26], address);
  and #20 and127(in127addr, in1[27], address);
  and #20 and128(in128addr, in1[28], address);
  and #20 and129(in129addr, in1[29], address);
  and #20 and130(in130addr, in1[30], address);
  and #20 and131(in131addr, in1[31], address);

  // or the and gates
  or #20 or0(out[0], in00addr, in10addr);
  or #20 or1(out[1], in01addr, in11addr);
  or #20 or2(out[2], in02addr, in12addr);
  or #20 or3(out[3], in03addr, in13addr);
  or #20 or4(out[4], in04addr, in14addr);
  or #20 or5(out[5], in05addr, in15addr);
  or #20 or6(out[6], in06addr, in16addr);
  or #20 or7(out[7], in07addr, in17addr);
  or #20 or8(out[8], in08addr, in18addr);
  or #20 or9(out[9], in09addr, in19addr);
  or #20 or10(out[10], in010addr, in110addr);
  or #20 or11(out[11], in011addr, in111addr);
  or #20 or12(out[12], in012addr, in112addr);
  or #20 or13(out[13], in013addr, in113addr);
  or #20 or14(out[14], in014addr, in114addr);
  or #20 or15(out[15], in015addr, in115addr);
  or #20 or16(out[16], in016addr, in116addr);
  or #20 or17(out[17], in017addr, in117addr);
  or #20 or18(out[18], in018addr, in118addr);
  or #20 or19(out[19], in019addr, in119addr);
  or #20 or20(out[20], in020addr, in120addr);
  or #20 or21(out[21], in021addr, in121addr);
  or #20 or22(out[22], in022addr, in122addr);
  or #20 or23(out[23], in023addr, in123addr);
  or #20 or24(out[24], in024addr, in124addr);
  or #20 or25(out[25], in025addr, in125addr);
  or #20 or26(out[26], in026addr, in126addr);
  or #20 or27(out[27], in027addr, in127addr);
  or #20 or28(out[28], in028addr, in128addr);
  or #20 or29(out[29], in029addr, in129addr);
  or #20 or30(out[30], in030addr, in130addr);
  or #20 or31(out[31], in031addr, in131addr);
endmodule

// 32 bit adder/subtracter that determines what operation to conduct based on the input command
module adder_subtracter
  (
    output[31:0] ans,
    output carryout,
    output overflow,
    input[31:0] opA,
    input[31:0] opB,
    input[2:0] command
  );
  wire[31:0] invertedB; //wire to invert b in the event of a subtraction
  wire[31:0] finalB;
  wire normalB; //added b
  wire cout0;
  wire cout1;
  wire cout2;
  wire cout3;
  wire cout4;
  wire cout5;
  wire cout6;
  wire _;
  wire _1;
  wire _2;
  wire _3;
  wire _4;
  wire _5;
  wire _6;
  
  // invert B in the case of two's complement
  not #10 invertB0(invertedB[0], opB[0]);
  not #10 invertB1(invertedB[1], opB[1]);
  not #10 invertB2(invertedB[2], opB[2]);
  not #10 invertB3(invertedB[3], opB[3]);
  not #10 invertB4(invertedB[4], opB[4]);
  not #10 invertB5(invertedB[5], opB[5]);
  not #10 invertB6(invertedB[6], opB[6]);
  not #10 invertB7(invertedB[7], opB[7]);
  not #10 invertB8(invertedB[8], opB[8]);
  not #10 invertB9(invertedB[9], opB[9]);
  not #10 invertB10(invertedB[10], opB[10]);
  not #10 invertB11(invertedB[11], opB[11]);
  not #10 invertB12(invertedB[12], opB[12]);
  not #10 invertB13(invertedB[13], opB[13]);
  not #10 invertB14(invertedB[14], opB[14]);
  not #10 invertB15(invertedB[15], opB[15]);
  not #10 invertB16(invertedB[16], opB[16]);
  not #10 invertB17(invertedB[17], opB[17]);
  not #10 invertB18(invertedB[18], opB[18]);
  not #10 invertB19(invertedB[19], opB[19]);
  not #10 invertB20(invertedB[20], opB[20]);
  not #10 invertB21(invertedB[21], opB[21]);
  not #10 invertB22(invertedB[22], opB[22]);
  not #10 invertB23(invertedB[23], opB[23]);
  not #10 invertB24(invertedB[24], opB[24]);
  not #10 invertB25(invertedB[25], opB[25]);
  not #10 invertB26(invertedB[26], opB[26]);
  not #10 invertB27(invertedB[27], opB[27]);
  not #10 invertB28(invertedB[28], opB[28]);
  not #10 invertB29(invertedB[29], opB[29]);
  not #10 invertB30(invertedB[30], opB[30]);
  not #10 invertB31(invertedB[31], opB[31]);

  // mux chooses between inverted B or normal B based on addition or subtraction
  mux addsubmux(finalB[31:0],command[0],opB[31:0], invertedB[31:0]);
  
  // coupling 4 adders makes a 32-bit adder, note that overflow flags do not matter except for the last one
  FullAdder4bit #50 adder0(ans[3:0], cout0, _, opA[3:0], finalB[3:0], command[0]);  // put least significant command bit into the adder carryin since it adds 1 for when subtracting, and 0 when adding
  FullAdder4bit #50 adder1(ans[7:4], cout1, _1, opA[7:4], finalB[7:4], cout0);
  FullAdder4bit #50 adder2(ans[11:8], cout2, _2, opA[11:8], finalB[11:8], cout1);
  FullAdder4bit #50 adder3(ans[15:12], cout3, _3, opA[15:12], finalB[15:12], cout2);
  FullAdder4bit #50 adder4(ans[19:16], cout4, _4, opA[19:16], finalB[19:16], cout3);
  FullAdder4bit #50 adder5(ans[23:20], cout5, _5, opA[23:20], finalB[23:20], cout4);
  FullAdder4bit #50 adder6(ans[27:24], cout6, _6, opA[27:24], finalB[27:24], cout5);
  FullAdder4bit #50 adder7(ans[31:28], carryout, overflow, opA[31:28], finalB[31:28], cout6);

endmodule
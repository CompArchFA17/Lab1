`include "adder.v"

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

  not inv(invaddr, address);
  and and00(in00addr, in0[0], invaddr);
  and and01(in01addr, in0[1], invaddr);
  and and02(in02addr, in0[2], invaddr);
  and and03(in03addr, in0[3], invaddr);
  and and04(in04addr, in0[4], invaddr);
  and and05(in05addr, in0[5], invaddr);
  and and06(in06addr, in0[6], invaddr);
  and and07(in07addr, in0[7], invaddr);
  and and08(in08addr, in0[8], invaddr);
  and and09(in09addr, in0[9], invaddr);
  and and010(in010addr, in0[10], invaddr);
  and and011(in011addr, in0[11], invaddr);
  and and012(in012addr, in0[12], invaddr);
  and and013(in013addr, in0[13], invaddr);
  and and014(in014addr, in0[14], invaddr);
  and and015(in015addr, in0[15], invaddr);
  and and016(in016addr, in0[16], invaddr);
  and and017(in017addr, in0[17], invaddr);
  and and018(in018addr, in0[18], invaddr);
  and and019(in019addr, in0[19], invaddr);
  and and020(in020addr, in0[20], invaddr);
  and and021(in021addr, in0[21], invaddr);
  and and022(in022addr, in0[22], invaddr);
  and and023(in023addr, in0[23], invaddr);
  and and024(in024addr, in0[24], invaddr);
  and and025(in025addr, in0[25], invaddr);
  and and026(in026addr, in0[26], invaddr);
  and and027(in027addr, in0[27], invaddr);
  and and028(in028addr, in0[28], invaddr);
  and and029(in029addr, in0[29], invaddr);
  and and030(in030addr, in0[30], invaddr);
  and and031(in031addr, in0[31], invaddr);
  and and10(in10addr, in1[0], address);
  and and11(in11addr, in1[1], address);
  and and12(in12addr, in1[2], address);
  and and13(in13addr, in1[3], address);
  and and14(in14addr, in1[4], address);
  and and15(in15addr, in1[5], address);
  and and16(in16addr, in1[6], address);
  and and17(in17addr, in1[7], address);
  and and18(in18addr, in1[8], address);
  and and19(in19addr, in1[9], address);
  and and110(in110addr, in1[10], address);
  and and111(in111addr, in1[11], address);
  and and112(in112addr, in1[12], address);
  and and113(in113addr, in1[13], address);
  and and114(in114addr, in1[14], address);
  and and115(in115addr, in1[15], address);
  and and116(in116addr, in1[16], address);
  and and117(in117addr, in1[17], address);
  and and118(in118addr, in1[18], address);
  and and119(in119addr, in1[19], address);
  and and120(in120addr, in1[20], address);
  and and121(in121addr, in1[21], address);
  and and122(in122addr, in1[22], address);
  and and123(in123addr, in1[23], address);
  and and124(in124addr, in1[24], address);
  and and125(in125addr, in1[25], address);
  and and126(in126addr, in1[26], address);
  and and127(in127addr, in1[27], address);
  and and128(in128addr, in1[28], address);
  and and129(in129addr, in1[29], address);
  and and130(in130addr, in1[30], address);
  and and131(in131addr, in1[31], address);

  or or0(out[0], in00addr, in10addr);
  or or1(out[1], in01addr, in11addr);
  or or2(out[2], in02addr, in12addr);
  or or3(out[3], in03addr, in13addr);
  or or4(out[4], in04addr, in14addr);
  or or5(out[5], in05addr, in15addr);
  or or6(out[6], in06addr, in16addr);
  or or7(out[7], in07addr, in17addr);
  or or8(out[8], in08addr, in18addr);
  or or9(out[9], in09addr, in19addr);
  or or10(out[10], in010addr, in110addr);
  or or11(out[11], in011addr, in111addr);
  or or12(out[12], in012addr, in112addr);
  or or13(out[13], in013addr, in113addr);
  or or14(out[14], in014addr, in114addr);
  or or15(out[15], in015addr, in115addr);
  or or16(out[16], in016addr, in116addr);
  or or17(out[17], in017addr, in117addr);
  or or18(out[18], in018addr, in118addr);
  or or19(out[19], in019addr, in119addr);
  or or20(out[20], in020addr, in120addr);
  or or21(out[21], in021addr, in121addr);
  or or22(out[22], in022addr, in122addr);
  or or23(out[23], in023addr, in123addr);
  or or24(out[24], in024addr, in124addr);
  or or25(out[25], in025addr, in125addr);
  or or26(out[26], in026addr, in126addr);
  or or27(out[27], in027addr, in127addr);
  or or28(out[28], in028addr, in128addr);
  or or29(out[29], in029addr, in129addr);
  or or30(out[30], in030addr, in130addr);
  or or31(out[31], in031addr, in131addr);
endmodule

module adder_subtracter
  (
    output[31:0] ans,
    output carryout,
    output overflow,
    output[31:0] finalB,
    input[31:0] opA,
    input[31:0] opB,
    input[2:0] command
  );
  wire[31:0] invertedB; //wire to invert b in the event of a subtraction
  // wire[31:0] finalB;
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
  
  not invertB0(invertedB[0], opB[0]);
  not invertB1(invertedB[1], opB[1]);
  not invertB2(invertedB[2], opB[2]);
  not invertB3(invertedB[3], opB[3]);
  not invertB4(invertedB[4], opB[4]);
  not invertB5(invertedB[5], opB[5]);
  not invertB6(invertedB[6], opB[6]);
  not invertB7(invertedB[7], opB[7]);
  not invertB8(invertedB[8], opB[8]);
  not invertB9(invertedB[9], opB[9]);
  not invertB10(invertedB[10], opB[10]);
  not invertB11(invertedB[11], opB[11]);
  not invertB12(invertedB[12], opB[12]);
  not invertB13(invertedB[13], opB[13]);
  not invertB14(invertedB[14], opB[14]);
  not invertB15(invertedB[15], opB[15]);
  not invertB16(invertedB[16], opB[16]);
  not invertB17(invertedB[17], opB[17]);
  not invertB18(invertedB[18], opB[18]);
  not invertB19(invertedB[19], opB[19]);
  not invertB20(invertedB[20], opB[20]);
  not invertB21(invertedB[21], opB[21]);
  not invertB22(invertedB[22], opB[22]);
  not invertB23(invertedB[23], opB[23]);
  not invertB24(invertedB[24], opB[24]);
  not invertB25(invertedB[25], opB[25]);
  not invertB26(invertedB[26], opB[26]);
  not invertB27(invertedB[27], opB[27]);
  not invertB28(invertedB[28], opB[28]);
  not invertB29(invertedB[29], opB[29]);
  not invertB30(invertedB[30], opB[30]);
  not invertB31(invertedB[31], opB[31]);

  mux addsubmux(finalB[31:0],command[0],opB[31:0], invertedB[31:0]);
  
  FullAdder4bit #50 adder0(ans[3:0], cout0, _, opA[3:0], finalB[3:0], command[0]); //coupling 4 adders makes a 32-bit adder, note that overflow flags do not matter except for the last one
  FullAdder4bit #50 adder1(ans[7:4], cout1, _1, opA[7:4], finalB[7:4], cout0);
  FullAdder4bit #50 adder2(ans[11:8], cout2, _2, opA[11:8], finalB[11:8], cout1);
  FullAdder4bit #50 adder3(ans[15:12], cout3, _3, opA[15:12], finalB[15:12], cout2);
  FullAdder4bit #50 adder4(ans[19:16], cout4, _4, opA[19:16], finalB[19:16], cout3);
  FullAdder4bit #50 adder5(ans[23:20], cout5, _5, opA[23:20], finalB[23:20], cout4);
  FullAdder4bit #50 adder6(ans[27:24], cout6, _6, opA[27:24], finalB[27:24], cout5);
  FullAdder4bit #50 adder7(ans[31:28], carryout, overflow, opA[31:28], finalB[31:28], cout6);

endmodule
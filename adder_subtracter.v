`include "adder.v"

module two_bit_mux
  (
    output out,
    input address,
    input in0, in1
  );
  wire[1:0] inputs = {in1, in0};  
  assign out = inputs[address];
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

  two_bit_mux addsubmux(finalB[31:0],command[0],opB[31:0], invertedB[31:0]);
  
  FullAdder4bit #50 adder0(ans[3:0], cout0, _, opA[3:0], finalB[3:0], 0); //coupling 4 adders makes a 32-bit adder, note that overflow flags do not matter except for the last one
  FullAdder4bit #50 adder1(ans[7:4], cout1, _, opA[7:4], finalB[7:4], cout0);
  FullAdder4bit #50 adder2(ans[11:8], cout2, _, opA[11:8], finalB[11:8], cout1);
  FullAdder4bit #50 adder3(ans[15:12], cout3, _, opA[15:12], finalB[15:12], cout2);
  FullAdder4bit #50 adder4(ans[19:16], cout4, _, opA[19:16], finalB[19:16], cout3);
  FullAdder4bit #50 adder5(ans[23:20], cout5, _, opA[23:20], finalB[23:20], cout4);
  FullAdder4bit #50 adder6(ans[27:24], cout6, _, opA[27:24], finalB[27:24], cout5);
  FullAdder4bit #50 adder7(ans[31:28], carryout, overflow, opA[31:28], finalB[31:28], cout6);

endmodule
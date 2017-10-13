`define XOR  xor  #30
`define OR   or   #30
`define AND  and  #30
`define NOT  not  #10
`define XNOR xnor #20
`define NOR  xor  #20
`define NAND nand #20

module or4(output out, input[3:0] in);
  wire[1:0] ors;
  `OR or_1(ors[0], in[0], in[1]);
  `OR or_2(ors[1], in[2], in[3]);
  `OR or_3(out, ors[0], ors[1]);
endmodule

module or8(output out, input[7:0] in);
  wire[1:0] ors;
  or4 or_1(ors[0], in[3:0]);
  or4 or_2(ors[1], in[7:4]);
  `OR or_3(out, ors[0], ors[1]);
endmodule

module and4(output out, input[3:0] in);
  wire[1:0] ands;
  `AND and_1(ands[0], in[0], in[1]);
  `AND and_2(ands[1], in[2], in[3]);
  `AND and_3(out, ands[0], ands[1]);
endmodule

module and8(output out, input[7:0] in);
  wire[1:0] ands;
  and4 and_1(ands[0], in[3:0]);
  and4 and_2(ands[1], in[7:4]);
  `AND and_3(out, ands[0], ands[1]);
endmodule

module and16(output out, input[15:0] in);
  wire[1:0] ands;
  and8 and_1(ands[0], in[7:0]);
  and8 and_2(ands[1], in[15:8]);
  `AND and_3(out, ands[0], ands[1]);
endmodule

module and32(output out, input[31:0] in);
  wire[1:0] ands;
  and16 and_1(ands[0], in[15:0]);
  and16 and_2(ands[1], in[31:16]);
  `AND and_3(out, ands[0], ands[1]);
endmodule

module and8P(output[7:0] out, input[7:0] A, input[7:0] B);
  genvar i;
  generate
    for(i = 0; i<8; i=i+1) begin: and_slces
      `AND and_inst(out[i], A[i], B[i]);
    end
  endgenerate
endmodule

module or32P(output[31:0] out, input[31:0] A, input[31:0] B);
  genvar i;
  generate
    for(i = 0; i<32; i=i+1) begin: or_slces
      `OR or_inst(out[i], A[i], B[i]);
    end
  endgenerate
endmodule

module unaryMultiplexor(output out, input[7:0] in, input[7:0] sel);
  wire[7:0] ands;
  and8P andP(ands, in, sel);
  or8 ors(out, ands);
endmodule

module halfAdder(
    output sum,
    output carryout,
    input a,
    input b
);
    `XOR axorb(sum,a,b);
    `AND aandb(carryout,a,b);
endmodule

module fullAdder
(
    output sum,
    output carryout,
    input a,
    input b,
    input carryin
);
    wire s1;
    wire c1;
    wire c2;
    halfAdder a1(s1,c1,a,b);
    halfAdder a2(sum, c2, s1, carryin);
    `OR (carryout, c1, c2);
endmodule

module slt(output out,
          input carryin,
          input a, input a_,
          input b, input b_);
  wire lt;
  wire eq;
  wire w0;
  wire invertSLT;
  // a bitwise SLT implementation
  // if a==b, pass on carry in.
  // if a>b, return 1
  // if a<b, return 0
  // out[n] -> carryin[n+1]
  // note that this will always be wrong if
  // the signs of A and B are opposite.
  `XNOR xnorGate(eq, a, b);
  `AND  ltAnd(lt, a, b_);
  `AND  and0(w0, eq, carryin);
  `OR   or1(out,  w0, lt);
endmodule

module mux1(output out, input a, input b, input s);
  wire s_;
  wire w0;
  wire w1;

  `NOT sNot(s_,s);
  `AND aAnd(w0, a, s_);
  `AND bAnd(w1, b, s);
  `OR(out,w0,w1);
endmodule

`define ADDSig  command[0]
`define SUBSig  command[1]
`define XORSig  command[2]
`define SLTSig  command[3]
`define ANDSig  command[4]
`define NANDSig command[5]
`define NORSig  command[6]
`define ORSig   command[7]

module alu1(
    output result,
    output carryout,
    output zero,
    input A,
    input B,
    input carryin,
    input[7:0] command
);
wire[7:0] results;
wire result;
wire[7:0] carryouts;
wire A_, B_;
`NOT an(A_, A);
`NOT bn(B_, B);
fullAdder adder(results[0], carryouts[0], A, B, carryin);
fullAdder sub(results[1], carryouts[1], A, B_, carryin);
`XOR xorGate(results[2], A, B);
//slt is odd. Only the first bit is ever set, but it depends
//on the lest bit. The actual result is handled later,
//in the full ALU
slt sltGate(carryouts[3], carryin, A, A_, B, B_);
`OR  falseGate(results[3], 0, 0);

`AND andGate(results[4], A, B);
`NAND nandGate(results[5], A, B);
`NOR  norGate(results[6], A, B);
`OR   orGate(results[7], A, B);
unaryMultiplexor resMux(result, results, command);
unaryMultiplexor cMux(carryout, carryouts, command);
`NOT(zero, result);
endmodule

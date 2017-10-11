// 4 input MUX
// takes in 4 inputs and two selects and passes through the selected input

`define NAND nand #10
`define NOR nor #10
`define NOT not #10

module multiplexer
(
  output out,
  input a,
  input b,
  input c,
  input d,
  input s1,
  input s0
);
  wire ns0, ns1;
  wire aout, bout, cout, dout;

  `NOT(ns0, s0);
  `NOT(ns1, s1);
  `NAND(aout, s1, s0, a);
  `NAND(bout, s1, ns0, b);
  `NAND(cout, ns1, s0, c);
  `NAND(dout, ns1, ns0, d);

  `NAND(out, aout, bout, cout, dout);
endmodule

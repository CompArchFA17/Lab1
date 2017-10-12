// Full bitslice of ALUE (attaching logic to mux)

`include "aluBit.v"
`include "mux.v"

module aluFullBit
(
  output res,
  output carryAND,
  input a,
  input b,
  input cin,
  input ctrl0,
  input[1:0] sel
);

  wire sumXOR, nab, orNOR;
  aluBit alu (sumXOR, carryAND, nab, orNOR, a, b, cin, ctrl0);

  multiplexer mux (res, sumXOR, orNOR, carryAND, nab, sel[1], sel[0]);

endmodule

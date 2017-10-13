`include "gates.v"

module mux2to1
(
  output  selected,
  input   a,
  input   b,
  input   select
);

  wire d0, d1, nSelect;

  `NOT(nSelect, select);
  `AND(d0, a, nSelect);
  `AND(d1, b, select);
  `OR(selected, d0, d1);

endmodule


module mux8to1
(
  output selected,
  input[7:0] inputs,
  input[2:0] select
);

wire nselect0,nselect1,nselect2;
wire d0, d1, d2, d3, d4, d5, d6, d7;

`NOT(nselect0, select[0]);
`NOT(nselect1, select[1]);
`NOT(nselect2, select[2]);
`AND4(d0, inputs[0], nselect2, nselect1, nselect0);
`AND4(d1, inputs[1], nselect2, nselect1, select[0]);
`AND4(d2, inputs[2], nselect2, select[1], nselect0);
`AND4(d3, inputs[3], nselect2, select[1], select[0]);
`AND4(d4, inputs[4], select[2], nselect1, nselect0);
`AND4(d5, inputs[5], select[2], nselect1, select[0]);
`AND4(d6, inputs[6], select[2], select[1], nselect0);
`AND4(d7, inputs[7], select[2], select[1], select[0]);
`OR8(selected,d0,d1,d2,d3,d4,d5,d6,d7);

endmodule

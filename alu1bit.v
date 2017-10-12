`include "gates.v"
`include "adder1bit.v"
`include "mux.v"

module ALU1bit
(
  output      result,
  output      carryout,
  input[2:0]  operation,
  input       operandA,
  input       operandB,
  input       invertA,
  input       invertB,
  input       carryin,
  input       less
);

  wire nA;
  wire nB;
  wire AnA;
  wire BnB;
  wire AorB;
  wire AandB;
  wire AxorB;
  wire sum;
  wire useCarryout;
  wire _carryout;
  wire[7:0] values;

  `NOT(nA, operandA);
  `NOT(nB, operandB);
  mux2to1 Aselect(AnA, operandA, nA, invertA);
  mux2to1 Bselect(BnB, operandB, nB, invertB);
  `AND(AandB, AnA, BnB);
  `OR(AorB, AnA, BnB);
  `XOR(AxorB, operandA, operandB);
  adder1bit adder(sum, _carryout, AnA, BnB, carryin);

  `NOR3(useCarryout, operation[0], operation[1], operation[2]);
  `AND(carryout, _carryout, useCarryout);

  assign values[0] = sum;
  assign values[1] = AxorB;
  assign values[2] = less;
  assign values[3] = AandB;
  assign values[4] = AorB;
  assign values[5] = 0;
  assign values[6] = 0;
  assign values[7] = 0;

  mux8to1 resultSelect(result, values, operation);

endmodule


module ALU1bitMSB
(
  output      result,
  output      carryout,
  output      overflow,
  output      set,
  input[2:0]  operation,
  input       invertA,
  input       invertB,
  input       carryin,
  input       less
);

  wire nA;
  wire nB;
  wire AnA;
  wire BnB;
  wire AorB;
  wire AandB;
  wire AxorB;
  wire sum;
  wire[7:0] values;

  `NOT(nA, operandA);
  `NOT(nB, operandB);
  mux2to1 Aselect(AnA, operandA, nA, invertA);
  mux2to1 Bselect(BnB, operandB, nB, invertB);
  `AND(AandB, AnA, BnB);
  `AND(AorB, AnA, BnB);
  `XOR(AxorB, AnA, BnB);
  adder1bit adder(sum, carryout, AnA, BnB, carryin);

  assign values[0] = sum;
  assign values[1] = AxorB;
  assign values[2] = less;
  assign values[3] = AandB;
  assign values[4] = AorB;

  mux8to1 resultSelect(result, values, operation);

  assign set = sum;
  `XOR(overflow, carryout, carryin);

endmodule
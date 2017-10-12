`include "gates.v"

module adder1bit
(
    output  sum, 
    output  carryout,
    input   a, 
    input   b, 
    input   carryin
);
  wire BCin;
  wire ACin;
  wire AB;

  wire BxorCin;

  `AND(BCin,b,carryin);
  `AND(ACin,a,carryin);
  `AND(AB, a, b);
  `OR(carryout,BCin,ACin,AB);

  `XOR(BxorCin,b,carryin);
  `XOR(sum,a,BxorCin);

endmodule
module Adder1bit
(
    output sum,
    output carryout,
    input a,
    input b,
    input carryin
);
    wire aandb, aorb;
    wire s, _carryin;
    wire outputIfCarryin, outputIf_Carryin;
    xor(s, a, b);
    xor(sum, s, carryin);
    and(aandb, a, b);
    or(aorb, a, b);
    not(_carryin, carryin);
    and(outputIfCarryin, aandb, _carryin);
    and(outputIf_Carryin, aorb, carryin);
    or(carryout, outputIfCarryin, outputIf_Carryin);
endmodule

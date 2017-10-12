`define ANDgate and #330
`define NOTgate not #10
`define ORgate or #330

`include "multiplexer.v"

module threeBitMux
(
    output out,
    input s0, s1, s2,
    input[7:0] inputs
);
    
    wire result1;
    wire nS2;
    wire result2;
    wire andResult1;
    wire andResult2;

    structuralMultiplexer mux1(result1, s0, s1, inputs[0], inputs[1], inputs[2], inputs[3]);
    structuralMultiplexer mux2(result2, s0, s1, inputs[4], inputs[5], inputs[6], inputs[7]); 

    `NOTgate invS2(nS2, s2);
    `ANDgate and1(andResult1, result1, nS2);
    `ANDgate and2(andResult2, result2, s2);
    `ORgate or1(out, andResult1, andResult2);
endmodule
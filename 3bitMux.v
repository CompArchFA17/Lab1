`define ANDgate and #330
`define NOTgate not #10

`include "multiplexer.v"

module 3bitMux
(
    output out,
    input s0, s1, s2,
    input[7:0] inputs
);
    
    wire result1;
    wire nS0;
    wire result2;
    wire andResult1;
    wire andResult2;

    structuralMultiplexer mux1(result1, s1, s2);
    structuralMultiplexer mux2(result2, s1, s2); 
    
    `NOT invS0(nS0, s0);
    `AND and1(andResult1, result1, s0);
    `AND and2(andResult2, result2, nS0);
    `AND and3(out, andResult1, andResult2);
endmodule

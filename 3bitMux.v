`include "multiplexer.v"

module threeBitMux
(
    output out,
    input[2:0] addr,
    input[7:0] inputs
);
    
    wire result1;
    wire nS2;
    wire result2;
    wire andResult1;
    wire andResult2;

    structuralMultiplexer mux1(result1, addr[0], addr[1], inputs[0], inputs[1], inputs[2], inputs[3]);
    structuralMultiplexer mux2(result2, addr[0], addr[1], inputs[4], inputs[5], inputs[6], inputs[7]); 

    `NOTgate invS2(nS2, addr[2]);
    `ANDgate and1(andResult1, result1, nS2);
    `ANDgate and2(andResult2, result2, addr[2]);
    `ORgate or1(out, andResult1, andResult2);
endmodule
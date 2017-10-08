// Adder circuit

module behavioralFullAdder
(
    output sum, 
    output carryout,
    input a, 
    input b, 
    input carryin
);
    // Uses concatenation operator and built-in '+'
    assign {carryout, sum}=a+b+carryin;
endmodule

module structuralFullAdder
(
    output sum, 
    output carryout,
    input a, 
    input b, 
    input carryin
);
    wire ab;    //setting up wires
    wire acarryin;
    wire bcarryin;
    wire orpairintermediate;
    wire orsingleintermediate;
    wire orall;
    wire andsumintermediate;
    wire andsingleintermediate;
    wire andall;
    wire invcarryout;
    and #(50) andab(ab, a, b);  // a and b
    and #(50) andacarryin(acarryin, a, carryin);    // a and carryin
    and #(50) andbcarryin(bcarryin, b, carryin);    // b and carryin
    or #(50) orpair(orpairintermediate, ab, acarryin);  // (a and b) or (a and carryin)
    or #(50) orcarryout(carryout, orpairintermediate, bcarryin);    // ((a and b) or (a and carryin)) or (b and carryin)
    or #(50) orintermediate(orsingleintermediate, a, b);    // a or b
    or #(50) orallinputs(orall, orsingleintermediate, carryin); // (a or b) or carryin
    not #(50) inv(invcarryout, carryout);   // not carryout
    and #(50) sumintermediate(andsumintermediate, invcarryout, orall);  // (a or b or carryin) and not carryout
    and #(50) andintermediate(andsingleintermediate, a, b); // a and b
    and #(50) andallinputs(andall, andsingleintermediate, carryin); // (a and b) and carryin
    or #(50) adder(sum, andsumintermediate, andall);    // ((a or b or carryin) and not carryout) or (a and b and c)
endmodule

module FullAdder4bit
(
  output[3:0] sum,  // 2's complement sum of a and b
  output carryout,  // Carry out of the summation of a and b
  output overflow,  // True if the calculation resulted in an overflow
  input[3:0] a,     // First operand in 2's complement format
  input[3:0] b,      // Second operand in 2's complement format
  input carryin
);
    wire carryout1; // wire setup for carryouts from each adder
    wire carryout2;
    wire carryout3;
    wire aandb;
    wire anorb;
    wire bandsum;
    wire bnorsum;
    wire abandnoror;
    wire bsumandnornor;
    structuralFullAdder #50 adder1(sum[0], carryout1, a[0], b[0], carryin);   // first adder to handle the first added bits
    structuralFullAdder #50 adder2(sum[1], carryout2, a[1], b[1], carryout1);   // second adder to take the carryout from the first adder and the next added bits
    structuralFullAdder #50 adder3(sum[2], carryout3, a[2], b[2], carryout2);   // third adder to take the second carryout and the third added bits
    structuralFullAdder #50 adder4(sum[3], carryout, a[3], b[3], carryout3);    // fourth adder to take the third carryout and the fourth bits
    and #50 andinputs(aandb, a[3], b[3]);   // logic to determine overflow (overflow occurs when two positives result in a negative or two negatives result in a positive, the larges bit in both inputs are equal and the largest bit in the output is not the same)
    nor #50 norinputs(anorb, a[3], b[3]);
    and #50 andsum(bandsum, b[3], sum[3]);
    nor #50 norsum(bnorsum, b[3], sum[3]);
    or #50 orinputcombs(abandnoror, aandb, anorb);
    nor #50 norsumcombs(bsumandnornor, bandsum, bnorsum);
    and #50 finaland(overflow, abandnoror, bsumandnornor);
endmodule
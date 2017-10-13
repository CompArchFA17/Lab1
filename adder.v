module fullAdder1bit
(
    output sum, 
    output carryout,
    input a, 
    input b, 
    input carryin
);
    wire axorb;
    wire nCarryIn;
    wire notaxorb;
    wire sumWire0;
    wire sumWire1;
    
    `XORgate abxorgate(axorb, a, b);
    `ANDgate andgate0(sumWire0, axorb, nCarryIn);
    `NOTgate invCarryIn(nCarryIn, carryin);
    `NOTgate invaxorb(notaxorb, axorb);
    `ANDgate andgate1(sumWire1, carryin, notaxorb);
    `ORgate orgate0(sum, sumWire0, sumWire1);

    wire aandb;
    wire aorb;
    wire carryOutWire;
    
    `ANDgate abandgate(aandb, a, b);
    `ORgate orgate1(aorb, a, b);
    `ANDgate andgate2(carryOutWire, carryin, aorb);
    `ORgate orgate2(carryout, aandb, carryOutWire);
endmodule
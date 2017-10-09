module Subtractor1bit
(
    output diff,
    output borrowout,
    input a,
    input b,
    input borrowin
);
    wire axorb;
    xor(axorb, a, b);
    xor(diff, axorb, borrowin);
    wire nota, noteaandb, notaxorb, notaxorbandborrowin;
    not(nota, a);
    and(notaandb, nota, b);
    not(notaxorb, axorb);
    and(notaxorbandborrowin, notaxorb, borrowin);
    or(borrowout, notaandb, notaxorbandborrowin);
endmodule

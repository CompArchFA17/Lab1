module MUX3bit
(
    output out,
    input[2:0] address,
    input[7:0] inputs
);
    assign out = inputs[address];
endmodule

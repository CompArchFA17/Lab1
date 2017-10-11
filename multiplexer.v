// define gates with delays

// Multiplexer circuit

module behavioralMultiplexer
(
    output[31:0] out,
    input[2:0] address, // address0, address1, address2,
    input[31:0] in0, in1, in2, in3, in4, in5, in6, in7
);
    // Join single-bit inputs into a bus, use address as index
    wire [7:0] tempinputs[31:0];
    assign tempinputs[0] = in0;

    assign out = tempinputs[address];
endmodule

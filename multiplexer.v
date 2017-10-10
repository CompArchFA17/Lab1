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
    //wire[7:0] inputs = {in7, in6, in5, in4, in3, in2, in1, in0};
    //wire[2:0] address = {address2, address1, address0};
    assign out = tempinputs[address];
endmodule


// module structuralMultiplexer
// (
//     output[31:0] out,
//     input addr0, addr1, addr2,
//     input[31:0] in0, in1, in2, in3, in4, in5, in6, in7
// );
//     // Your multiplexer code here
// wire naddr0, naddr1, naddr2;
// wire[31:0] selectin0, selectin1, selectin2, selectin3, selectin4, selectin5, selectin6, selectin7;
// `NOT notaddr0(naddr0, addr0);
// `NOT notaddr1(naddr1, addr1);
// `NOT notaddr2(naddr2, addr2);

// `AND getin0(selectin0, in0, naddr2, naddr1, naddr0);
// `AND getin1(selectin1, in1, naddr2, naddr1, addr0);
// `AND getin2(selectin2, in2, naddr2, addr1, naddr0);
// `AND getin3(selectin3, in3, naddr2, addr1, addr0);

// `AND getin4(selectin4, in4, addr2, naddr1, naddr0);
// `AND getin5(selectin5, in5, addr2, naddr1, addr0);
// `AND getin6(selectin6, in6, addr2, addr1, naddr0);
// `AND getin7(selectin7, in7, addr2, addr1, addr0);

// //Getting the output:
// `OR getoutput(out, selectin0, selectin1, selectin2, selectin3, selectin4, selectin5, selectin6, selectin7);


// endmodule
// Multiplexer circuit
`define AND and #50
`define OR or #50
`define NOT not #50
module behavioralMultiplexer
(
    output out,
    input address0, address1,
    input in0, in1, in2, in3
);
    // Join single-bit inputs into a bus, use address as index
    wire[3:0] inputs = {in3, in2, in1, in0};
    wire[1:0] address = {address1, address0};
    assign out = inputs[address];
endmodule


module structuralMultiplexer
(
    output out,
    input address0, address1,
    input in0, in1, in2, in3
);
    // Your multiplexer code here
    wire nA0;
    wire nA1;
    wire input0Wire0;
    wire input0Wire1;
    wire input1Wire0;
    wire input1Wire1;
    wire input2Wire0;
    wire input2Wire1;
    wire input3Wire0;
    wire input3Wire1;
    wire orWire0;
    wire orWire1;

    `NOT invA0(nA0, address0);
    `NOT invA1(nA1, address1);
    `AND input0And0(input0Wire0, nA0, nA1);
    `AND input0And1(input0Wire1, input0Wire0, in0);
    `AND input1And0(input1Wire0, address0, nA1);
    `AND input1And1(input1Wire1, input1Wire0, in1);
    `AND input2And0(input2Wire0, nA0, address1);
    `AND input2And1(input2Wire1, input2Wire0, in2);
    `AND input3And0(input3Wire0, address0, address1);
    `AND input3And1(input3Wire1, input3Wire0, in3);

    `OR or1(orWire0, input0Wire1, input1Wire1);
    `OR or2(orWire1, orWire0, input2Wire1);
    `OR or3(out, orWire1, input3Wire1);
endmodule


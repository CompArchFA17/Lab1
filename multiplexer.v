// 2bit address Multiplexer circuit
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

    `NOTgate invA0(nA0, address0);
    `NOTgate invA1(nA1, address1);
    `ANDgate input0And0(input0Wire0, nA0, nA1);
    `ANDgate input0And1(input0Wire1, input0Wire0, in0);
    `ANDgate input1And0(input1Wire0, address0, nA1);
    `ANDgate input1And1(input1Wire1, input1Wire0, in1);
    `ANDgate input2And0(input2Wire0, nA0, address1);
    `ANDgate input2And1(input2Wire1, input2Wire0, in2);
    `ANDgate input3And0(input3Wire0, address0, address1);
    `ANDgate input3And1(input3Wire1, input3Wire0, in3);

    `ORgate or1(orWire0, input0Wire1, input1Wire1);
    `ORgate or2(orWire1, orWire0, input2Wire1);
    `ORgate or3(out, orWire1, input3Wire1);
endmodule


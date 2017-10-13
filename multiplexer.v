`define AND and #20
`define OR or #20
`define XOR xor #20 //????
`define NOT not #10
`define NAND nand #10
`define NOR nor #10
`define NAND3 nand #20
`define NAND4 nand #30

module bitMultiplexer
(
    output out,
    input addr,
    input[1:0] in
);
    wire naddr;
    `NOT n_addr(naddr, addr);
    `AND and_0(o0, in[0], naddr);
    `AND and_1(o1, in[1], addr);
    `OR or_out(out, o0, o1);
endmodule

module Multiplexer2
(
    output out,
    input [1:0] address,
    input [3:0] in
);
    wire nA0, nA1;
    wire[3:0] preout;
    `NOT A0inv(nA0, address[0]); 
    `NOT A1inv(nA1, address[1]);
    `NAND3 AG0(preout[0], nA0, nA1, in[0]);
    `NAND3 AG1(preout[1], address[0], nA1, in[1]);
    `NAND3 AG2(preout[2], address[1], nA0, in[2]);
    `NAND3 AG3(preout[3], address[0], address[1], in[3]);
    `NAND4 AGT(out, preout[0], preout[1], preout[2], preout[3]);

endmodule


// module Multiplexer3
// (
//     output out,
//     input[2:0] address,
//     input[7:0] in
// );
//     wire[3:0] mux;
//     wire[1:0] muxmid;
//     bitMultiplexer mux_0(mux[0], address[0], in[1:0]);
//     bitMultiplexer mux_1(mux[1], address[0], in[3:2]);
//     bitMultiplexer mux_2(mux[2], address[0], in[5:4]);
//     bitMultiplexer mux_3(mux[3], address[0], in[7:6]);
//     bitMultiplexer mux_mid_0(muxmid[0], address[1], mux[1:0]);
//     bitMultiplexer mux_mid_1(muxmid[1], address[1], mux[3:2]);
//     bitMultiplexer mux_out(out, address[2], muxmid[1:0]);
// endmodule

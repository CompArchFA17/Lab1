`define AND and #20     // nand with nor is 20 
`define NAND nand #10   // base is 10
`define NOT not #10     // not base is 10
`define OR or #20       // nor with not is 20
`define NOR nor #10     // base is 10 
`define XOR xor #40     // and with or is 40

module TwoInMux
(
    output out,
    input S,
    input in0, in1
);   
    wire nS; 
    wire out0; 
    wire out1; 

    `NOT Sinv(nS, S);   
    `NAND n0(out0, nS, in0);
    `NAND n1(out1, S, in1);
    `NAND addthem(out, out0, out1);  // final output of mux

endmodule

module AndNand
(
output AndNandOut, 
input A, B, 
input[2:0] Command 

);

wire AnandB;
wire AandB;
//wire[2:0] Command; 

	`NAND n0(AnandB, A, B);
	`NOT inv0(AandB, AnandB);
	TwoInMux potato(AndNandOut, Command[0], A, B);    // order to follow out,S,in0, in1

endmodule


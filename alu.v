`include "adder.v"
`include "multiplexer.v"
`include "lut.v"
`include "aluFullBit.v"

`define AND and #30
`define OR or #30
`define NOT not #10
`define XOR xor #50
`define NAND nand #20
`define NOR nor #20


module ALU
(
output[31:0]  result,
output        carryout,
output        zero,
output        overflow,
input[31:0]   operandA,
input[31:0]   operandB,
input[2:0]    command
);

wire [31:0] operandA, operandB, result, cIn, cOut;
wire [2:0] command;

wire [1:0] select;

ALULut (select, invert, command);

//invert B

aluFullBit (result[0], cOut[0], operandA[0], operandB[0], 1'b0, command[0], select[1:0]);


genvar i;
    generate
        for (i=1; i < 32; i=i+1) begin : aluBits
            aluFullBit (result[i], cOut[i], operandA[i], operandB[i], cIn[i], command[0], select[1:0]
        end
    endgenerate
	
wire partialOverflow;
`XOR (partialOverflow, cOut[30], cOut[31]);

wire [1:0] nSelect;
`NOT (notSel[0], sel[0]);
`NOT (notSel[1], sel[1]);

and #40 (carryout, carryoutSlice[31], notSel[0], notSel[1]);
and #40 (overflow, initialOverflow, notSel[0], notSel[1]);

wire [30:0] ors;
`OR (ors[0], result[0], result[1]);

generate
	for (i=0; i < 30; i=i+1) begin : zeroFlag
		`OR (ors[i+1], result[i+1], ors[i]);
	end
endgenerate

`NOT (zero, ors[30]);

endmodule
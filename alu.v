`include "adder.v"
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

wire [31:0] operandA, operandB, finalB, partialResult, result, cIn, cOut;
wire [2:0] command;

//wire[1:0] tmp_s;
wire [1:0] select;
/*`OR(tmp_s[0], command[0], command[1]);
`NOT(tmp_s[1], command[1]);
`NAND(select[0], command[2], tmp_s[0]);
`NAND(select[1], command[2], tmp_s[1]);
*/

wire sltFlag;
wire aLessB;
wire nCommand;

ALULut _lut(select[1:0], invert, carry, command[2:0]);

`XOR (finalB[0], operandB[0], invert);
`AND (cIn[0], carry, command[0]);

`NOT (nCommand, command[0]);
`NOR (sltFlag, command[2], command[1], nCommand);
`AND (result[0], partialResult[0], sltFlag, aLessB);

aluFullBit _bit(partialResult[0], cOut[0], operandA[0], finalB[0], cIn[0], command[0], select[1:0]);

genvar i;
    generate
        for (i=1; i < 32; i=i+1) begin : aluBits
			`XOR (finalB[i], operandB[i], invert);
			`AND (cIn[i], carry, cOut[i-1]);
			`AND (result[i], partialResult[i], sltFlag);
            aluFullBit _bit(partialResult[i], cOut[i], operandA[i], finalB[i], cIn[i], command[0], select[1:0]);
        end
    endgenerate
	
wire partialOverflow;
`XOR (partialOverflow, cOut[30], cOut[31]);

wire [1:0] nSelect;

and #40 (carryout, cOut[31], select[0], select[1]);
and #40 (overflow, partialOverflow, select[0], select[1]);


wire [30:0] zeroFlags;
`OR (zeroFlags[0], result[0], result[1]);

generate
	for (i=0; i < 30; i=i+1) begin : zeroFlag
		`OR (zeroFlags[i+1], result[i+1], zeroFlags[i]);
	end
endgenerate

wire zeroPartial;
`NOT (zeroPartial, zeroFlags[30]);
and #40 (zero, zeroPartial, select[0], select[1]);

//`XOR (aLessB, partialOverflow, result[31]);


endmodule

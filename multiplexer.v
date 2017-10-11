`define AND and #50
`define OR or #90
`define NOT not #10

// Multiplexer circuit

module ALUMultiplexer
(
    output out,
    input [2:0] select,
    input in0, in1, in2, in3, in4, in5, in6, in7
);

	wire [2:0] select;
	wire in0, in1, in2, in3, in4, in5, in6, in7;
	
	wire [2:0] nSelect;
	wire [7:0] partialOutput;

	`NOT (nSelect[0], select[0]);
    `NOT (nSelect[1], select[1]);
    `NOT (nSelect[2], select[2]);
	
    `AND (partialOutput[0], in0, nSelect[2], nSelect[1], nSelect[0]);
    `AND (partialOutput[1], in1, nSelect[2], nSelect[1], select[0]);
    `AND (partialOutput[2], in2, nSelect[2], select[1], nSelect[0]);
    `AND (partialOutput[3], in3, nSelect[2], select[1], select[0]);
    `AND (partialOutput[4], in4, select[2], nSelect[1], nSelect[0]);
    `AND (partialOutput[5], in5, select[2], nSelect[1], select[0]);
    `AND (partialOutput[6], in6, select[2], select[1], nSelect[0]);
    `AND (partialOutput[7], in7, select[2], select[1], select[0]);
    `OR (out, partialOutput[0], partialOutput[1], partialOutput[2], partialOutput[3], partialOutput[4], partialOutput[5], partialOutput[6], partialOutput[7]);

endmodule
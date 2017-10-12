`define NANDgate nand #320
`define NORgate nor #320
`define NOT not #10

`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

module ALUcontrolLUT //
(
	output reg[2:0] 	muxindex,
	output reg	invertB,
	output reg	less,

	input[2:0]	ALUcommand
)

	always @(ALUcommand) begin
	    case (ALUcommand)
	    	`ADD:  begin muxindex = 0; invertB=0; less = 0; end    
	      	`SUB:  begin muxindex = 0; invertB=1; less = 0; end
	     	`XOR:  begin muxindex = 2; invertB=0; less = 0; end    
		    `SLT:  begin muxindex = 3; invertB=1; less = 1; end
		    `AND:  begin muxindex = 4; invertB=0; less = 0; end    
		    `NAND: begin muxindex = 5; invertB=0; less = 0; end
		    `NOR:  begin muxindex = 6; invertB=0; less = 0; end    
		    `OR:   begin muxindex = 7; invertB=0; less = 0; end
	    endcase
	end
endmodule

module ALUunit // The bitslice ALU unit
(
	output reg bitR, // each bit of result
	output reg carryout, // carryout flag for ADD, SUB, SLT

	input bitA, 	// each bit of operandA
	input bitB, 	// each bit of operandB
	input carryin, 	// carryin input for ADD, SUB, SLT
	input less, 	// a result bit in SLT command.
	input[2:0] control
)

	wire[2:0] muxindex;
	wire invertBflag;

	ALUcontrolLUT controlLUT(muxindex, invertBflag, , control);


	wire notA;
	wire inputB;
	wire nand_AnotB; // for XOR
	wire nand_BnotA; // for XOR
	wire[7:0] muxinput;

	`NOT not_a(notA, bitA);
	`NOT not_b(notB, bitB);

	// needed to implement inputB from bitB and invertBflag (bitB xor invertBflag)

	// needed to import 1bit adder
	Fulladder1bit adder(bitR, carryout, bitA, inputB, carryin);

	assign muxinput[`SLT] = less;
	`NAND nand_anotb_gate(nand_AnotB, bitA, notB);
	`NAND nand_bnota_gate(nand_BnotA, notA, bitB);
	`NAND nand_xor_gate(muxinput[`XOR], nand_AnotB, nand_BnotA)

	`NOT not_and_gate(muxinput[`AND], result[`NAND]);
	`NANDgate nandgate(muxinput[`NAND], bitA, bitB);
	`NORgate norgate(muxinput[`NOR], bitA, bitB);
	`NOT not_or_gate(muxinput[`OR], result[`NOR])

	// needed to import 3bit multiplexer
	Multiplexer mux(bitR, muxindex, muxinput);


endmodule

module lastALUunit // last ALU unit, needed for calculating SLT value and overflow flag.
(
	output reg bitR,
	output reg carryout,
	output reg overflow;
	output reg slt, // signal for less signal of the first ALU unit

	input bitA,
	input bitB,
	input carryin,
	input less,
	input[2:0] control
)

	ALUunit basic_unit(bitR, carryout, bitA, bitB, carryin, control);

	// needed to define XOR gate from NAND, NOT, NOR gate
	xor overflowxorgate(overflow, result[31], carryout);
	xor slt_xorgate(slt, bitR, overflow);

endmodule


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

	wire set_SLT;

	// needed to input 1 on carryin only if command is SUB or SLT.
	ALUunit firstunit(result[0], operandA[0], operandB[0], , set_SLT, command)

	for(int i=1; i<31; i++) begin
		ALUunit unit(result[i], result[i+1], operandA[i], operandB[i], result[i-1], 0, command);
	end
	lastALUunit lastunit(result[31], carryout, overflow, set_SLT, operandA[31], operandB[i], result[30], 0, command);

endmodule
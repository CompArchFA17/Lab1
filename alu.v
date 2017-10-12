`define NANDgate nand #320
`define ANDgate and #330
`define NORgate nor #320
`define ORgate 	or  #330
`define NOTgate not #10
`define XORgate xor #650

`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

`include "adder.v"
`include "3bitMux.v"


module ALUcontrolLUT // control Lookup Table within ALU unit
(
	output reg[2:0] muxindex,
	output reg		invertB, 

	input[2:0]		ALUcommand
);

	always @(ALUcommand) begin
	    case (ALUcommand)
	    	`ADD:  begin muxindex = 0; invertB=0; end    
	      	`SUB:  begin muxindex = 0; invertB=1; end
	     	`XOR:  begin muxindex = 2; invertB=0; end    
		    `SLT:  begin muxindex = 3; invertB=1; end
		    `AND:  begin muxindex = 4; invertB=0; end    
		    `NAND: begin muxindex = 5; invertB=0; end
		    `NOR:  begin muxindex = 6; invertB=0; end    
		    `OR:   begin muxindex = 7; invertB=0; end
	    endcase
	end
endmodule

module ALUunit // The bitslice ALU unit
(
	output bitR, // each bit of result
	output carryout, // carryout flag for ADD, SUB, SLT

	input bitA, 	// each bit of operandA
	input bitB, 	// each bit of operandB
	input carryin, 	// carryin input for ADD, SUB, SLT
	input less, 	// a result bit in SLT command.
	input[2:0] muxindex,
	input invertBflag
);

	wire inputB;		// B input for adder
	wire[7:0] muxinput;

	`XORgate inputB_xorgate(inputB, bitB, invertBflag);

	fullAdder1bit adder(muxinput[`ADD], carryout, bitA, inputB, carryin); // 1 bit adder for ADD, SUB, SLT

	assign muxinput[`SLT] = less;
	`XORgate nand_xor_gate(muxinput[`XOR], bitA, bitB);
	`NOTgate not_and_gate(muxinput[`AND], muxinput[`NAND]);
	`NANDgate nandgate(muxinput[`NAND], bitA, bitB);
	`NORgate norgate(muxinput[`NOR], bitA, bitB);
	`NOTgate not_or_gate(muxinput[`OR], muxinput[`NOR]);

	threeBitMux mux(bitR, muxindex, muxinput);


endmodule

module lastALUunit // last ALU unit, which has an ALU unit with outputs of SLT value and overflow flag.
(
	output bitR,
	output carryout,
	output overflow,
	output slt, // signal for less signal of the first ALU unit

	input bitA,
	input bitB,
	input carryin,
	input less,
	input[2:0] muxindex,
	input invertBflag
);

	ALUunit basic_unit(bitR, carryout, bitA, bitB, carryin, less, muxindex, invertBflag);

	`XORgate overflowxorgate(overflow, bitR, carryout);
	`XORgate slt_xorgate(slt, bitR, overflow);

endmodule


module ALU // total ALU which has 32 basic ALU units and control unit.
(
	output[31:0]  result,
	output        carryout,
	output        zero,
	output        overflow,

	input[31:0]   operandA,
	input[31:0]   operandB,
	input[2:0]    command
);

	wire[2:0] 	muxindex;	//input address of MUX for every ALU unit
	wire 		invertBflag;//invertB flag input for every ALU unit
	wire 		set_SLT;	//less input for the first ALU unit

	ALUcontrolLUT controlLUT(muxindex, invertBflag, command);

	ALUunit firstunit(
		result[0], result[1], // output: result, carryout
		operandA[0], operandB[0], invertBflag, set_SLT, muxindex, invertBflag
	);
	
	generate // 2nd to 31st adder instantiation 
		genvar i;
		for(i=1; i<31; i=i+1) begin: generate_alu_unit
			ALUunit unit(
				result[i],
				result[i+1],//carryout
				operandA[i],
				operandB[i],
				result[i-1],//carryin
				0, 			//result for SLT command
				muxindex,
				invertBflag
			);
		end
	endgenerate
	lastALUunit lastunit(
		result[31], carryout, // output: result, carryout
		overflow, set_SLT, operandA[31], operandB[31], result[30], 0, muxindex, invertBflag
	);

endmodule
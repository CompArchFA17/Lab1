`include "logic32bits.v"
`include "multiplexer.v"
`include "adder.v"
`include "slt.v"

`define opADD  3'd0
`define opSUB  3'd1
`define opXOR  3'd2
`define opSLT  3'd3
`define opAND  3'd4
`define opNAND 3'd5
`define opNOR  3'd6
`define opOR   3'd7

module ALU
(
output reg[31:0] result,
output reg       carryout,
output reg       zero,
output reg       overflow,
input[31:0]   operandA,
input[31:0]   operandB,
input[2:0]    command
);


wire[31:0] add_out, sub_out, xor_out, slt_out, and_out, nand_out, nor_out, or_out;
wire add_carryout, add_overflow, sub_carryout, sub_overflow, add_zero, sub_zero;

FullAdder32bit get_add_out(add_out, add_carryout, add_overflow, operandA, operandB);
Subtractor32bit get_sub_out(operandA, operandB, sub_out, sub_carryout, sub_overflow);
xor32 get_xor( xor_out, operandA, operandB);
SLT get_slt_out(operandA, operandB, slt_out);
and32 get_and(and_out, operandA, operandB);
nand32 get_nand(nand_out, operandA, operandB);
nor32 get_nor(nor_out, operandA, operandB);
or32 get_or(or_out, operandA, operandB);
zero_check zcheck_add(add_zero, add_out);
zero_check zcheck_sub(sub_zero, sub_out);


always @(command) begin
#2000
	case(command) 
		`opADD: begin
			result = add_out;
			carryout = add_carryout;
			overflow = add_overflow;
			zero = add_zero;
		end
		`opSUB: begin
			result = sub_out;
			carryout = sub_carryout;
			overflow = sub_overflow;
			zero = sub_zero;
		end
		`opXOR: begin
			result = xor_out;
			carryout = 1'b0;
			overflow = 1'b0;
			zero = 1'b0;
		end
		`opSLT: begin
			result = slt_out;
			carryout = 1'b0;
			overflow = 1'b0;
			zero = 1'b0;
		end
		`opAND: begin
			result = and_out;
			carryout = 1'b0;
			overflow = 1'b0;
			zero = 1'b0;
		end
		`opNAND: begin
			result = nand_out;
			carryout = 1'b0;
			overflow = 1'b0;
			zero = 1'b0;
		end
		`opNOR: begin
			result = nor_out;
			carryout = 1'b0;
			overflow = 1'b0;
			zero = 1'b0;
		end
		`opOR: begin
			result = or_out;
			carryout = 1'b0;
			overflow = 1'b0;
			zero = 1'b0;
		end
	endcase
end

// behavioralMultiplexer mux (result, command, add_out, sub_out, xor_out, slt_out, and_out, nand_out, nor_out, or_out); // Swap after testing


endmodule
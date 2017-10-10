`define NOR nor #10
`define OR not #20

module AddSub 
(
output[31:0] result,
output carryout,
output zero,
output overflow,
input[31:0] operandA,
input[31:0] operandB
);

	
endmodule


module NOR
(
output[31:0] result,
output carryout,
output zero,
output overflow,
input[31:0] operandA,
input[31:0] operandB
);

genvar i;
for (i = 0; i < 32; i = i + 1) begin
	`NOR norgate (result[i], operandA[i], operandB[i]);
end

endmodule

module OR
(
output[31:0] result,
output carryout,
output zero,
output overflow,
input[31:0] operandA,
input[31:0] operandB
);

genvar i;
for (i = 0; i < 32; i = i + 1) begin
	`OR orgate(result[i], operandA[i], operandB[i]);
end

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
	// Your code here
endmodule

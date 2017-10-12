// 32-bit alu testbench

`timescale 1 ns / 1 ps
`include "alu.v"

`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

module testALU();
    
    reg signed [31:0] operandA;
    reg signed [31:0] operandB;
    reg[2:0] command;

    wire signed [31:0] result;
    wire carryout, zero, overflow;

    ALU alu(result, carryout, zero, overflow, operandA, operandB, command);

    initial begin

        $display("  operandA                         | operandB                         | cmd  | result                           | eResult                          | cOut | eCOut | Overflow | eOverflow | Zero | eZero");
	$display();
	$display("ADD COMMAND -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
	// 2 + 3 = 5
        operandA=32'd2;operandB=32'd3;command=`ADD;
        #10000;
        $display("| %b | %b | AND  | %b | 00000000000000000000000000000101 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	// -30 + 50 = 20
	operandA=-32'd30;operandB=32'd50;command=`ADD;
        #10000;
        $display("| %b | %b | AND  | %b | 00000000000000000000000000010100 | %b    | 1     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	// 2 + (-5) = -3
	operandA=32'd2;operandB=-32'd5;command=`ADD;
        #10000;
        $display("| %b | %b | AND  | %b | 11111111111111111111111111111101 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	// -200 + 200 = 0
	operandA=-32'd200;operandB=32'd200;command=`ADD;
        #10000;
        $display("| %b | %b | AND  | %b | 00000000000000000000000000000000 | %b    | 1     | %b        | 0         | %b    | 1 |", operandA, operandB, result, carryout, overflow, zero);
	// -2 + (-2) = -4
	operandA=-32'd2;operandB=-32'd2;command=`ADD;
        #10000;
        $display("| %b | %b | AND  | %b | 11111111111111111111111111111100 | %b    | 1     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	$display("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");

	$display("SUB COMMAND -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
	// 5 - 3 = 2
        operandA=32'd5;operandB=32'd3;command=`SUB;
        #10000;
        $display("| %b | %b | SUB  | %b | 00000000000000000000000000000010 | %b    | 1     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	// -30 - 50 = -80
	operandA=-32'd30;operandB=32'd50;command=`SUB;
        #10000;
        $display("| %b | %b | SUB  | %b | 11111111111111111111111110110000 | %b    | 1     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	// 2 - (-5) = 7
	operandA=32'd2;operandB=-32'd5;command=`SUB;
        #10000;
        $display("| %b | %b | SUB  | %b | 00000000000000000000000000000111 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	// -200 - (-200) = 0
	operandA=-32'd200;operandB=-32'd200;command=`SUB;
        #10000;
        $display("| %b | %b | SUB  | %b | 00000000000000000000000000000000 | %b    | 1     | %b        | 0         | %b    | 1 |", operandA, operandB, result, carryout, overflow, zero);
	// 2 - 5 = -3
	operandA=32'd2;operandB=32'd5;command=`SUB;
        #10000;
        $display("| %b | %b | SUB  | %b | 11111111111111111111111111111101 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	$display("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");

	$display("XOR COMMAND -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
	//
        operandA=32'b00101110000110101010101010101101;operandB=32'b10101010100001001001110100010111;command=`XOR;
        #10000;
        $display("| %b | %b | XOR  | %b | 10000100100111100011011110111010 | %b    | 1     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	//
	operandA=32'd0;operandB=32'd0;command=`XOR;
        #10000;
        $display("| %b | %b | XOR  | %b | --- | %b    | -     | %b        | -         | %b    | - |", operandA, operandB, result, carryout, overflow, zero);
	//
	operandA=32'd0;operandB=32'd0;command=`XOR;
        #10000;
        $display("| %b | %b | XOR  | %b | --- | %b    | -     | %b        | -         | %b    | - |", operandA, operandB, result, carryout, overflow, zero);
	//
	operandA=32'd0;operandB=32'd0;command=`XOR;
        #10000;
        $display("| %b | %b | XOR  | %b | --- | %b    | -     | %b        | -         | %b    | - |", operandA, operandB, result, carryout, overflow, zero);
	//
	operandA=32'd0;operandB=32'd0;command=`XOR;
        #10000;
        $display("| %b | %b | XOR  | %b | --- | %b    | -     | %b        | -         | %b    | - |", operandA, operandB, result, carryout, overflow, zero);
	$display("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
	
	$display("SLT COMMAND -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
	//
        operandA=32'b00101110000110101010101010101101;operandB=32'b10101010100001001001110100010111;command=`XOR;
        #10000;
        $display("| %b | %b | XOR  | %b | 10000100100111100011011110111010 | %b    | 1     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	//
	operandA=32'd2;operandB=32'd1;command=`SLT;
        #10000;
        $display("| %b | %b | XOR  | %b | --- | %b    | -     | %b        | -         | %b    | - |", operandA, operandB, result, carryout, overflow, zero);
	//
	operandA=32'd3;operandB=32'd5;command=`SLT;
        #10000;
        $display("| %b | %b | XOR  | %b | --- | %b    | -     | %b        | -         | %b    | - |", operandA, operandB, result, carryout, overflow, zero);
	//
	operandA=32'd0;operandB=32'd0;command=`XOR;
        #10000;
        $display("| %b | %b | XOR  | %b | --- | %b    | -     | %b        | -         | %b    | - |", operandA, operandB, result, carryout, overflow, zero);
	//
	operandA=32'd0;operandB=32'd0;command=`XOR;
        #10000;
        $display("| %b | %b | XOR  | %b | --- | %b    | -     | %b        | -         | %b    | - |", operandA, operandB, result, carryout, overflow, zero);
	$display("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");

        // $dumpflush;
    end

endmodule


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
	// 2000 + 2147483000 = 
        operandA=32'd2000;operandB=32'd2147483000;command=`ADD;
        #10000;
        $display("| %b | %b | ADD  | %b | 10000000000000000000010101001000 | %b    | 0     | %b        | 1         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	// -30 + 50 = 20
	operandA=-32'd30;operandB=32'd50;command=`ADD;
        #10000;
        $display("| %b | %b | ADD  | %b | 00000000000000000000000000010100 | %b    | 1     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	// 2 + (-5) = -3
	operandA=32'd2;operandB=-32'd5;command=`ADD;
        #10000;
        $display("| %b | %b | ADD  | %b | 11111111111111111111111111111101 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	// -200 + 200 = 0
	operandA=-32'd200;operandB=32'd200;command=`ADD;
        #10000;
        $display("| %b | %b | ADD  | %b | 00000000000000000000000000000000 | %b    | 1     | %b        | 0         | %b    | 1 |", operandA, operandB, result, carryout, overflow, zero);
	// -2 + (-2) = -4
	operandA=-32'd2;operandB=-32'd2;command=`ADD;
        #10000;
        $display("| %b | %b | ADD  | %b | 11111111111111111111111111111100 | %b    | 1     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	$display("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");

	$display("SUB COMMAND -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
	// 5 - 3 = 2
        operandA=32'd5;operandB=32'd3;command=`SUB;
        #10000;
        $display("| %b | %b | SUB  | %b | 00000000000000000000000000000010 | %b    | 1     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	// -9900 - 2147483000 =
	operandA=-32'd9900;operandB=32'd2147483000;command=`SUB;
        #10000;
        $display("| %b | %b | SUB  | %b | 11111111111111111111111110110000 | %b    | 1     | %b        | 1         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
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
        $display("| %b | %b | XOR  | %b | 10000100100111100011011110111010 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	//
	operandA=-32'd5000;operandB=32'd123123;command=`XOR;
        #10000;
        $display("| %b | %b | XOR  | %b | 11111111111111100000110010001011 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	//
	operandA=32'd332;operandB=-32'd2123;command=`XOR;
        #10000;
        $display("| %b | %b | XOR  | %b | 11111111111111111111011011111001 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	//
	operandA=32'd0;operandB=32'd0;command=`XOR;
        #10000;
        $display("| %b | %b | XOR  | %b | 00000000000000000000000000000000 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	//
	operandA=-32'd892364;operandB=-32'd4985;command=`XOR;
        #10000;
        $display("| %b | %b | XOR  | %b | 00000000000011011000111010110011 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	$display("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");

	$display("SLT COMMAND -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
//
	operandA=32'b11000101111001001100110101101101;operandB=32'b00100101010101111101000101110010;command=`SLT;
	#10000;
	$display("| %b | %b | SLT  | %b | 00000000000000000000000000000001 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=-32'd5000;operandB=32'd123123;command=`SLT;
	#10000;
	$display("| %b | %b | SLT  | %b | 00000000000000000000000000000001 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=32'd332;operandB=-32'd2123;command=`SLT;
	#10000;
	$display("| %b | %b | SLT  | %b | 00000000000000000000000000000000 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=32'd0;operandB=32'd0;command=`SLT;
	#10000;
	$display("| %b | %b | SLT  | %b | 00000000000000000000000000000000 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=-32'd892364;operandB=-32'd4985;command=`SLT;
	#10000;
	$display("| %b | %b | SLT  | %b | 00000000000000000000000000000001 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	$display("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
	
	$display("AND COMMAND -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
//
	operandA=32'b11000101111001001100110101101101;operandB=32'b00100101010101111101000101110010;command=`AND;
	#10000;
	$display("| %b | %b | AND  | %b | 00000101010001001100000101100000 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=-32'd12303;operandB=32'd222;command=`AND;
	#10000;
	$display("| %b | %b | AND  | %b | 00000000000000000000000011010000 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=32'd9732;operandB=-32'd45623;command=`AND;
	#10000;
	$display("| %b | %b | AND  | %b | 00000000000000000000010000000000 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=32'd0;operandB=32'd0;command=`AND;
	#10000;
	$display("| %b | %b | AND  | %b | 00000000000000000000000000000000 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=-32'd234;operandB=-32'd4985;command=`AND;
	#10000;
	$display("| %b | %b | AND  | %b | 11111111111111111110110000000110 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	$display("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
	
	$display("NAND COMMAND ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
//
	operandA=32'b00111000101010110011010111011010;operandB=32'b10010010111111010011010110100101;command=`NAND;
	#10000;
	$display("| %b | %b | NAND | %b | 11101111010101101100101001111111 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=-32'd99093;operandB=32'd222;command=`NAND;
	#10000;
	$display("| %b | %b | NAND | %b | 11111111111111111111111100110101 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=32'd122;operandB=-32'd999898;command=`NAND;
	#10000;
	$display("| %b | %b | NAND | %b | 11111111111111111111111111011101 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=32'd0;operandB=32'd0;command=`NAND;
	#10000;
	$display("| %b | %b | NAND | %b | 11111111111111111111111111111111 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=-32'd9999;operandB=-32'd2;command=`NAND;
	#10000;
	$display("| %b | %b | NAND | %b | 00000000000000000010011100001111 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	$display("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
		
	$display("NOR COMMAND -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
//
	operandA=32'b11001101001110010010010101110101;operandB=32'b11100101011011101100101101100101;command=`NOR;
	#10000;
	$display("| %b | %b | NOR  | %b | 00010010100000000001000010001010 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=-32'd123123;operandB=32'd9882;command=`NOR;
	#10000;
	$display("| %b | %b | NOR  | %b | 00000000000000011100000001100000 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=32'd2;operandB=-32'd6;command=`NOR;
	#10000;
	$display("| %b | %b | NOR  | %b | 00000000000000000000000000000101 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=32'd0;operandB=32'd0;command=`NOR;
	#10000;
	$display("| %b | %b | NOR  | %b | 11111111111111111111111111111111 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=-32'd123123;operandB=-32'd99;command=`NOR;
	#10000;
	$display("| %b | %b | NOR  | %b | 00000000000000000000000001100010 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	$display("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
	
	$display("OR COMMAND ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
//
	operandA=32'b00110100110100111001010111001010;operandB=32'b11001001001011100110110011001010;command=`OR;
	#10000;
	$display("| %b | %b | OR   | %b | 11111101111111111111110111001010 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=-32'd90808099;operandB=32'd1239;command=`OR;
	#10000;
	$display("| %b | %b | OR   | %b | 11111010100101100110010011011111 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=32'd90;operandB=-32'd1092;command=`OR;
	#10000;
	$display("| %b | %b | OR   | %b | 11111111111111111111101111111110 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=32'd0;operandB=32'd0;command=`OR;
	#10000;
	$display("| %b | %b | OR   | %b | 00000000000000000000000000000000 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
//
	operandA=-32'd19992212;operandB=-32'd9827;command=`OR;
	#10000;
	$display("| %b | %b | OR   | %b | 11111111111111111111100111111101 | %b    | 0     | %b        | 0         | %b    | 0 |", operandA, operandB, result, carryout, overflow, zero);
	$display("-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
    end

endmodule


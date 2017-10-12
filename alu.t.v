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

        $display();
        $display("operandA                          operandB                          cmd  | result                            | cOut | Overflow | Zero");
        operandA=32'b00000000000000000000000000000010;operandB=32'b00000000000000000000000000000011;command=`SLT;
        #10000;
        $display("%b  %b  AND  | %b  %b  	%b  	%b", operandA, operandB, result, carryout, overflow, zero);

        // $dumpflush;
    end

endmodule

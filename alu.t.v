`timescale 1 ns / 1 ps
`include "alu.v"

module ALUTestBench();
  reg[2:0]    command;
  reg[31:0]   operandA;
  reg[31:0]   operandB;
  wire[1:0]   muxindex;
  wire[31:0]  result;
  wire        carryout;
  wire        zero;
  wire        overflow;

  //ALUcontrolLUT controller(muxindex, invertB, flagger, command);

  ALU alu(result, carryout, zero, overflow, operandA, operandB, command);

  initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, operandA, operandB, result, overflow, command, muxindex);

    $display("            A  |            B  |  Com |            Out  ");
    operandA = -5358; //Set register a.
    operandB = 5369; //Set register b.
    command = 0;
    #10000 //Delay.
    $display("  %b  |  %b  |  %b  |    %b     |   %b   ", $signed(operandA), $signed(operandB), command, $signed(result), overflow);
    operandA = 552; //Set register a.
    operandB = 600; //Set register b.
    command = 1;
    #10000 //Delay.
    $display("  %b  |  %b  |  %b  |    %b    ", $signed(operandA), $signed(operandB), command, $signed(result));
    operandA = 300; //Set register a.
    operandB = 25; //Set register b.
    command = 2;
    #10000 //Delay.
    $display("  %b  |  %b  |  %b  |    %b    ", $signed(operandA), $signed(operandB), command, $signed(result));
    operandA = 200; //Set register a.
    operandB = 985; //Set register b.
    command = 3;
    #10000 //Delay.
    $display("  %b  |  %b  |  %b  |    %b    ", $signed(operandA), $signed(operandB), command, $signed(result));
    operandA = 360; //Set register a.
    operandB = 111; //Set register b.
    command = 4;
    #10000 //Delay.
    $display("  %b  |  %b  |  %b  |    %b    ", $signed(operandA), $signed(operandB), command, $signed(result));
    operandA = -2; //Set register a.
    operandB = -60694; //Set register b.
    command = 5;
    #10000 //Delay.
    $display("  %b  |  %b  |  %b  |    %b    ", $signed(operandA), $signed(operandB), command, $signed(result));
    operandA = -2959; //Set register a.
    operandB = 6333; //Set register b.
    command = 6;
    #10000 //Delay.
    $display("  %b  |  %b  |  %b  |    %b    ", $signed(operandA), $signed(operandB), command, $signed(result));
    operandA = -1045; //Set register a.
    operandB = 54968; //Set register b.
    command = 7;
    #10000 //Delay.
    $display("  %b  |  %b  |  %b  |    %b    ", $signed(operandA), $signed(operandB), command, $signed(result));
  end
endmodule

`timescale 1 ns / 1 ps
`include "alu.v"

module ALUTestBench();
  reg[2:0]    command;
  reg[31:0]   operandA;
  reg[31:0]   operandB;
  reg[31:0]   expected;
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

    $display("            A  |            B  |  Com |            Out  |            Exp  ");
    operandA = -5358; //Set register a.
    operandB = 5369; //Set register b.
    command = 0;
    expected = 11;
    #10000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    |   %d   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected));
    operandA = 552; //Set register a.
    operandB = 600; //Set register b.
    command = 1;
    expected = -48;
    #10000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    |   %d   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected));
    operandA = 300; //Set register a.
    operandB = 25; //Set register b.
    command = 2;
    expected = 32'b100110101;
    #10000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    |   %d   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected));
    operandA = 200; //Set register a.
    operandB = 985; //Set register b.
    command = 3;
    expected = 1;
    #10000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    |   %d   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected));
    operandA = 360; //Set register a.
    operandB = 111; //Set register b.
    command = 4;
    expected = 32'b001101000;
    #10000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    |   %d   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected));
    operandA = -2; //Set register a.
    operandB = -60694; //Set register b.
    command = 5;
    expected = 32'b00000000000000001110110100010101;
    #10000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    |   %d   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected));
    operandA = -2959; //Set register a.
    operandB = 6333; //Set register b.
    command = 6;
    expected = 32'b00000000000000000000001100000010;
    //11111111111111111111010001110001
    //00000000000000000001100010111101
    #10000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    |   %d   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected));
    operandA = -1045; //Set register a.
    operandB = 54968; //Set register b.
    command = 7;
    expected = 32'b11111111111111111111111111111011;
    //11111111111111111111101111101011
    //00000000000000001101011010111000
    #10000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    |   %d   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected));
    operandA = 9050; //Set register a.
    operandB = 985; //Set register b.
    command = 3;
    expected = 0;
    #10000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    |   %d   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected));
    operandA = -10505; //Set register a.
    operandB = 2; //Set register b.
    command = 3;
    expected = 1;
    #10000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    |   %d   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected));

  end
endmodule

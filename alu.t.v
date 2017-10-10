`timescale 1 ns / 1 ps
`include "alu.v"

`define opADD  3'd0
`define opSUB  3'd1
`define opXOR  3'd2
`define opSLT  3'd3
`define opAND  3'd4
`define opNAND 3'd5
`define opNOR  3'd6
`define opOR   3'd7

module ALUcontrolLUT
(
output reg[2:0] 	muxindex,
output reg	invertB,
output reg	flagger,
input[2:0]	ALUcommand
);

  always @(ALUcommand) begin
    case (ALUcommand)
      `opADD:  begin muxindex = 0; invertB=0; flagger = 1; end
      `opSUB:  begin muxindex = 0; invertB=1; flagger = 1; end
      `opXOR:  begin muxindex = 1; invertB=0; flagger = 0; end
      `opSLT:  begin muxindex = 2; invertB=0; flagger = 0; end
      `opAND:  begin muxindex = 3; invertB=1; flagger = 0; end
      `opNAND: begin muxindex = 3; invertB=0; flagger = 0; end
      `opNOR:  begin muxindex = 4; invertB=0; flagger = 0; end
      `opOR:   begin muxindex = 4; invertB=1; flagger = 0; end
    endcase
  end
endmodule

module ALUTestBench();
  reg[2:0]    command;
  reg[31:0]   operandA;
  reg[31:0]   operandB;
  wire        invertB;
  wire        flagger;
  wire[2:0]   muxindex;
  wire[31:0]  result;
  wire        carryout;
  wire        zero;
  wire        overflow;

  ALUcontrolLUT controller(muxindex, invertB, flagger, command);

  ALU alu(result, carryout, zero, overflow, operandA, operandB, muxindex, invertB, flagger);

  initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, operandA, operandB, result, overflow, command, muxindex, invertB);

    $display("            A  |            B  |  Com |            Out  ");
    operandA = -5358; //Set register a.
    operandB = 5369; //Set register b.
    command = 0;
    #1000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    ", $signed(operandA), $signed(operandB), command, $signed(result));
    operandA = 552; //Set register a.
    operandB = 600; //Set register b.
    command = 1;
    #1000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    ", $signed(operandA), $signed(operandB), command, $signed(result));
    operandA = 300; //Set register a.
    operandB = 25; //Set register b.
    command = 2;
    #1000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    ", $signed(operandA), $signed(operandB), command, $signed(result));
    operandA = 360; //Set register a.
    operandB = 111; //Set register b.
    command = 4;
    #1000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    ", $signed(operandA), $signed(operandB), command, $signed(result));
    operandA = -2; //Set register a.
    operandB = -60694; //Set register b.
    command = 5;
    #1000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    ", $signed(operandA), $signed(operandB), command, $signed(result));
    operandA = -2959; //Set register a.
    operandB = 6333; //Set register b.
    command = 6;
    #1000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    ", $signed(operandA), $signed(operandB), command, $signed(result));
    operandA = -1045; //Set register a.
    operandB = 54968; //Set register b.
    command = 7;
    #1000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    ", $signed(operandA), $signed(operandB), command, $signed(result));
  end
endmodule

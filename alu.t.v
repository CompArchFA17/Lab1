`timescale 1 ns / 1 ps
`include "alu.v"

module ALUTestBench();
  reg[2:0]    command;
  reg[31:0]   operandA;
  reg[31:0]   operandB;
  reg[31:0]   expected;
  wire[31:0]  result;
  wire        carryout;
  wire        zero;
  wire        overflow;

  integer OperandAs[1:6];
  integer OperandBs[1:6];
  integer addresults[1:6];
  integer a;

  integer notpassed = 0;

  //ALUcontrolLUT controller(muxindex, invertB, flagger, command);

  ALU alu(result, carryout, zero, overflow, operandA, operandB, command);

  // initial begin
  //   $dumpfile("alu.vcd");
  //   $dumpvars(0, operandA, operandB, result, overflow, zero, carryout, command, expected);
  // end
    initial begin
    $display("            A  |            B  |  Com |            Out  |            Exp  | Overflow | Zero");
    //Test the Add operation:
    command = 0;
    OperandAs[1] = -5358; OperandAs[2] = 0; OperandAs[3] = -35; 
    OperandBs[1] = 5369; OperandBs[2] = 0; OperandBs[3] = -65;
    addresults[1]= 11; addresults[2]= 0 ; addresults[3]= -100;
    OperandAs[4] = 730; OperandAs[5] = 4294967210; OperandAs[6] = -4294961800;
    OperandBs[4] = -520; OperandBs[5] = 300; OperandBs[6] = -30000;
    addresults[4]= 210 ; addresults[5]= 0; addresults[6]= 0;
    for (a = 1;  a < 7; a = a + 1)
    #10000 //Delay
    begin: addtest
        operandA = OperandAs[a];
        operandB = OperandBs[a];
        #10000 //Delay
        if((result != addresults[a]) && (overflow != 1)) begin 
            notpassed = notpassed + 1;  // Add to test not passed
            $display("Test Case adding %d to %d Failed with result %d and overflow %d", operandA, operandB, result, overflow);
        end
    end

    //Test the Subtract operation
    command = 1;
    OperandAs[1] = -5358; OperandAs[2] = 0; OperandAs[3] = -35; 
    OperandAs[4] = 730; OperandAs[5] = 4294967210; OperandAs[6] = -4294961800;
    OperandBs[1] = 5369; OperandBs[2] = 0; OperandBs[3] = -65;
    OperandBs[4] = -520; OperandBs[5] = 300; OperandBs[6] = -30000;
    addresults[1]= 11; addresults[2]= 0 ; addresults[3]= -100;
    addresults[4]= 210 ; addresults[5]= 0; addresults[6]= 0;
    for (a = 1;  a < 7; a = a + 1)
    #10000
    begin: subtracttest
        operandA = OperandAs[a];
        operandB = OperandBs[a];
        #10000
        if((result != addresults[a]) && (overflow != 1)) begin 
            notpassed = notpassed + 1;  // Add to test not passed
            $display("Test Case subtracting %d - %d Failed", operandA, operandB);
        end
    end

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
    $display("  %d  |  %d  |  %d  |    %d    |   %d   |   %b   |   %b   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected), overflow, zero);
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
    $display("  %d  |  %d  |  %d  |    %d    |   %d   |   %b   |   %b   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected), overflow, zero);
    operandA = -10505; //Set register a.
    operandB = 2; //Set register b.
    command = 3;
    expected = 1;
    #10000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    |   %d   |   %b   |   %b   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected), overflow, zero);
    operandA = 1; //Set register a.
    operandB = 2; //Set register b.
    command = 3;
    expected = 1;
    #10000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    |   %d   |   %b   |   %b   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected), overflow, zero);
    operandA = 1; //Set register a.
    operandB = 2; //Set register b.
    command = 1;
    expected = -1;
    #10000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    |   %d   |   %b   |   %b   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected), overflow, zero);
    operandA = -1; //Set register a.
    operandB = 2; //Set register b.
    command = 3;
    expected = 1;
    #10000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    |   %d   |   %b   |   %b   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected), overflow, zero);
    operandA = -1; //Set register a.
    operandB = 2; //Set register b.
    command = 1;
    expected = -3;
    #10000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    |   %d   |   %b   |   %b   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected), overflow, zero);
    operandA = 1; //Set register a.
    operandB = -2; //Set register b.
    command = 3;
    expected = 0;
    #10000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    |   %d   |   %b   |   %b   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected), overflow, zero);
    operandA = 1; //Set register a.
    operandB = -2; //Set register b.
    command = 1;
    expected = 3;
    #10000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    |   %d   |   %b   |   %b   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected), overflow, zero);
    operandA = -3; //Set register a.
    operandB = -2; //Set register b.
    command = 3;
    expected = 1;
    #10000 //Delay.
    $display("  %d  |  %d  |  %d  |    %d    |   %d   |   %b   |   %b   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected), overflow, zero);
    operandA = -3; //Set register a.
    operandB = -2; //Set register b.
    command = 1;
    expected = -1;
    #10000 //Delay.
    //$display("  %d  |  %d  |  %d  |    %d    |   %d   |   %b   |   %b   ", $signed(operandA), $signed(operandB), command, $signed(result), $signed(expected), overflow, zero);

    $display("Number of test failed %d", notpassed);
end
endmodule

`include "alu.v"

module testALU ();
   reg [31:0] operandA, operandB;
   reg [2:0] command;
   reg [9:0] numBroken = 0;
   wire [31:0] result;
   wire carryout, ofl, zero;
   
   ALU testALU(.result (result), .carryout (carryout), .overflow (ofl), .zero (zero), .operandA (operandA), .operandB (operandB), .command (command));
   
   task checkTestCase;
   input [31:0] expectedResult;
   input expectedCarryout, expectedOfl, expectedZero;

   begin
      $display("Testing command %b, operandA %b, and operandB %b", command, operandA, operandB);
      if (result == expectedResult) begin
          $display("Test Passed, result is %b, carryout is %b, ofl is %b, and zero is %b", result, carryout, ofl, zero);
      end else begin
          numBroken = numBroken + 1;
          $display("ERROR: Expected %b for result, %b for carryout, %b for ofl, and %b for zero, but actual output was %b, actual carryout was %b, actual ofl was %b, and actual zero is %b", expectedResult, expectedCarryout, expectedOfl, expectedZero, result, carryout, ofl, zero);
      end
   end
   endtask

   initial begin
   
      //Add
      command = 0; operandA = 0; operandB = 0; #50
      checkTestCase(0, 0, 0, 1);
      command = 0; operandA = 32'b11111111111111111111111111111111; operandB = 32'b11111111111111111111111111111111; #50
      checkTestCase(32'b11111111111111111111111111111110, 1, 0, 0);
      command = 0; operandA = 32'b10000000000000000000000000000001; operandB = 32'b01111111111111111111111111111111; #50
      checkTestCase(0, 1, 0, 1);
      command = 0; operandA = 32'b10000000000000000000000000000000; operandB = 32'b10000000000000000000000000000000; #50
      checkTestCase(0, 1, 1, 1);
      command = 0; operandA = 32'b11010101010101010101011010101010; operandB = 32'b00000001111111111111111101101010; #50
      checkTestCase(32'b11010111010101010101011000010100, 0, 0, 0);

      //Sub
      command = 1; operandA = 0; operandB = 0; #50
      checkTestCase(0, 0, 0, 1);
      command = 1; operandA = 32'b11111111111111111111111111111111; operandB = 32'b00000000000000000000000000000001; #50
      checkTestCase(32'b11111111111111111111111111111110, 1, 0, 0);
      command = 1; operandA = 32'b10000000000000000000000000000001; operandB = 32'b10000000000000000000000000000001; #50
      checkTestCase(0, 1, 0, 1);
      command = 1; operandA = 32'b10000000000000000000000000000000; operandB = 32'b10000000000000000000000000000000; #50
      checkTestCase(0, 1, 1, 1);
      command = 1; operandA = 32'b11010101010101010101011010101010; operandB = 32'b11111110000000000000000010010101; #50
      checkTestCase(32'b11010111010101010101011000010101, 0, 0, 0); 

      //XOR
      command = 2; operandA = 32'b11111111111111111111111111111111; operandB = 32'b00000000000000000000000000000000; #50
      checkTestCase(32'b11111111111111111111111111111111, 0, 0, 0);
      command = 2; operandA = 32'b11111111111111111111111111111111; operandB = 32'b11111111111111111111111111111111; #50
      checkTestCase(32'b00000000000000000000000000000000, 0, 0, 1);
      command = 2; operandA = 32'b00101010101010101010111010111101; operandB = 32'b00001010101010110101010010110101; #50
      checkTestCase(32'b00100000000000011111101000001000, 0, 0, 0);
    
      //SLT         
      command = 3; operandA = 32'b11111111111111111111111111111111; operandB = 32'b00000000000000000000000000000000; #50
      checkTestCase(32'b11111111111111111111111111111111, 0, 0, 1);
      command = 3; operandA = 32'b11111111111111111111111111111111; operandB = 32'b11111111111111111111111111111111; #50
      checkTestCase(32'b00000000000000000000000000000000, 0, 0, 1);
      command = 3; operandA = 32'b00000000000000000000000000000000; operandB = 32'b11111111111111111111111111111111; #50
      checkTestCase(32'b00000000000000000000000000000000, 0, 0, 0);

      //AND
      command = 4; operandA = 32'b11111111111111111111111111111111; operandB = 32'b00000000000000000000000000000000; #50
      checkTestCase(32'b00000000000000000000000000000000, 0, 0, 1);
      command = 4; operandA = 32'b11111111111111111111111111111111; operandB = 32'b11111111111111111111111111111111; #50
      checkTestCase(32'b11111111111111111111111111111111, 0, 0, 0);
      command = 4; operandA = 32'b00000000000000111111111111111111; operandB = 32'b01000100000101011101110111011011; #50
      checkTestCase(32'b00000000000000011101110111011011, 0, 0, 0);

      //NAND
      command = 5; operandA = 32'b11111111111111111111111111111111; operandB = 32'b00000000000000000000000000000000; #50
      checkTestCase(32'b11111111111111111111111111111111, 0, 0, 0);
      command = 5; operandA = 32'b11111111111111111111111111111111; operandB = 32'b11111111111111111111111111111111; #50
      checkTestCase(32'b00000000000000000000000000000000, 0, 0, 1);
      command = 5; operandA = 32'b00000000000000111111111111111111; operandB = 32'b01000100000101011101110111011011; #50
      checkTestCase(32'b11111111111111100010001000100100, 0, 0, 0);

      //NOR
      command = 6; operandA = 32'b11111111111111111111111111111111; operandB = 32'b00000000000000000000000000000000; #50
      checkTestCase(32'b00000000000000000000000000000000, 0, 0, 1);
      command = 6; operandA = 32'b00000000000000000000000000000000; operandB = 32'b00000000000000000000000000000000; #50
      checkTestCase(32'b11111111111111111111111111111111, 0, 0, 0);
      command = 6; operandA = 32'b00000000000000111111111111111111; operandB = 32'b01000100000101011101110111011011; #50
      checkTestCase(32'b10111011111010000000000000000000, 0, 0, 0);
                    
      //OR
      command = 7; operandA = 32'b11111111111111111111111111111111; operandB = 32'b00000000000000000000000000000000; #50
      checkTestCase(32'b11111111111111111111111111111111, 0, 0, 0); 
      command = 7; operandA = 32'b00000000000000000000000000000000; operandB = 32'b00000000000000000000000000000000; #50
      checkTestCase(32'b00000000000000000000000000000000, 0, 0, 1);
      command = 7; operandA = 32'b00000000000000111111111111111111; operandB = 32'b01000100000101011101110111011011; #50
      checkTestCase(32'b01000100000101111111111111111111, 0, 0, 0);

      $display("%d test cases failed", numBroken);

   end
endmodule



                    
// Single Bit ALU testbench
`include "alu_single_bit.v"

module testSingleBitALU ();
    reg operandA, operandB, carryin;
    reg [2:0] command;
    reg [9:0] numBroken = 0;
    wire result, carryout;

    ALU_single_bit alusinglebittest(.result (result),.carryout (carryout),.operandA (operandA),.operandB (operandB),.carryin (carryin),.command (command)); 

    task checkTestCase;
    input [2:0] commandIn;
    input operandAIn;
    input operandBIn;
    input expectedResult;
    
    begin
       command = commandIn; operandA = operandAIn; operandB = operandBIn; #50
       $display("Testing command %b, operandA %b, and operandB %b", command, operandA, operandB);
       if (result == expectedResult) begin
          $display("Test Passed, result is %b", result);
       end else begin
          numBroken = numBroken + 1;
          $display("ERROR: Expected %b, but actual output was %b", expectedResult, result);
       end
    end
    endtask

    task checkAddTestCase;
    input [2:0] commandIn;
    input carryinIn;
    input operandAIn;
    input operandBIn;
    input expectedResult;
    input expectedCarryout;
    
    begin
       command = commandIn; carryin = carryinIn; operandA = operandAIn; operandB = operandBIn; #50
       $display("Testing command %b, carryin %b, operandA %b, and operandB %b", command, carryin, operandA, operandB);
       if (result == expectedResult && carryout == expectedCarryout) begin
          $display("Test Passed, result is %b and carryout is %b", result, carryout);
       end else begin
          numBroken = numBroken + 1;
          $display("ERROR: Expected %b as result and %b as carryout, but actual output was %b and actual carryout was %b", expectedResult, expectedCarryout, result, carryout);
       end
    end
    endtask

    initial begin
    
       //Add
       checkAddTestCase(3'b000,0,0,1,1,0);
       checkAddTestCase(3'b000,0,0,1,1,0);
       checkAddTestCase(3'b000,0,1,0,1,0);
       checkAddTestCase(3'b000,0,1,1,0,1);

       checkAddTestCase(3'b000,1,0,0,1,0);
       checkAddTestCase(3'b000,1,0,1,0,1);
       checkAddTestCase(3'b000,1,1,0,0,1);
       checkAddTestCase(3'b000,1,1,1,1,1);

       //SL
       checkTestCase(3'b010,0,0,0);
       checkTestCase(3'b010,0,1,1);
       checkTestCase(3'b010,1,0,0);
       checkTestCase(3'b010,1,1,0);
    
       //XOR
       checkTestCase(3'b011,0,0,0);
       checkTestCase(3'b011,0,1,1);
       checkTestCase(3'b011,1,0,1);
       checkTestCase(3'b011,1,1,0);

       //AND
       checkTestCase(3'b100,0,0,0);
       checkTestCase(3'b100,0,1,0);
       checkTestCase(3'b100,1,0,0);
       checkTestCase(3'b100,1,1,1);

       //NAND
       checkTestCase(3'b101,0,0,1);
       checkTestCase(3'b101,0,1,1);
       checkTestCase(3'b101,1,0,1);
       checkTestCase(3'b101,1,1,0);

       //OR
       checkTestCase(3'b110,0,0,0);
       checkTestCase(3'b110,0,1,1);
       checkTestCase(3'b110,1,0,1);
       checkTestCase(3'b110,1,1,1);
    
       //NOR
       checkTestCase(3'b111,0,0,1);
       checkTestCase(3'b111,0,1,0);
       checkTestCase(3'b111,1,0,0);
       checkTestCase(3'b111,1,1,0);

       $display("%d test cases failed", numBroken);
 
    end

endmodule
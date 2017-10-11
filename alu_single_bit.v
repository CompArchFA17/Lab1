module ALU_single_bit(result, carryout, operandA, operandB, carryin, command);

   output result;
   output carryout;
   input operandA;
   input operandB;
   input carryin;
   input [2:0] command;
   
   reg result;
   reg carryout =  0;
   wire operandA, operandB, carryin, addedResult, xorResult, andResult, nandResult, norResult, orResult;

   single_bit_adder adder(addedResult, carryout, operandA, operandB, carryin);
   xor xorgate(xorResult, operandA, operandB);
   and andgate(andResult, operandA, operandB);
   nand nandgate(nandResult, operandA, operandB);
   nor norgate(norResult, operandA, operandB);
   or orgate(orResult, operandA, operandB);
   
   always @ (command) begin
      case(command)
         3'b000: result = addedResult;
         3'b010: result = xorResult;
         3'b011: result = operandA<operandB;
         3'b100: result = andResult;
         3'b101: result = nandResult;
         3'b110: result = norResult;
         3'b111: result = orResult;
      endcase
   end
endmodule

module single_bit_adder(result, carryout, A, B, carryin);
   
   output result;
   output carryout;
   input A;
   input B;
   input carryin;

   wire carryout, result;
   wire A,B;

   assign carryout = (A && B) || (((!A && B) || (A && !B)) && carryin);
   assign result = (((!A && B) || (A && !B)) && !carryin) || (!((!A && B) || (A && !B)) && carryin);

endmodule

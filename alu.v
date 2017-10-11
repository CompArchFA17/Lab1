

module ALU(result, carryout, operandA, operandB, carryin, command);

   output result[31:0];
   output carryout;
   input operandA[31:0];
   input operandB[31:0];
   input carryin;
   input [2:0] command;
   
   reg result;
   wire carryout =  0;
   wire operandA, operandB, carryin, addedResult, xorResult, andResult, nandResult, norResult, orResult;

   multi_bit_adder adder(addedResult, carryout, operandA, operandB, carryin);
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

module multi_bit_SLT(result,A,B);
   initial begin
   
endmodule

module multi_bit_adder(result, carryout, A, B, carryin);
   
   output result[31:0];
   output carryout;
   input A[31:0];
   input B[31:0];
   input carryin;

   wire carryout, result;
   wire A,B;

   single_bit_adder adder0 (sum[0], carryout0, a[0], b[0], 0);
   single_bit_adder adder1 (sum[1], carryout1, a[1], b[1], carryout0);
   single_bit_adder adder2 (sum[2], carryout2, a[2], b[2], carryout1);
   single_bit_adder adder3 (sum[3], carryout3, a[3], b[3], carryout2);

   single_bit_adder adder1 (sum[4], carryout4, a[4], b[4], carryout3);
   single_bit_adder adder2 (sum[5], carryout5, a[5], b[5], carryout4);
   single_bit_adder adder3 (sum[6], carryout6, a[6], b[6], carryout5);
   single_bit_adder adder1 (sum[7], carryout7, a[7], b[7], carryout6);

   single_bit_adder adder2 (sum[8], carryout8, a[8], b[8], carryout7);
   single_bit_adder adder3 (sum[9], carryout9, a[9], b[9], carryout8);
   single_bit_adder adder1 (sum[10], carryout10, a[10], b[10], carryout9);
   single_bit_adder adder2 (sum[11], carryout11, a[11], b[11], carryout10);
   single_bit_adder adder3 (sum[12], carryout12, a[12], b[12], carryout11);
   single_bit_adder adder1 (sum[13], carryout13, a[13], b[13], carryout12);
   single_bit_adder adder2 (sum[14], carryout14, a[14], b[14], carryout13);
   single_bit_adder adder3 (sum[15], carryout15, a[15], b[15], carryout14);

   single_bit_adder adder1 (sum[16], carryout16, a[16], b[16], carryout15);
   single_bit_adder adder2 (sum[17], carryout17, a[17], b[17], carryout16);
   single_bit_adder adder3 (sum[18], carryout18, a[18], b[18], carryout17);
   single_bit_adder adder1 (sum[19], carryout19, a[19], b[19], carryout18);

   single_bit_adder adder2 (sum[20], carryout20, a[20], b[20], carryout19);
   single_bit_adder adder3 (sum[21], carryout21, a[21], b[21], carryout20);
   single_bit_adder adder1 (sum[22], carryout22, a[22], b[22], carryout21);
   single_bit_adder adder2 (sum[23], carryout23, a[23], b[23], carryout22);

   single_bit_adder adder3 (sum[24], carryout24, a[24], b[24], carryout23);
   single_bit_adder adder1 (sum[25], carryout25, a[25], b[25], carryout24);
   single_bit_adder adder2 (sum[26], carryout26, a[26], b[26], carryout25);
   single_bit_adder adder3 (sum[27], carryout27, a[27], b[27], carryout26);

   single_bit_adder adder1 (sum[28], carryout28, a[28], b[28], carryout27);
   single_bit_adder adder2 (sum[29], carryout29, a[29], b[29], carryout28);
   single_bit_adder adder3 (sum[30], carryout30, a[30], b[30], carryout29);
   single_bit_adder adder1 (sum[31], carryout, a[31], b[31], carryout30);

endmodule

module multi_bit_subtracter(result, carryout, A, B, carryin)
   
   output result[31:0];
   output carryout;
   input A[31:0];
   input B{31:0];
   input carryin;
   
   wire carryout, result;
   wire A,B;

   not notA(nA,A);
   not notB(nB,B);

   multi_bit_adder subtract1(result,carryout,nA,nB,carryin)

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
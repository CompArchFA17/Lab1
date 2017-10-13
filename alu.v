module ALU(result, carryout, overflow, zero, operandA, operandB, command);

   output [31:0] result;
   output carryout;
   output overflow;
   output zero; 
   input [31:0] operandA;
   input [31:0] operandB;
   input [2:0] command;
   
   wire carryout =  0;
   wire overflow =  0; 
   wire zero = 0;
   wire [31:0] carryin, addedResult, subResult, xorResult, andResult, nandResult, norResult, orResult;
   wire sltResult;
   reg [31:0] result;
   
   assign zero = !(1'b0||result[0]) && !(1'b0||result[1]) && !(1'b0||result[2]) && !(1'b0||result[3]) && !(1'b0||result[4]) && !(1'b0||result[5]) && !(1'b0||result[6]) && !(1'b0||result[7]) && !(1'b0||result[8]) && !(1'b0||result[9]) && !(1'b0||result[10]) && !(1'b0||result[11]) && !(1'b0||result[12]) && !(1'b0||result[13]) && !(1'b0||result[14]) && !(1'b0||result[15]) && !(1'b0||result[16]) && !(1'b0||result[17]) && !(1'b0||result[18]) && !(1'b0||result[19]) && !(1'b0||result[20]) && !(1'b0||result[21]) && !(1'b0||result[22]) && !(1'b0||result[23]) && !(1'b0||result[24]) && !(1'b0||result[25]) && !(1'b0||result[26]) && !(1'b0||result[27]) && !(1'b0||result[28]) && !(1'b0||result[29]) && !(1'b0||result[30]) && !(1'b0||result[31]);
   
   multi_bit_adder adder(addedResult, carryout, overflow, operandA, operandB);
   multi_bit_subtracter subtracter(subResult, carryout, overflow, operandA, operandB);
   multi_bit_SLT slt(sltResult,operandA,operandB);
   //output_mux result_mux(.result(result),.command(command),.operandA(operandA),.operandB(operandB),.addedResult(addedResult),.subResult(subResult),.sltResult(sltResult));

   always @ (*) begin
      case(command)
         3'b000: result = addedResult;
         3'b001: result = subResult;
         3'b010: result = operandA ^ operandB;
         3'b011: result = sltResult;
         3'b100: result = operandA && operandB;
         3'b101: result = !(operandA && operandB);
         3'b110: result = !(operandA || operandB);
         3'b111: result = operandA || operandB;
      endcase
   end
endmodule

//We can check if A<B by checking starting at the most significant bit and moving to the right checking for following cases
//If A[n]<B[n] @ n then stop and return 1
//If A[n]>B[n] @ n then stop and return 0 
//If A[n]=B[n] @ n continue until the end 
//If A = B , return 0
   
module multi_bit_SLT(sltresult,A,B);
  
   output sltresult;
   input [31:0] A;
   input [31:0] B;
   integer i;

   reg sltresult;
   initial begin
      for (i = 31 ; i >= 0; i = i-1) begin
         //If A[n]<B[n] @ n then stop and return 1 b/c A<B
         if (!A[i] && B[i])  begin
            sltresult = 1;
         i = -1;
         end else if ((A[i] && B[i]) || (A[i] && !B[i])) begin
            sltresult = 0;
         end
      end
     i = 31;
   end
endmodule

module multi_bit_and(andResult, operandA, operandB);
   output [31:0] andResult;
   input [31:0] operandA;
   input [31:0] operandB;
   
   //wire [31:0] operandA, operandB;
   wire and0,and1,and2,and3,and4,and5,and6,and7,and8,and9,and10,and11,and12,and13,and14,and15,and16,and17,and18,and19,and20,and21,and22,and23,and24,and25,and26,and27,and28,and29,and30,and31;
   
   assign and0 = operandA[0] && operandB[0];
   assign and1 = operandA[1] && operandB[1];
   assign and2 = operandA[2] && operandB[2];
   assign and3 = operandA[3] && operandB[3];
   assign and4 = operandA[4] && operandB[4];
   assign and5 = operandA[5] && operandB[5];
   assign and6 = operandA[6] && operandB[6];
   assign and7 = operandA[7] && operandB[7];
   assign and8 = operandA[8] && operandB[8];
   assign and9 = operandA[9] && operandB[9];
   assign and10 = operandA[10] && operandB[10];
   assign and11 = operandA[11] && operandB[11];
   assign and12 = operandA[12] && operandB[12];
   assign and13 = operandA[13] && operandB[13];
   assign and14 = operandA[14] && operandB[14];
   assign and15 = operandA[15] && operandB[15];
   assign and16 = operandA[16] && operandB[16];
   assign and17 = operandA[17] && operandB[17];
   assign and18 = operandA[18] && operandB[18];
   assign and19 = operandA[19] && operandB[19];
   assign and20 = operandA[20] && operandB[20];
   assign and21 = operandA[21] && operandB[21];
   assign and22 = operandA[22] && operandB[22];
   assign and23 = operandA[23] && operandB[23];
   assign and24 = operandA[24] && operandB[24];
   assign and25 = operandA[25] && operandB[25];
   assign and26 = operandA[26] && operandB[26];
   assign and27 = operandA[27] && operandB[27];
   assign and28 = operandA[28] && operandB[28];
   assign and29 = operandA[29] && operandB[29];
   assign and30 = operandA[30] && operandB[30];
   assign and31 = operandA[31] && operandB[31];
   
   assign andResult = and31 && and30 && and29 && and31 && and30 && and29 && && and28 && and27 && and26 && and25 && and24 && and23 && and22 && and21 && and20 && and19 && and18 && and17 && and16 && and15 && and14 && and13 && and12 && and11 && and10 && and9 && and8 && and7 && and6 && and5 && and4 && and3 && and2 && and1 && and0;
endmodule


module multi_bit_adder(sum, carryout, overflow, A, B);
   
   output [31:0] sum;
   output carryout;
   output overflow;
   input [31:0] A;
   input [31:0] B;

   wire [31:0] result; 
   wire carryout, overflow;
   wire [31:0] A,B;
   wire carryout0,carryout1,carryout2,carryout3,carryout4,carryout5,carryout6,carryout7,carryout8,carryout9;
   wire carryout10,carryout11,carryout12,carryout13,carryout14,carryout15,carryout16,carryout17,carryout18;
   wire carryout19,carryout20,carryout21,carryout22,carryout23,carryout24,carryout25,carryout26,carryout27;
   wire carryout28,carryout29,carryout30;

   single_bit_adder adder0 (sum[0], carryout0, A[0], B[0], 1'b0);
   single_bit_adder adder1 (sum[1], carryout1, A[1], B[1], carryout0);
   single_bit_adder adder2 (sum[2], carryout2, A[2], B[2], carryout1);
   single_bit_adder adder3 (sum[3], carryout3, A[3], B[3], carryout2);

   single_bit_adder adder4 (sum[4], carryout4, A[4], B[4], carryout3);
   single_bit_adder adder5 (sum[5], carryout5, A[5], B[5], carryout4);
   single_bit_adder adder6 (sum[6], carryout6, A[6], B[6], carryout5);
   single_bit_adder adder7 (sum[7], carryout7, A[7], B[7], carryout6);

   single_bit_adder adder8 (sum[8], carryout8, A[8], B[8], carryout7);
   single_bit_adder adder9 (sum[9], carryout9, A[9], B[9], carryout8);
   single_bit_adder adder10 (sum[10], carryout10, A[10], B[10], carryout9);
   single_bit_adder adder11 (sum[11], carryout11, A[11], B[11], carryout10);
   single_bit_adder adder12 (sum[12], carryout12, A[12], B[12], carryout11);
   single_bit_adder adder13 (sum[13], carryout13, A[13], B[13], carryout12);
   single_bit_adder adder14 (sum[14], carryout14, A[14], B[14], carryout13);
   single_bit_adder adder15 (sum[15], carryout15, A[15], B[15], carryout14);

   single_bit_adder adder16 (sum[16], carryout16, A[16], B[16], carryout15);
   single_bit_adder adder17 (sum[17], carryout17, A[17], B[17], carryout16);
   single_bit_adder adder18 (sum[18], carryout18, A[18], B[18], carryout17);
   single_bit_adder adder19 (sum[19], carryout19, A[19], B[19], carryout18);

   single_bit_adder adder20 (sum[20], carryout20, A[20], B[20], carryout19);
   single_bit_adder adder21 (sum[21], carryout21, A[21], B[21], carryout20);
   single_bit_adder adder22 (sum[22], carryout22, A[22], B[22], carryout21);
   single_bit_adder adder23 (sum[23], carryout23, A[23], B[23], carryout22);

   single_bit_adder adder24 (sum[24], carryout24, A[24], B[24], carryout23);
   single_bit_adder adder25 (sum[25], carryout25, A[25], B[25], carryout24);
   single_bit_adder adder26 (sum[26], carryout26, A[26], B[26], carryout25);
   single_bit_adder adder27 (sum[27], carryout27, A[27], B[27], carryout26);

   single_bit_adder adder28 (sum[28], carryout28, A[28], B[28], carryout27);
   single_bit_adder adder29 (sum[29], carryout29, A[29], B[29], carryout28);
   single_bit_adder adder30 (sum[30], carryout30, A[30], B[30], carryout29);
   single_bit_adder adder31 (sum[31], carryout, A[31], B[31], carryout30);

   xor getoverflow(overflow, carryout30, carryout);

endmodule

module multi_bit_subtracter(result, carryout, overflow, A, B);
   
   output [31:0] result;
   output carryout;
   output overflow;
   input [31:0] A;
   input [31:0] B;
   
   wire [31:0] result;
   wire carryout, overflow;
   wire [31:0] A;
   wire [31:0] B;
   wire [31:0] nB;
  
   //initial nB[31:0] = ~B[31:0];
   //invert second operand B for subtraction
   assign nB = !B[31] && !B[30] && !B[29] && !B[28] && !B[27]&& !B[26] && !B[25] && !B[24] && !B[23] && !B[22] && !B[21]&& !B[20] && !B[19] && !B[18] && !B[17] && !B[16] && !B[15] && !B[14] && !B[13] && !B[12] && !B[11] && !B[10] && !B[9] && !B[8] && !B[7] && !B[6] && !B[5] && !B[4] && !B[3] && !B[2] && !B[1] && !B[0] ;

   multi_bit_adder subtract1(result, carryout, overflow, A, nB);

endmodule

module single_bit_adder(result, carryout, A, B, carryin) ;
   
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

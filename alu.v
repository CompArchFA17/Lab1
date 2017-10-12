module ALU(result, carryout, overflow, zero, operandA, operandB, command);

   output [31:0] result;
   output carryout;
   output overflow;
   output zero; 
   input [31:0] operandA;
   input [31:0] operandB;
   input [2:0] command;
   
   reg [31:0] result;
   wire carryout =  0;
   wire overflow =  0; 
   wire zero = 0;
   wire [31:0] carryin, addedResult, subResult, xorResult, sltResult, andResult, nandResult, norResult, orResult;

   multi_bit_adder adder(addedResult, carryout, overflow, operandA, operandB);
   multi_bit_subtracter subtracter(subResult, carryout, overflow, operandA, operandB);
   multi_bit_SLT slt(sltResult,operandA,operandB);
   //xor xorgate(xorResult, operandA, operandB);
   //and andgate(andResult, operandA, operandB);
   //nand nandgate(nandResult, operandA, operandB);
   //nor norgate(norResult, operandA, operandB);
   //or orgate(orResult, operandA, operandB);
   and zeros(zero, !(0||result[0]), !(0||result[1]) ,!(0||result[2]) ,!(0||result[3]) ,!(0||result[4]), !(0||result[5]) ,!(0||result[6]) ,!(0||result[7]) ,!(0||result[8]) ,!(0||result[9]) ,!(0||result[10]) ,        !(0||result[11]) ,!(0||result[12]) ,!(0||result[13]) ,!(0||result[14]) ,!(0||result[15]) ,!(0||result[16]),    !(0||result[17]) ,!(0||result[18]) ,!(0||result[19]) ,!(0||result[20]) ,!(0||result[21]) ,!(0||result[22]),    !(0||result[23]) ,!(0||result[24]) ,!(0||result[25]) ,!(0||result[26]) ,!(0||result[27]) ,!(0||result[28]) ,   !(0||result[29]) ,!(0||result[30]) ,!(0||result[31]) );

   always @ (command) begin
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

   reg sltresult = 0;
   initial begin
      for (i = 31 ; i >= 0; i = i-1) begin
         //If A[n]<B[n] @ n then stop and return 1 b/c A<B
         if (!A[i] && B[i])  begin
            sltresult = 1;
         end else if ((i == 0 && A[i] && B[i]) || (A[i] > B[i])) begin
            sltresult = 0;
         end
      end
   end
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

   single_bit_adder adder0 (sum[0], carryout0, A[0], B[0], 0);
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
   reg [31:0] B;
   wire [31:0] nB;

   nB = !B;

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
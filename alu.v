`include alu1.v
module ALU
(
output[31:0]  result,
output        carryout,
output        zero,
output        overflow,
input[31:0]   operandA,
input[31:0]   operandB,
input[2:0]    command
 );

   initial begin
      wire carryinbus [32:0];
      wire zerobus [31:0];
      
      wire commandslice [7:0];
      assign commandslice=1<<command;
      
      genvar     i;
      generate
	 for(i = 0; i < 32; i = i + 1) begin:
	    aluslice alu1(result[i], carryinbus[i+1], zerobus[i], operandA[i], operandB[i], carryinbus[i], commandslice);
	 end
      end 
   `OR(carryout, carryinbus[32], carryinbus[32]);
   zeroout and32(zero, zerobus);
   `XOR(w0, result[31], carryout);
   `XNOR(w1, operandA[31], operandB[31]);
   `AND(overflow, w0, w1);
   
   
     
endmodule

// Single Bit ALU testbench
`timescale 1 ns / 1 ps
`include "alu_single_bit.v"

module testSingleBitALU ();
    reg operandA, operandB, carryin, correct;
    reg [2:0] command;
    wire result, carryout;
 
    ALU_single_bit alusinglebittest(result,carryout,operandA,operandB,carryin,command); 

    initial begin
    $display("command | carryin operandA operandB| result carryout | correct");
    
    //Add
    command = 3'b000; carryin = 0; operandA=0; operandB=0; #50 
    $display("%b| %b %b  %b|%b  %b| %b", command, carryin, operandA, operandB, result, carryout, correct);
    command = 3'b000; carryin = 0; operandA=0; operandB=1; correct = result==1; #50 
    $display("%b| %b %b  %b|%b  %b| %b", command, carryin, operandA, operandB, result, carryout, correct);   
    command = 3'b000; carryin = 0; operandA=1; operandB=0; correct = result==1; #50 
    $display("%b| %b %b  %b|%b  %b| %b", command, carryin, operandA, operandB, result, carryout, correct);
    command = 3'b000; carryin = 0; operandA=1; operandB=1; correct = result==0; #50 
    $display("%b| %b %b  %b|%b  %b| %b", command, carryin, operandA, operandB, result, carryout, correct);
   
    command = 3'b000; carryin = 1; operandA=0; operandB=0; correct = result==1; #50 
    $display("%b| %b %b  %b|%b  %b| %b", command, carryin, operandA, operandB, result, carryout, correct);
    command = 3'b000; carryin = 1; operandA=0; operandB=1; correct = result==0; #50 
    $display("%b| %b %b  %b|%b  %b| %b", command, carryin, operandA, operandB, result, carryout, correct);  
    command = 3'b000; carryin = 1; operandA=1; operandB=0; correct = result==0; #50 
    $display("%b| %b %b  %b|%b  %b| %b", command, carryin, operandA, operandB, result, carryout, correct);
    command = 3'b000; carryin = 1; operandA=1; operandB=1; correct = result==1; #50 
    $display("%b| %b %b  %b|%b  %b| %b", command, carryin, operandA, operandB, result, carryout, correct);


    //SL
    command = 3'b010; operandA=0; operandB=0; correct = result==0; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = 3'b010; operandA=0; operandB=1; correct = result==1; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);    
    command = 3'b010; operandA=1; operandB=0; correct = result==0; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = 3'b010; operandA=1; operandB=1;correct = result==0; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    
    //XOR
    command = 3'b011; operandA=0; operandB=0; correct = result==0; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = 3'b011; operandA=0; operandB=1;correct = result==1; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);    
    command = 3'b011; operandA=1; operandB=0; correct = result==1; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = 3'b011; operandA=1; operandB=1; correct = result==0; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);

    //AND
    command = 3'b100; operandA=0; operandB=0; correct = result==0; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = 3'b100; operandA=0; operandB=1; correct = result==0; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);    
    command = 3'b100; operandA=1; operandB=0; correct = result==0; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = 3'b100; operandA=1; operandB=1; correct = result==1; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);

    //NAND
    command = 3'b100; operandA=0; operandB=0; correct = result==1; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = 3'b100; operandA=0; operandB=1; correct = result==1; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);    
    command = 3'b100; operandA=1; operandB=0; correct = result==1; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = 3'b100; operandA=1; operandB=1; correct = result==0; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);

    //OR
    command = 3'b100; operandA=0; operandB=0; correct = result===0; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = 3'b100; operandA=0; operandB=1; correct = result==1; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);    
    command = 3'b000; operandA=1; operandB=0; correct = result==1; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = 3'b000; operandA=1; operandB=1; correct = result==1; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    
    //NOR
    command = 3'b000; operandA=0; operandB=0; correct = result==1; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = 3'b000; operandA=0; operandB=1; correct = result==0; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);    
    command = 3'b000; operandA=1; operandB=0; correct = result==0; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = 3'b000; operandA=1; operandB=1; correct = result==0; #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
  	
    end

endmodule
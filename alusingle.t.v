// Single Bit ALU testbench
`timescale 1 ns / 1 ps
`include "alusinglebit.v"

module testSingleBitALU ();
    reg operandA, operandB, carryin, command;
    wire result, carryout, correct;

    ALUsinglebit alusinglebittest(result,carryout,operandA,operandB,carryin,command); 

    initial begin
    $display("command | carryin operandA operandB| result carryout | correct");
    
    //Add
    command = `b000; carryin = 0; operandA=0; operandB=0; correct = result==0 #50 
    $display("%b| %b %b  %b|%b  %b| %b", command, carryin, operandA, operandB, result, carryout, correct);
    command = `b000; carryin = 0; operandA=0; operandB=1; correct = result==1 #50 
    $display("%b| %b %b  %b|%b  %b| %b", command, carryin, operandA, operandB, result, carryout, correct);   
    command = `b000; carryin = 0; operandA=1; operandB=0; correct = result==1 #50 
    $display("%b| %b %b  %b|%b  %b| %b", command, carryin, operandA, operandB, result, carryout, correct);
    command = `b000; carryin = 0; operandA=1; operandB=1; correct = result==0 #50 
    $display("%b| %b %b  %b|%b  %b| %b", command, carryin, operandA, operandB, result, carryout, correct);
   
    command = `b000; carryin = 1; operandA=0; operandB=0; correct = result==1 #50 
    $display("%b| %b %b  %b|%b  %b| %b", command, carryin, operandA, operandB, result, carryout, correct);
    command = `b000; carryin = 1; operandA=0; operandB=1; correct = result==0 #50 
    $display("%b| %b %b  %b|%b  %b| %b", command, carryin, operandA, operandB, result, carryout, correct);  
    command = `b000; carryin = 1; operandA=1; operandB=0; correct = result==0 #50 
    $display("%b| %b %b  %b|%b  %b| %b", command, carryin, operandA, operandB, result, carryout, correct);
    command = `b000; carryin = 1; operandA=1; operandB=1; correct = result==1 #50 
    $display("%b| %b %b  %b|%b  %b| %b", command, carryin, operandA, operandB, result, carryout, correct);


    //SL
    command = `b010; operandA=0; operandB=0; correct = result==0 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = `b010; operandA=0; operandB=1; correct = result==1 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);    
    command = `b010; operandA=1; operandB=0; correct = result==0 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = `b010; operandA=1; operandB=1;correct = result==0 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    
    //XOR
    command = `b011; operandA=0; operandB=0; correct = result==0 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = `b011; operandA=0; operandB=1;correct = result==1 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);    
    command = `b011; operandA=1; operandB=0; correct = result==1 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = `b011; operandA=1; operandB=1; correct = result==0 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);

    //AND
    command = `b100; operandA=0; operandB=0; correct = result==0 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = `b100; operandA=0; operandB=1; correct = result==0 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);    
    command = `b100; operandA=1; operandB=0; correct = result==0 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = `b100; operandA=1; operandB=1; correct = result==1 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);

    //NAND
    command = `b100; operandA=0; operandB=0; correct = result==1 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = `b100; operandA=0; operandB=1; correct = result==1 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);    
    command = `b100; operandA=1; operandB=0; correct = result==1 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = `b100; operandA=1; operandB=1; correct = result==0 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);

    //OR
    command = `b100; operandA=0; operandB=0; correct = result===0 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = `b100; operandA=0; operandB=1; correct = result==1 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);    
    command = `b000; operandA=1; operandB=0; correct = result==1 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = `b000; operandA=1; operandB=1; correct = result==1 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    
    //NOR
    command = `b000; operandA=0; operandB=0; correct = result==1 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = `b000; operandA=0; operandB=1; correct = result==0 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);    
    command = `b000; operandA=1; operandB=0; correct = result==0 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
    command = `b000; operandA=1; operandB=1; correct = result==0 #50 
    $display("%b| %b  %b|%b  %b| %b", command, operandA, operandB, result, carryout, correct);
  	

    
    end

endmodule
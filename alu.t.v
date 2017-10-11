`timescale 1 ns / 1 ps
`include "alu.v"

module testALU32bit();
  reg[31:0] a;
  reg[31:0] b;
  reg[2:0] ALUcommand; 
  wire[31:0] finalALUsig;
  wire flag;
  wire cout;

  ALUcontrolLUT alu(cout, flag, finalALUsig, ALUcommand, a, b);
  initial begin
    $display("ALU Command  Input A                          Input B                           | Output                           Flag  Carryout");
    //Test cases add
    ALUcommand = 3'b000;
    
    // 0 + 0
    a = 32'b00000000000000000000000000000000;
    b = 32'b00000000000000000000000000000000;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);

  	// 1 + 1
    a = 32'b00000000000000000000000000000001;
    b = 32'b00000000000000000000000000000001;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);
    
  	// positive overflow
    a = 32'b01111111111111111111111111111111;
    b = 32'b01111111111111111111111111111111;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);
    
  	// negative overflow
    a = 32'b10000000000000000000000000000001;
    b = 32'b10000000000000000000000000000001;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
             
    // carryout
    a = 32'b11111111111111111111111111111111;
    b = 32'b00000000000000000000000000000001;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
    
    //Test cases sub
    ALUcommand = 3'b001;
             
    // a=b=0
    a = 32'b00000000000000000000000000000000;
    b = 32'b00000000000000000000000000000000;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
    
    // a=b
    a = 32'b00000000000000000000000000000001;
    b = 32'b00000000000000000000000000000001;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   

    // a>b, both positive
    a = 32'b00000000000000000000000000000111;
    b = 32'b00000000000000000000000000000101;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
           
    // a<b, both positive
    a = 32'b00000001000000000000000000000101;
    b = 32'b00000010000000000000000000000101;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
             
    // |a|>|b|, both negative
    a = 32'b11111111111111111111111111111101;
    b = 32'b11111111111111111111111111111110;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
               
    // |a|<|b|, both negative
    a = 32'b111111111111111111111111111111110;
    b = 32'b111111111111111111111111111111000;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
             
    // a negative, b positive, no overflow
    a = 32'b11111111111111111111111111111101;
    b = 32'b00000000000000000000000000000101;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   

    // a negative, b positive, overflow
    a = 32'b10000000000000000000000000000101;
    b = 32'b01111100000000000000000000000000;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
             
    // a positive, b negative, no overflow
    a = 32'b00000000000000000000000000000101;
    b = 32'b11111111111111111111111111111111;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
                    
    // Verify expectations and report test result
    if((finalALUsig != 32'b00000000000000000000000000000110) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end 

    // a positive, b negative, overflow
    a = 32'b01111111111111111111101111111111;
    b = 32'b10000000000000001100000000000000;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
      
    // Verify expectations and report test result
    if((flag != 1)) begin
      $display("Test Case Failed");
    end 

    //Test cases xor
    ALUcommand = 3'b010;
    
    //a is all 0's
    a = 32'b00000000000000000000000000000000;
  	b = 32'b11111111111111111111111111111111;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   

    // Verify expectations and report test result
    if((finalALUsig != 32'b11111111111111111111111111111111) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end 
          
    //b is all 0's
    b = 32'b00000000000000000000000000000000;
  	a = 32'b11111111111111111111111111111111;  
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
                
    // Verify expectations and report test result
    if((finalALUsig != 32'b11111111111111111111111111111111) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end 
             
    //a and b are all 0's
    a = 32'b00000000000000000000000000000000;
  	b = 32'b00000000000000000000000000000000;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
                
    // Verify expectations and report test result
    if((finalALUsig != 32'b00000000000000000000000000000000) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end 

    //a and b are all 1's
  	a = 32'b11111111111111111111111111111111;
  	b = 32'b11111111111111111111111111111111; 
    #25000          
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
                
    // Verify expectations and report test result
    if((finalALUsig != 32'b00000000000000000000000000000000) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end 

             
    //Test cases slt
    ALUcommand = 3'b011;
    
    //a>b, all positive
  	a = 32'b00000000000000000000000000000010;
  	b = 32'b00000000000000000000000000000001;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
                
    // Verify expectations and report test result
    if((finalALUsig != 32'b00000000000000000000000000000000) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end 
           
    //a<b, all positive
    a = 32'b00000000000000000000000000000001;
  	b = 32'b00000000000000000000000000000010;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
                
    // Verify expectations and report test result
    if((finalALUsig != 32'b00000000000000000000000000000001) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end 

    //a>b, all negative
    a = 32'b10000000000000000000000000000001;
  	b = 32'b10000000000000000000000000000010;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
                
    // Verify expectations and report test result
    if((finalALUsig != 32'b00000000000000000000000000000000) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end 
             
    //a<b, all negative
    a = 32'b10000000000000000000000000000010;
  	b = 32'b10000000000000000000000000000001;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
                
    // Verify expectations and report test result
    if((finalALUsig != 32'b00000000000000000000000000000001) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end 
             
    //a>b, a positive, b negative
    a = 32'b00000000000000000000000000000001;
  	b = 32'b10000000000000000000000000000010;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
                
    // Verify expectations and report test result
    if((finalALUsig != 32'b00000000000000000000000000000000) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end 

    //a>b, a positive, b negative
    a = 32'b00000000000000000000000000000001;
  	b = 32'b10000000000000000000000000000001;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);   
                 
    // Verify expectations and report test result
    if((finalALUsig != 32'b00000000000000000000000000000000) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end           
             
    //Test cases and
    ALUcommand = 3'b100;
    // 0 and 0
    a = 32'b00000000000000000000000000000000;
    b = 32'b00000000000000000000000000000000;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);
                
    // Verify expectations and report test result
    if((finalALUsig != 32'b00000000000000000000000000000000) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end 

    // 0 and 1
    a = 32'b00000000000000000000000000000000;
    b = 32'b11111111111111111111111111111111;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);    

    // Verify expectations and report test result
    if((finalALUsig != 32'b00000000000000000000000000000000) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end 

    // 1 and 1
    a = 32'b11111111111111111111111111111111;
    b = 32'b11111111111111111111111111111111;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);
                
    // Verify expectations and report test result
    if((finalALUsig != 32'b11111111111111111111111111111111) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end 

    //Test cases nand
    ALUcommand = 3'b101;
    // 0 nand 0
    a = 32'b00000000000000000000000000000000;
    b = 32'b00000000000000000000000000000000;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);
                     
    // Verify expectations and report test result
    if((finalALUsig != 32'b11111111111111111111111111111111) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end 

    // 0 nand 1
    a = 32'b00000000000000000000000000000000;
    b = 32'b11111111111111111111111111111111;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);
                
    // Verify expectations and report test result
    if((finalALUsig != 32'b11111111111111111111111111111111) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end 
    
    // 1 nand 1
    a = 32'b11111111111111111111111111111111;
    b = 32'b11111111111111111111111111111111;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);
    
    // Verify expectations and report test result
    if((finalALUsig != 32'b00000000000000000000000000000000) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end

    //Test cases nor
    ALUcommand = 3'b110;
    // 0 nor 0
    a = 32'b00000000000000000000000000000000;
    b = 32'b00000000000000000000000000000000;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);
                
    // Verify expectations and report test result
    if((finalALUsig != 32'b11111111111111111111111111111111) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end
             
    // 0 nor 1
    a = 32'b00000000000000000000000000000000;
    b = 32'b11111111111111111111111111111111;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);
                
    // Verify expectations and report test result
    if((finalALUsig != 32'b00000000000000000000000000000000) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end

    // 1 nor 1
    a = 32'b11111111111111111111111111111111;
    b = 32'b11111111111111111111111111111111;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);
    
    // Verify expectations and report test result
    if((finalALUsig != 32'b00000000000000000000000000000000) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end

    //Test cases or
    ALUcommand = 3'b111;
    // 0 or 0
    a = 32'b00000000000000000000000000000000;
    b = 32'b00000000000000000000000000000000;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);
    
    // Verify expectations and report test result
    if((finalALUsig != 32'b00000000000000000000000000000000) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end

    // 0 or 1
    a = 32'b00000000000000000000000000000000;
    b = 32'b11111111111111111111111111111111;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);
    
    // Verify expectations and report test result
    if((finalALUsig != 32'b11111111111111111111111111111111) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end
    
    // 1 or 1
    a = 32'b11111111111111111111111111111111;
    b = 32'b11111111111111111111111111111111;
    #25000
    $display("%b           %b %b | %b %b     %b", ALUcommand, a, b, finalALUsig, flag, cout);

    // Verify expectations and report test result
    if((finalALUsig != 32'b11111111111111111111111111111111) || (flag != 0) || (cout != 0)) begin
      $display("Test Case Failed");
    end

  end
endmodule
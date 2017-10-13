`timescale 1 ns / 1 ps
`include "alu.v"

module ALUTestBench();
  reg[2:0]    command;
  reg[31:0]   operandA;
  reg[31:0]   operandB;
  wire[31:0]  result;
  wire        carryout;
  wire        zero;
  wire        overflow;

  integer OperandAs[1:12];
  integer OperandBs[1:12];
  integer results[1:12];
  integer a;

  integer notpassed = 0;
  integer totaltests = 0;

  //ALUcontrolLUT controller(muxindex, invertB, flagger, command);

  ALU alu(result, carryout, zero, overflow, operandA, operandB, command);

    initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, operandA, operandB, result, overflow, zero, carryout, command);
    
    //$display("            A  |            B  |  Com |            Out  |            Exp  | Overflow | Zero");
    //Test Add operation:
    command = 0;
    OperandAs[1] = -5358; OperandAs[2] = 0; OperandAs[3] = -35; 
    OperandBs[1] = 5369; OperandBs[2] = 0; OperandBs[3] = -65;
    results[1]= 11; results[2]= 0 ; results[3]= -100;
    OperandAs[4] = 730; OperandAs[5] = 2147483448; OperandAs[6] = -2147483248;
    OperandBs[4] = -520; OperandBs[5] = 1100; OperandBs[6] = -12099;
    results[4]= 210 ; results[5]= 0; results[6]= 0;
    for (a = 1;  a < 7; a = a + 1)
    begin: addtest
        operandA = OperandAs[a];
        operandB = OperandBs[a];
        totaltests = totaltests + 2;
        #20000 //Delay
        if((result != results[a]) && (overflow != 1)) begin 
            notpassed = notpassed + 1;  // Add to test not passed
            $display("Test Case adding %b to %b Failed with result %d, overflow %d", operandA, operandB, result, overflow);
        end
        if ((result == 0) && (zero!=1))begin //Zero flag check
            notpassed = notpassed + 1; 
            $display("Test Case adding %d to %d Failed with result %d, and zero %d", operandA, operandB, result, zero);
        end
    end

    //Test the Subtract operation
    command = 1;
    OperandAs[1] = -5358; OperandAs[2] = 0; OperandAs[3] = -35; 
    OperandBs[1] = 5369; OperandBs[2] = 0; OperandBs[3] = -65;
    results[1]= -10727; results[2]= 0 ; results[3]= 30;

    OperandAs[4] = 730; OperandAs[5] = 2147481648; OperandAs[6] = -2147423648;
    OperandBs[4] = -520; OperandBs[5] = -12983; OperandBs[6] = 300000;
    results[4]= 1250 ; results[5]= 0; results[6]= 0;
    for (a = 1;  a < 7; a = a + 1)
    #10000
    begin: subtracttest
        operandA = OperandAs[a];
        operandB = OperandBs[a];
        totaltests = totaltests + 2;
        #10000
        if((result != results[a]) && (overflow != 1)) begin 
            notpassed = notpassed + 1;  // Add to test not passed
            $display("Test Case subtracting %d from %d Failed with result %d and overflow %d", operandB, operandA, result, overflow);
        end
        if ((result == 0) && (zero!=1))begin //Zero flag check
            notpassed = notpassed + 1; 
            $display("Test Case subtracting %d to %d Failed with result %d, and zero %d", operandA, operandB, result, zero);
        end
    end

    //Test XOR
    command = 2;
    OperandAs[1] = 300; OperandAs[2] = 32'b1001001; OperandAs[3] = 32'b000011111; 
    OperandBs[1] = 25; OperandBs[2] = 32'b1001001; OperandBs[3] = 32'b000011111;
    results[1]= 32'b100110101; results[2] = 0; results[3]= 0;
    OperandAs[4] = 32'b1101010101010001010; 
    OperandBs[4] = 0; 
    results[4] = 32'b1101010101010001010;

    for (a = 1;  a < 5; a = a + 1)
    #10000
    begin: xortest
        operandA = OperandAs[a];
        operandB = OperandBs[a];
        totaltests = totaltests + 2;
        #10000
        if(result != results[a]) begin 
            notpassed = notpassed + 1;  // Add to test not passed
            $display("Test Case XOR %b and %b Failed with result %b", operandB, operandA, result);
        end
        if ((result == 0) && (zero!=1))begin //Zero flag check
            notpassed = notpassed + 1; 
            $display("Test Case XOR %b and %b Failed with result %b, and zero %b", operandA, operandB, result, zero);
        end
    end
    
    //Test SLT
    command = 3;
    OperandAs[1] = 200; OperandAs[2] = -800; OperandAs[3] = -9000; 
    OperandBs[1] = 700; OperandBs[2] = -200; OperandBs[3] = 1293846473;
    results[1]= 1; results[2]= 1; results[3]= 1;

    OperandAs[4] = 0; OperandAs[5] = 2147481648; OperandAs[6] = -2147423648;
    OperandBs[4] = 0; OperandBs[5] = -12983; OperandBs[6] = 300000;
    results[4]= 0; results[5]= 0; results[6]= 1;

    OperandAs[7] = 102938761; OperandAs[8] = -800; OperandAs[9] = 54086; 
    OperandBs[7] = 234; OperandBs[8] = -3773377; OperandBs[9] = -2988888;
    results[7]= 0; results[8] = 0; results[9]= 0;

    OperandAs[10] = 700; OperandAs[11] = -800; 
    OperandBs[10] = 700; OperandBs[11] = -800; 
    results[10]= 0; results[11]= 0; 

    for (a = 1;  a < 12; a = a + 1)
    #10000
    begin: slttest
        operandA = OperandAs[a];
        operandB = OperandBs[a];
        totaltests = totaltests + 2;
        #10000
        if(result != results[a]) begin 
            notpassed = notpassed + 1;  // Add to test not passed
            $display("Test Case slt %d and %d Failed with result %d", operandB, operandA, result);
        end
        if ((result == 0) && (zero!=1))begin //Zero flag check
            notpassed = notpassed + 1; 
            $display("Test Case slt %d and %d Failed with result %d, and zero %d", operandA, operandB, result, zero);
        end
    end


    //Test AND
    command = 4;
    OperandAs[1] = 32'b111010001; OperandAs[2] = 32'b101001; OperandAs[3] = 32'b000011111; 
    OperandBs[1] = 32'b010101001; OperandBs[2] = 32'b010000; OperandBs[3] = 32'b000000000;
    results[1]   = 32'b010000001; results[2] = 0; results[3]= 0;
    OperandAs[4] = 32'b11010101010; 
    OperandBs[4] = 32'b10100010010; 
    results[4]   = 32'b10000000010;

    for (a = 1;  a < 5; a = a + 1)
    #10000
    begin: andtest
        operandA = OperandAs[a];
        operandB = OperandBs[a];
        totaltests = totaltests + 2;
        #10000
        if(result != results[a]) begin 
            notpassed = notpassed + 1;  // Add to test not passed
            $display("Test Case AND %b and %b Failed with result %b", operandB, operandA, result);
        end
        if ((result == 0) && (zero!=1))begin //Zero flag check
            notpassed = notpassed + 1; 
            $display("Test Case AND %b and %b Failed with result %b, and zero %b", operandA, operandB, result, zero);
        end
    end

    //Test NAND
    command = 5;
    OperandAs[1] = 32'b111010001; OperandAs[2] = 32'b11111111111111111111111111111111; OperandAs[3] = 32'b000011111; 
    OperandBs[1] = 32'b010101001; OperandBs[2] = 32'b11111111111111111111111111111111; OperandBs[3] = 32'b000000000;
    results[1]   = 32'b11111111111111111111111101111110; results[2] = 0;            results[3]   = 32'b11111111111111111111111111111111;

    for (a = 1;  a < 4; a = a + 1)
    #10000
    begin: nandtest
        operandA = OperandAs[a];
        operandB = OperandBs[a];
        totaltests = totaltests + 2;
        #10000
        if(result != results[a]) begin 
            notpassed = notpassed + 1;  // Add to test not passed
            $display("Test Case NAND %b and %b Failed with result %b", operandB, operandA, result);
        end
        if ((result == 0) && (zero!=1))begin //Zero flag check
            notpassed = notpassed + 1; 
            $display("Test Case NAND %b and %b Failed with result %b, and zero %b", operandA, operandB, result, zero);
        end
    end

    //Test OR
    command = 7;
    OperandAs[1] = 32'b111010001; OperandAs[2] = 32'b00000; OperandAs[3] = 32'b000011111; 
    OperandBs[1] = 32'b010101001; OperandBs[2] = 32'b00000; OperandBs[3] = 32'b000000000;
    results[1]   = 32'b111111001; results[2] = 0; results[3]= 32'b000011111;

    for (a = 1;  a < 4; a = a + 1)
    #10000
    begin: ortest
        operandA = OperandAs[a];
        operandB = OperandBs[a];
        totaltests = totaltests + 2;
        #10000
        if(result != results[a]) begin 
            notpassed = notpassed + 1;  // Add to test not passed
            $display("Test Case OR %b with %b Failed with result %b", operandB, operandA, result);
        end
        if ((result == 0) && (zero!=1))begin //Zero flag check
            notpassed = notpassed + 1; 
            $display("Test Case OR %b with %b Failed with result %b, and zero %b", operandA, operandB, result, zero);
        end
    end

    //Test NOR
    command = 6;
    OperandAs[1] = 32'b111010001; OperandAs[2] = 32'b00000; OperandAs[3] = 32'b000011111; 
    OperandBs[1] = 32'b010101001; OperandBs[2] = 32'b00000; OperandBs[3] = 32'b11111111111111111111111111100000;
    results[1]   = 32'b11111111111111111111111000000110;    results[2]   = 32'b11111111111111111111111111111111; results[3]= 0;

    for (a = 1;  a < 4; a = a + 1)
    #10000
    begin: nortest
        operandA = OperandAs[a];
        operandB = OperandBs[a];
        totaltests = totaltests + 2;
        #10000
        if(result != results[a]) begin 
            notpassed = notpassed + 1;  // Add to test not passed
            $display("Test Case NOR %b with %b Failed with result %b", operandB, operandA, result);
        end
        if ((result == 0) && (zero!=1))begin //Zero flag check
            notpassed = notpassed + 1; 
            $display("Test Case NOR %b with %b Failed with result %b, and zero %b", operandA, operandB, result, zero);
        end
    end

    //Print our total test results
    if (notpassed == 0) begin
        $display("All %d tests passed! :)", totaltests);
    end
    else begin
        $display("Number of test failed %d", notpassed);
    end
end
endmodule

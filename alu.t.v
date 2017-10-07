// ALU testbench
`include "alu.v"

module testalu ();
  reg operandA, operandB, command;
  wire result, carryout, zero, overflow;

  ALU dut (result, carryout, zero, overflow, operandA, operandB, command);

  initial begin
    $dumpfile("alu.vcd");

    // add test cases
    // Cout = 0, Overflow = 0; Cout = 1, Overflow = 0; Cout = 0, Overflow = 1; Cout = 1, Overflow = 1


    // subtract test cases
    // Cout = 0, Overflow = 0; Cout = 1, Overflow = 0; Cout = 0, Overflow = 1; Cout = 1, Overflow = 1

    // Xor test cases
    // two inputs the same; two inputs totally different; two inputs with some bits corresponding
    operandA = 01010101010101010101010101010101; operandB = 01010101010101010101010101010101; command = 3'b010;
    if (result !== 00000000000000000000000000000000) $display("Xor test case 1 (inputs same) failed");
    operandA = 01010101010101010101010101010101; operandB = 10101010101010101010101010101010; command = 3'b010;
    if (result !== 11111111111111111111111111111111) $display("Xor test case 2 (inputs different) failed");
    operandA = 01010101010101010101010101010101; operandB = 01011010010110100101101001011010; command = 3'b010;
    if (result !== 1111000011110000111100001111000) $display("Xor test case 3 (inputs somewhat corresponding) failed");

    // SLT test cases
    // inputs greater than, less than, equal to; for positive, negatives, and combinations of each

    // And test cases
    // two inputs exactly the same; two inputs totally different; two inputs with some bits corresponding
    operandA = 01010101010101010101010101010101; operandB = 01010101010101010101010101010101; command = 3'b100;
    if (result !== 01010101010101010101010101010101) $display("And test case 1 (inputs same) failed");
    operandA = 01010101010101010101010101010101; operandB = 10101010101010101010101010101010; command = 3'b100;
    if (result !== 00000000000000000000000000000000) $display("And test case 2 (inputs different) failed");
    operandA = 01010101010101010101010101010101; operandB = 01011010010110100101101001011010; command = 3'b100;
    if (result !== 00001111000011110000111100001111) $display("And test case 3 (inputs somewhat corresponding) failed");

    // Nand test cases
    // two inputs exactly the same; two inputs totally different; two inputs with some bits corresponding
    operandA = 01010101010101010101010101010101; operandB = 01010101010101010101010101010101; command = 3'b101;
    if (result !== 10101010101010101010101010101010) $display("Nand test case 1 (inputs same) failed");
    operandA = 01010101010101010101010101010101; operandB = 10101010101010101010101010101010; command = 3'b101;
    if (result !== 11111111111111111111111111111111) $display("Nand test case 2 (inputs different) failed");
    operandA = 01010101010101010101010101010101; operandB = 01011010010110100101101001011010; command = 3'b101;
    if (result !== 11110000111100001111000011110000) $display("Nand test case 3 (inputs somewhat corresponding) failed");

    // Nor test cases
    // two inputs exactly the same; two inputs totally different; two inputs with some bits corresponding
    operandA = 01010101010101010101010101010101; operandB = 01010101010101010101010101010101; command = 3'b110;
    if (result !== 10101010101010101010101010101010) $display("Nor test case 1 (inputs same) failed");
    operandA = 01010101010101010101010101010101; operandB = 10101010101010101010101010101010; command = 3'b110;
    if (result !== 00000000000000000000000000000000) $display("Nor test case 2 (inputs different) failed");
    operandA = 01010101010101010101010101010101; operandB = 01011010010110100101101001011010; command = 3'b110;
    if (result !== 10100000101000001010000010100000) $display("Nor test case 3 (inputs somewhat corresponding) failed");

    // Or test cases
    // two inputs exactly the same; two inputs totally different; two inputs with some bits corresponding
    operandA = 01010101010101010101010101010101; operandB = 01010101010101010101010101010101; command = 3'b111;
    if (result !== 01010101010101010101010101010101) $display("Nor test case 1 (inputs same) failed");
    operandA = 01010101010101010101010101010101; operandB = 10101010101010101010101010101010; command = 3'b111;
    if (result !== 11111111111111111111111111111111) $display("Nor test case 2 (inputs different) failed");
    operandA = 01010101010101010101010101010101; operandB = 01011010010110100101101001011010; command = 3'b111;
    if (result !== 01011111010111110101111101011111) $display("Nor test case 3 (inputs somewhat corresponding) failed");

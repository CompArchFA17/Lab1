// ALU testbench
`include "alu.v"

module testalu ();
reg[31:0] operandA;
reg[31:0] operandB;
reg[2:0] command;

wire[31:0] result;
wire carryout;
wire zero;
wire overflow;

 ALU alu(result, carryout, zero, overflow, operandA, operandB, command);

  initial begin
    $dumpfile("alu.vcd");

    // add test cases
    // Cout = 0, Overflow = 0; Cout = 1, Overflow = 0; Cout = 0, Overflow = 1; Cout = 1, Overflow = 1
    operandA = 32'b00100000000000000000000000000000; operandB = 32'b11000000000000000000000000000000; command = 3'b000; #1000
    if (result !== 32'b11100000000000000000000000000000) $display("Add test case 1 (Cout = 0, Overflow = 0) result failed");
    if (carryout !== 0) $display("Add test case 1 (Cout = 0, Overflow = 0) Cout failed");
    if (overflow !== 0) $display("Add test case 1 (Cout = 0, Overflow = 0) Overflow failed");
    operandA = 32'b00000000000000000000000000001110; operandB = 32'b00000000000000000000000000001100; command = 3'b000; #1000
    if (result !== 32'b10100000000000000000000000000000) $displayb(result);//("Add test case 2 (Cout = 1, Overflow = 0) result failed");
    if (carryout !== 1) $displayb(carryout);//("Add test case 1 (Cout = 1, Overflow = 0) Cout failed");
    if (overflow !== 0) $display("Add test case 1 (Cout = 1, Overflow = 0) Overflow failed");

    // subtract test cases
    // Cout = 0, Overflow = 0; Cout = 1, Overflow = 0; Cout = 0, Overflow = 1; Cout = 1, Overflow = 1

    // Xor test cases
    // two inputs the same; two inputs totally different; two inputs with some bits corresponding
    operandA = 32'b01010101010101010101010101010101; operandB = 32'b01010101010101010101010101010101; command = 3'b010; #1000
    if (result !== 32'b00000000000000000000000000000000) $display("Xor test case 1 (inputs same) failed");
    operandA = 32'b01010101010101010101010101010101; operandB = 32'b10101010101010101010101010101010; command = 3'b010; #1000
    if (result !== 32'b11111111111111111111111111111111) $display("Xor test case 2 (inputs different) failed");
    operandA = 32'b01010101010101010101010101010101; operandB = 32'b01011010010110100101101001011010; command = 3'b010; #1000
    if (result !== 32'b00001111000011110000111100001111) $display("Xor test case 3 (inputs somewhat corresponding) failed");

    // SLT test cases
    // inputs greater than, less than, equal to; for positive, negatives, and combinations of each
    operandA = 32'd5000; operandB = 32'd100; command = 3'b011; #1000
    if (result !== 32'b00000000000000000000000000000000) $display("SLT test case 1 (postive greater) failed");
    operandA = 32'd50; operandB = 32'd100; command = 3'b011; #1000
    if (result !== 32'b00000000000000000000000000000001) $display("SLT test case 1 (postive less) failed");
    operandA = 32'd100; operandB = 32'd100; command = 3'b011; #1000
    if (result !== 32'b00000000000000000000000000000000) $display("SLT test case 3 (postive equal) failed");
    operandA = -32'd5000; operandB = -32'd100; command = 3'b011; #1000
    if (result !== 32'b00000000000000000000000000000001) $display("SLT test case 4 (negative less) failed");
    operandA = -32'd100; operandB = -32'd5000; command = 3'b011; #1000
    if (result !== 32'b00000000000000000000000000000000) $display("SLT test case 5 (negative greater) failed");
    operandA = -32'd100; operandB = 32'd100; command = 3'b011; #1000
    if (result !== 32'b00000000000000000000000000000001) $display("SLT test case 6 (negative and positive) failed");
    operandA = 32'd100; operandB = -32'd100; command = 3'b011; #1000
    if (result !== 32'b00000000000000000000000000000000) $display("SLT test case 7 (positive and negative) failed");

    // And test cases
    // two inputs exactly the same; two inputs totally different; two inputs with some bits corresponding
    operandA = 32'b01010101010101010101010101010101; operandB = 32'b01010101010101010101010101010101; command = 3'b100; #1000
    if (result !== 32'b01010101010101010101010101010101) $display("And test case 1 (inputs same) failed");
    operandA = 32'b01010101010101010101010101010101; operandB = 32'b10101010101010101010101010101010; command = 3'b100; #1000
    if (result !== 32'b00000000000000000000000000000000) $display("And test case 2 (inputs different) failed");
    operandA = 32'b01010101010101010101010101010101; operandB = 32'b01011010010110100101101001011010; command = 3'b100; #1000
    if (result !== 32'b01010000010100000101000001010000) $display("And test case 3 (inputs somewhat corresponding) failed");

    // Nand test cases
    // two inputs exactly the same; two inputs totally different; two inputs with some bits corresponding
    operandA = 32'b01010101010101010101010101010101; operandB = 32'b01010101010101010101010101010101; command = 3'b101; #1000
    if (result !== 32'b10101010101010101010101010101010) $display("Nand test case 1 (inputs same) failed");
    operandA = 32'b01010101010101010101010101010101; operandB = 32'b10101010101010101010101010101010; command = 3'b101; #1000
    if (result !== 32'b11111111111111111111111111111111) $display("Nand test case 2 (inputs different) failed");
    operandA = 32'b01010101010101010101010101010101; operandB = 32'b01011010010110100101101001011010; command = 3'b101; #1000
    if (result !== 32'b10101111101011111010111110101111) $displayb("Nand test case 3 (inputs somewhat corresponding) failed");

    // Nor test cases
    // two inputs exactly the same; two inputs totally different; two inputs with some bits corresponding
    operandA = 32'b01010101010101010101010101010101; operandB = 32'b01010101010101010101010101010101; command = 3'b111; #1000
    if (result !== 32'b10101010101010101010101010101010) $display("Nor test case 1 (inputs same) failed");
    operandA = 32'b01010101010101010101010101010101; operandB = 32'b10101010101010101010101010101010; command = 3'b111; #1000
    if (result !== 32'b00000000000000000000000000000000) $display("Nor test case 2 (inputs different) failed");
    operandA = 32'b01010101010101010101010101010101; operandB = 32'b01011010010110100101101001011010; command = 3'b111; #1000
    if (result !== 32'b10100000101000001010000010100000) $display("Nor test case 3 (inputs somewhat corresponding) failed");

    // Or test cases
    // two inputs exactly the same; two inputs totally different; two inputs with some bits corresponding
    operandA = 32'b01010101010101010101010101010101; operandB = 32'b01010101010101010101010101010101; command = 3'b110; #1000
    if (result !== 32'b01010101010101010101010101010101) $display("Or test case 1 (inputs same) failed");
    operandA = 32'b01010101010101010101010101010101; operandB = 32'b10101010101010101010101010101010; command = 3'b110; #1000
    if (result !== 32'b11111111111111111111111111111111) $display("Or test case 2 (inputs different) failed");
    operandA = 32'b01010101010101010101010101010101; operandB = 32'b01011010010110100101101001011010; command = 3'b110; #1000
    if (result !== 32'b01011111010111110101111101011111) $display("Or test case 3 (inputs somewhat corresponding) failed");
end
endmodule // testalu

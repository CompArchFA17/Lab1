//Test harness for exhaustively testing individual bit_slice modules

`include "BitSlice.v"

module BitSliceTestHarness ();

    reg ADD, SUB, XOR, AND, NAND, NOR, OR, A, B, CIN;

    wire cout, sum, res;

    BitSlice bit_slice (cout, sum, res, ADD, SUB, XOR, AND, NAND, NOR, OR, A, B, CIN);

    reg[3:0] inputs;
    reg[6:0] index;

    initial begin
    // Test bench code here.
    $dumpfile("BitSlice.vcd");
    $dumpvars(0,bit_slice);

    // Test simpler gates, OR, NOR, NAND, AND, XOR
    // OR
    {ADD, SUB, XOR, AND, NAND, NOR, OR} = 7'b0000001; // Set OR flag
    for (inputs=4'b0; inputs<4'b1000; inputs=inputs+4'b1) begin
        {CIN, A, B} = inputs; #1000 // Set inputs and wait
        // $display( "%b %b %b", index, A, B); //
        if (res != A|B) begin
            $display("Test Case OR Cin:%b A:%b B:%b Failed, Got %b Expected %b", CIN, A, B, res, A|B);
        end
    end

    // NOR
    {ADD, SUB, XOR, AND, NAND, NOR, OR} = 7'b0000010; // Set OR flag
    for (inputs=4'b0; inputs<4'b1000; inputs=inputs+4'b1) begin
        {CIN, A, B} = inputs; #1000 // Set inputs and wait
        // $display( "%b %b %b", index, A, B); //
        if (res != A~|B) begin
            $display("Test Case NOR Cin:%b A:%b B:%b Failed, Got %b Expected %b", CIN, A, B, res, A~|B);
        end
    end

    // NAND
    {ADD, SUB, XOR, AND, NAND, NOR, OR} = 7'b0000100; // Set OR flag
    for (inputs=4'b0; inputs<4'b1000; inputs=inputs+4'b1) begin
        {CIN, A, B} = inputs; #1000 // Set inputs and wait
        // $display( "%b %b %b", index, A, B); //
        if (res != A~&B) begin
            $display("Test Case NAND Cin:%b A:%b B:%b Failed, Got %b Expected %b", CIN, A, B, res, A~&B);
        end
    end

    // AND
    {ADD, SUB, XOR, AND, NAND, NOR, OR} = 7'b0001000; // Set OR flag
    for (inputs=4'b0; inputs<4'b1000; inputs=inputs+4'b1) begin
        {CIN, A, B} = inputs; #1000 // Set inputs and wait
        // $display( "%b %b %b", index, A, B); //
        if (res != A&B) begin
            $display("Test Case AND Cin:%b A:%b B:%b Failed, Got %b Expected %b", CIN, A, B, res, A&B);
        end
    end

    // XOR
    {ADD, SUB, XOR, AND, NAND, NOR, OR} = 7'b0010000; // Set OR flag
    for (inputs=4'b0; inputs<4'b1000; inputs=inputs+4'b1) begin
        {CIN, A, B} = inputs; #1000 // Set inputs and wait
        // $display( "%b %b %b", index, A, B); //
        if (res != A^B) begin
            $display("Test Case XOR Cin:%b A:%b B:%b Failed, Got %b Expected %b", CIN, A, B, res, A^B);
        end
    end

    end

endmodule

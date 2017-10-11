//Test harness for exhaustively testing individual bit_slice modules

`include "BitSlice.v"

module BitSliceTestHarness ();

    reg ADD, SUB, XOR, AND, NAND, NOR, OR, A, B, CIN;

    wire cout, sum, res;

    BitSlice bit_slice (cout, sum, res, ADD, SUB, XOR, AND, NAND, NOR, OR, A, B, CIN);

    reg[3:0] inputs;
    reg[6:0] index;
    reg testfailed;

    initial begin
    // Test bench code here.
    $dumpfile("BitSlice.vcd");
    $dumpvars(0,bit_slice);

    // Initialize test failed to 0
    testfailed = 0;

    // Test simpler gates, OR, NOR, NAND, AND, XOR
    // OR
    {ADD, SUB, XOR, AND, NAND, NOR, OR} = 7'b0000001; // Set OR flag
    for (inputs=4'b0; inputs<4'b1000; inputs=inputs+4'b1) begin
        {CIN, A, B} = inputs; #1000 // Set inputs and wait
        // $display( "%b %b %b", index, A, B); //
        if (res != (A|B)) begin
            testfailed = testfailed+1;
            $display("Test Case OR Cin:%b A:%b B:%b Failed, Got %b Expected %b", CIN, A, B, res, (A|B));
        end
    end

    // NOR
    {ADD, SUB, XOR, AND, NAND, NOR, OR} = 7'b0000010; // Set OR flag
    for (inputs=4'b0; inputs<4'b1000; inputs=inputs+4'b1) begin
        {CIN, A, B} = inputs; #1000 // Set inputs and wait
        // $display( "%b %b %b", index, A, B); //
        if (res != (A~|B)) begin
            testfailed = testfailed+1;
            $display("Test Case NOR Cin:%b A:%b B:%b Failed, Got %b Expected %b", CIN, A, B, res, (A~|B));
        end
    end

    // NAND
    {ADD, SUB, XOR, AND, NAND, NOR, OR} = 7'b0000100; // Set OR flag
    for (inputs=4'b0; inputs<4'b1000; inputs=inputs+4'b1) begin
        {CIN, A, B} = inputs; #1000 // Set inputs and wait
        // $display( "%b %b %b", index, A, B); //
        if (res != (A~&B)) begin
            testfailed = testfailed+1;
            $display("Test Case NAND Cin:%b A:%b B:%b Failed, Got %b Expected %b", CIN, A, B, res, (A~&B));
        end
    end

    // AND
    {ADD, SUB, XOR, AND, NAND, NOR, OR} = 7'b0001000; // Set OR flag
    for (inputs=4'b0; inputs<4'b1000; inputs=inputs+4'b1) begin
        {CIN, A, B} = inputs; #1000 // Set inputs and wait
        // $display( "%b %b %b", index, A, B); //
        if (res != (A&B)) begin
            testfailed = testfailed+1;
            $display("Test Case AND Cin:%b A:%b B:%b Failed, Got %b Expected %b", CIN, A, B, res, (A&B));
        end
    end

    // XOR
    {ADD, SUB, XOR, AND, NAND, NOR, OR} = 7'b0010000; // Set OR flag
    for (inputs=4'b0; inputs<4'b1000; inputs=inputs+4'b1) begin
        {CIN, A, B} = inputs; #1000 // Set inputs and wait
        // $display( "%b %b %b", index, A, B); //
        if (res != (A^B)) begin
            testfailed = testfailed+1;
            $display("Test Case XOR Cin:%b A:%b B:%b Failed, Got %b Expected %b", CIN, A, B, res, (A^B));
        end
    end

    // Test more complicated gates: ADD and SUB
    // ADD
    {ADD, SUB, XOR, AND, NAND, NOR, OR} = 7'b1000000; // Set SUB flag
    for (inputs=4'b0; inputs<4'b1000; inputs=inputs+4'b1) begin
        {CIN, A, B} = inputs; #1000 // Set inputs and wait
        // $display( "%b %b %b", index, A, B); //
        if (sum != (A^B^CIN)) begin
            testfailed = testfailed+1;
            $display("Test Case ADD Cin:%b A:%b B:%b Failed, Got Sum:%b Expected Sum:%b", CIN, A, B, sum, A^B^CIN);
        end
        if (sum != (A^B^CIN)) begin
            testfailed = testfailed+1;
            $display("Test Case ADD Cin:%b A:%b B:%b Failed, Got Res:%b Expected Res:%b", CIN, A, B, sum, A^B^CIN);
        end
        if (cout != ((A&B)|((A^B)&CIN))) begin // (A&B)|((A^B)&CIN) is the correct carryout logic
            testfailed = testfailed+1;
            $display("Test Case ADD Cin:%b A:%b B:%b Failed, Got Cout:%b Expected Cout:%b", CIN, A, B, cout, (A&B)|((A^B)&CIN));
        end
    end

    // SUB is identical to ADD but all of the B inputs to the test cases are inverted.
    {ADD, SUB, XOR, AND, NAND, NOR, OR} = 7'b0100000; // Set SUB flag
    for (inputs=4'b0; inputs<4'b1000; inputs=inputs+4'b1) begin
        {CIN, A, B} = inputs; #1000 // Set inputs and wait
        // $display( "%b %b %b", index, A, B); //
        if (sum != (A^(!B)^CIN)) begin
            testfailed = testfailed+1;
            $display("Test Case SUB Cin:%b A:%b B:%b Failed, Got Sum:%b Expected Sum:%b", CIN, A, B, sum, A^(!B)^CIN);
        end
        if (sum != (A^(!B)^CIN)) begin
            testfailed = testfailed+1;
            $display("Test Case SUB Cin:%b A:%b B:%b Failed, Got Res:%b Expected Res:%b", CIN, A, B, sum, A^(!B)^CIN);
        end
        if (cout != ((A&(!B))|((A^(!B))&CIN))) begin // (A&(!B))|((A^(!B))&CIN) is the correct carryout logic
            testfailed = testfailed+1;
            $display("Test Case SUB Cin:%b A:%b B:%b Failed, Got Cout:%b Expected Cout:%b", CIN, A, B, cout, (A&(!B))|((A^(!B))&CIN));
        end
    end

    if(testfailed) begin
        $display("%d Test Failures", testfailed);
    end
    else begin
        $display("Tests Passed");
    end

    end

endmodule

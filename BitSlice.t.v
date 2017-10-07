//Test harness for exhaustively testing individual bit_slice modules

`include "BitSlice.v"

module BitSliceTestHarness ();

    reg ADD, SUB, XOR, AND, NAND, NOR, OR, A, B, CIN;

    wire cout, sum, res;

    BitSlice bit_slice (cout, sum, res, ADD, SUB, XOR, AND, NAND, NOR, OR, A, B, CIN);

    reg[3:0] inputs;

    initial begin
    // Test bench code here.
    $dumpfile("BitSlice.vcd");
    $dumpvars(0,bit_slice);

    // Test simpler gates first
    for (inputs=4'b0; inputs<4'b100; inputs=inputs+4'b1) begin
        {CIN, A, B} = inputs;
        
    end


    end

endmodule

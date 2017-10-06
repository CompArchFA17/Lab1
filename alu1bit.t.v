// 1 Bit alu test bench
`timescale 1 ns / 1 ps
`include "alu1bit.v"

module testALU1bit ();
  wire     out, cout;
  reg      a, b, cin;
  reg[2:0] op;

  ALU1bit alu (out,cout,a,b,cin,op);
  initial begin
    // $dumpfile("../resources/mux.vcd");
    // $dumpvars;

    // Test ADD
    op=3'b000;
    // without cin
    cin = 0;
    // 0 + 0 = 0
    // 0 + 1 = 1
    // 1 + 0 = 1
    //
    // addr1=0;in0=0;in1=0;in2=0;in3=0; #1000
    // if ()

    // Test XOR
    op=3'b010; cin = 0;
    // 0 xor 0 = 0
    a=0;b=0; #1000
    if (cout != 0) begin
        $display("Failed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
    end
    // 0 xor 1 = 1
    a=0;b=1; #1000
    if (cout != 1) begin
        $display("Failed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
    end
    // 1 xor 0 = 1
    a=1;b=0; #1000
    if (cout != 1) begin
        $display("Failed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
    end
    // 1 xor 1 = 0
    a=1;b=1; #1000
    if (cout != 0) begin
        $display("Failed test with: %b  %b  %b  %b | %b  %b", op, a, b, cin, out, cout);
    end

    // Test next op...

    end
endmodule

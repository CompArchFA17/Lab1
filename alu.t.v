`include "alu.v"
// TODO: investigate, uncommenting this makes everything break.
// `timescale 1 ns / 1 ps

`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

module testALU ();
  // Your test code here
    reg[2:0] address;
    reg signed [31:0] a,b;
    wire carryout, overflow, zero;
    wire signed [31:0] out;

    ALU alu(out, carryout, zero, overflow, a, b, address);

    initial begin 

    $dumpfile("alu.vcd");
    $dumpvars(0,alu);

	address = `SUB; a = 32'd10; b = 32'd10; #5000
    $display("SUB %d %d ", a, b);
    if ((out !== 32'd0) || (carryout !== 1) || (overflow !== 0)) $display("*** SUB %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);

    address = `ADD; a = 32'd10; b = 32'd10; #5000
    $display("ADD %d %d ", a, b);
    if ((out !== 32'd20) || (carryout !== 0) || (overflow !== 0)) $display("*** ADD %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);

    address = `XOR; a = 32'd10; b = 32'd10; #5000
    $display("XOR %d %d ", a, b);
    if ((out !== 32'd0) || (carryout !== 0) || (overflow !== 0)) $display("*** XOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);

    address = `SLT; a = 32'd15; b = 32'd10; #5000
    $display("SLT %d %d ", a, b);
    if ((out !== 32'd0) || (carryout !== 0) || (overflow !== 0)) $display("*** SLT %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);

    address = `AND; a = 32'd10; b = 32'd10; #5000
    $display("AND %d %d ", a, b);
    if ((out !== 32'd10) || (carryout !== 0) || (overflow !== 0)) $display("*** AND %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);

    address = `NAND; a = 32'd10; b = 32'd10; #5000
    $display("NAND%d %d ", a, b);
    if ((out !== 32'hfffffff5) || (carryout !== 0) || (overflow !== 0)) $display("*** NAND %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);

    address = `NOR; a = 32'd10; b = 32'd10; #5000
    $display("NOR %d %d ", a, b);
    if ((out !== 32'hfffffff5) || (carryout !== 0) || (overflow !== 0)) $display("*** NOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);

    address = `OR; a = 32'd10; b = 32'd10; #5000
    $display("OR  %d %d ", a, b);
    if ((out !== 32'd10) || (carryout !== 0) || (overflow !== 0)) $display("*** OR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);



    // 10 - 0
    address = `SUB; a = 32'd10; b = 32'd0; #5000
    $display("SUB %d %d ", a, b);
    if ((out !== 32'd10) || (carryout !== 0) || (overflow !== 0)) $display("*** SUB %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    // 0 - 10, has problems:
	address = `SUB; a = 32'd0; b = 32'd10; #5000
    $display("SUB %d %d ", a, b);
    if ((out !== -32'd10) || (carryout !== 0) || (overflow !== 0)) $display("*** SUB %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    // 15 - 10
	address = `SUB; a = 32'd15; b = 32'd10; #5000
    $display("SUB %d %d ", a, b);
    if ((out !== 32'd5) || (carryout !== 1) || (overflow !== 0)) $display("*** SUB %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    // 10 + 0
    address = `ADD; a = 32'd10; b = 32'd0; #5000
    $display("ADD %d %d ", a, b);
    if ((out !== 32'd10) || (carryout !== 0) || (overflow !== 0)) $display("*** ADD %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    // -1 + 0, has problems:
    address = `ADD; a = 32'b1111; b = 32'd0; #5000
    $display("ADD %d %d ", a, b);
    if ((out !== 32'b1111) || (carryout !== 0) || (overflow !== 0)) $display("*** ADD %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    // 10 + 20
    address = `ADD; a = 32'd10; b = 32'd20; #5000
    $display("ADD %d %d ", a, b);
    if ((out !== 32'd30) || (carryout !== 0) || (overflow !== 0)) $display("*** ADD %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);

    // 0 XOR 1
    address = `XOR; a = 32'd0; b = 32'd1; #5000
    $display("XOR %d %d ", a, b);
    if ((out !== 32'd1) || (carryout !== 0) || (overflow !== 0)) $display("*** XOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    // b'10000 XOR b'10101
    address = `XOR; a = 32'b10000; b = 32'b10101; #5000
    $display("XOR %d %d ", a, b);
    if ((out !== 32'b00101) || (carryout !== 0) || (overflow !== 0)) $display("*** XOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    // b'00000 XOR b'11111
    address = `XOR; a = 32'b00000; b = 32'b11111; #5000
    $display("XOR %d %d ", a, b);
    if ((out !== 32'b11111) || (carryout !== 0) || (overflow !== 0)) $display("*** XOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);

    // SLT 1 1
    address = `SLT; a = 32'd1; b = 32'd1; #5000
    $display("SLT %d %d ", a, b);
    if ((out !== 32'd0) || (carryout !== 0) || (overflow !== 0)) $display("*** SLT %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    // SLT 5 10
    address = `SLT; a = 32'd5; b = 32'd10; #5000
    $display("SLT %d %d ", a, b);
    if ((out !== 32'd1) || (carryout !== 0) || (overflow !== 0)) $display("*** SLT %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    // SLT b'001 d'1
    address = `SLT; a = 32'b001; b = 32'd1; #5000
    $display("SLT %d %d ", a, b);
    if ((out !== 32'b0) || (carryout !== 0) || (overflow !== 0)) $display("*** SLT %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    

    /*** serena's test cases ***/

    address = `ADD; a = 32'hffffffff; b = 32'h1; #5000
    $display("ADD %d %d ", a, b);
    if ((out !== 32'h0) || (carryout !== 1) || (overflow !== 0)) $display("*** ADD %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `ADD; a = 32'h7fffffff; b = 32'h1; #5000
    $display("ADD %d %d ", a, b);
    if ((out !== 32'h80000000) || (carryout !== 0) || (overflow !== 1)) $display("*** ADD %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `ADD; a = 32'h1; b = 32'h7fffffff; #5000
    $display("ADD %d %d ", a, b);
    if ((out !== 32'h80000000) || (carryout !== 0) || (overflow !== 1)) $display("*** ADD %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `SUB; a = 32'h0; b = 32'h0; #5000
    $display("SUB %d %d ", a, b);
    if ((out !== 32'h0) || (carryout !== 0) || (overflow !== 0)) $display("*** SUB %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `SUB; a = 32'h1; b = 32'h7fffffff; #5000
    $display("SUB %d %d ", a, b);
    if ((out !== 32'h80000002) || (carryout !== 0) || (overflow !== 0)) $display("*** SUB %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `SUB; a = 32'h0; b = 32'h7fffffff; #5000
    $display("SUB %d %d ", a, b);
    if ((out !== 32'h80000001) || (carryout !== 0) || (overflow !== 0)) $display("*** SUB %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `SUB; a = 32'h0; b = 32'h80000000; #5000
    $display("SUB %d %d ", a, b);
    if ((out !== 32'h80000000) || (carryout !== 0) || (overflow !== 1)) $display("*** SUB %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `XOR; a = 32'h1; b = 32'hffffffff; #5000
    $display("XOR %d %d ", a, b);
    if ((out !== 32'hfffffffe) || (carryout !== 0) || (overflow !== 0)) $display("*** XOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `XOR; a = 32'haaaaaaaa; b = 32'h55555555; #5000
    $display("XOR %d %d ", a, b);
    if ((out !== 32'hffffffff) || (carryout !== 0) || (overflow !== 0)) $display("*** XOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `XOR; a = 32'h0; b = 32'hffffffff; #5000
    $display("XOR %d %d ", a, b);
    if ((out !== 32'hffffffff) || (carryout !== 0) || (overflow !== 0)) $display("*** XOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `SLT; a = 32'h0; b = 32'h7fffffff; #5000
    $display("SLT %d %d ", a, b);
    if ((out !== 32'h1) || (carryout !== 0) || (overflow !== 0)) $display("*** SLT %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `SLT; a = 32'h0; b = 32'h80000000; #5000
    $display("SLT %d %d ", a, b);
    if ((out !== 32'h0) || (carryout !== 0) || (overflow !== 0)) $display("*** SLT %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `SLT; a = 32'h7fffffff; b = 32'h7fffffff; #5000
    $display("SLT %d %d ", a, b);
    if ((out !== 32'h0) || (carryout !== 0) || (overflow !== 0)) $display("*** SLT %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `AND; a = 32'hffffffff; b = 32'hffffffff; #5000
    $display("AND %d %d ", a, b);
    if ((out !== 32'hffffffff) || (carryout !== 0) || (overflow !== 0)) $display("*** AND %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `AND; a = 32'hffffffff; b = 32'h1; #5000
    $display("AND %d %d ", a, b);
    if ((out !== 32'h1) || (carryout !== 0) || (overflow !== 0)) $display("*** AND %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `AND; a = 32'h7fffffff; b = 32'h80000000; #5000
    $display("AND %d %d ", a, b);
    if ((out !== 32'h0) || (carryout !== 0) || (overflow !== 0)) $display("*** AND %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `NAND; a = 32'hffffffff; b = 32'hffffffff; #5000
    $display("NAND%d %d ", a, b);
    if ((out !== 32'h0) || (carryout !== 0) || (overflow !== 0)) $display("*** NAND %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `NAND; a = 32'h7fffffff; b = 32'h80000000; #5000
    $display("NAND%d %d ", a, b);
    if ((out !== 32'hffffffff) || (carryout !== 0) || (overflow !== 0)) $display("*** NAND %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `NAND; a = 32'h0; b = 32'h1; #5000
    $display("NAND%d %d ", a, b);
    if ((out !== 32'hffffffff) || (carryout !== 0) || (overflow !== 0)) $display("*** NAND %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `NOR; a = 32'hffffffff; b = 32'hffffffff; #5000
    $display("NOR %d %d ", a, b);
    if ((out !== 32'h0) || (carryout !== 0) || (overflow !== 0)) $display("*** NOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `NOR; a = 32'haaaaaaaa; b = 32'h1; #5000
    $display("NOR %d %d ", a, b);
    if ((out !== 32'h55555554) || (carryout !== 0) || (overflow !== 0)) $display("*** NOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `NOR; a = 32'h7fffffff; b = 32'h80000000; #5000
    $display("NOR %d %d ", a, b);
    if ((out !== 32'h0) || (carryout !== 0) || (overflow !== 0)) $display("*** NOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `OR; a = 32'hffffffff; b = 32'hffffffff; #5000
    $display("OR  %d %d ", a, b);
    if ((out !== 32'hffffffff) || (carryout !== 0) || (overflow !== 0)) $display("*** OR   %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `OR; a = 32'h7fffffff; b = 32'h80000000; #5000
    $display("OR  %d %d ", a, b);
    if ((out !== 32'hffffffff) || (carryout !== 0) || (overflow !== 0)) $display("*** OR   %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `OR; a = 32'haaaaaaaa; b = 32'h55555554; #5000
    $display("OR  %d %d ", a, b);
    if ((out !== 32'hfffffffe) || (carryout !== 0) || (overflow !== 0)) $display("*** OR   %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);


    /*** kaitlyn's test cases ***/

    address = `ADD; a = 32'h7fffffff; b = 32'h7fffffff; #5000
    $display("ADD %d %d ", a, b);
    if ((out !== 32'hfffffffe) || (carryout !== 0) || (overflow !== 1)) $display("*** ADD %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `ADD; a = -32'd10; b = 32'd10; #5000
    $display("ADD %d %d ", a, b);
    if ((out !== 32'd0) || (carryout !== 1) || (overflow !== 0)) $display("*** ADD %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `ADD; a = 32'h0000ffff; b = 32'hffff0000; #5000
    $display("ADD %d %d ", a, b);
    if ((out !== 32'hffffffff) || (carryout !== 0) || (overflow !== 0)) $display("*** ADD %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `SUB; a = 32'h0000ffff; b = -32'h0000ffff; #5000
    $display("SUB %d %d ", a, b);
    if ((out !== 32'h0001fffe) || (carryout !== 0) || (overflow !== 0)) $display("*** SUB %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `SUB; a = -32'h7fffffff; b = -32'h7fffffff; #5000
    $display("SUB %d %d ", a, b);
    if ((out !== 32'h0) || (carryout !== 1) || (overflow !== 0)) $display("*** SUB %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `SUB; a = 32'hffffffff; b = 32'h7fffffff; #5000
    $display("SUB %d %d ", a, b);
    if ((out !== 32'h80000000) || (carryout !== 1) || (overflow !== 0)) $display("*** SUB %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `XOR; a = 32'hffffffff; b = 32'hffffffff; #5000
    $display("XOR %d %d ", a, b);
    if ((out !== 32'h0) || (carryout !== 0) || (overflow !== 0)) $display("*** XOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `XOR; a = 32'hffff0000; b = 32'hffffffff; #5000
    $display("XOR %d %d ", a, b);
    if ((out !== 32'h0000ffff) || (carryout !== 0) || (overflow !== 0)) $display("*** XOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `XOR; a = 32'h11111111; b = 32'h0e0e0e0e; #5000
    $display("XOR %d %d ", a, b);
    if ((out !== 32'h1f1f1f1f) || (carryout !== 0) || (overflow !== 0)) $display("*** XOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `SLT; a = 32'h7fffffff; b = 32'h0; #5000
    $display("SLT %d %d ", a, b);
    if ((out !== 32'h0) || (carryout !== 0) || (overflow !== 0)) $display("*** SLT %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `SLT; a = 32'd0; b = 32'd5; #5000
    $display("SLT %d %d ", a, b);
    if ((out !== 32'h1) || (carryout !== 0) || (overflow !== 0)) $display("*** SLT %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `SLT; a = 32'd0; b = 32'd0; #5000
    $display("SLT %d %d ", a, b);
    if ((out !== 32'h0) || (carryout !== 0) || (overflow !== 0)) $display("*** SLT %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `AND; a = 32'h0f0f0f0f; b = 32'hf0f0f0f0; #5000
    $display("AND %d %d ", a, b);
    if ((out !== 32'h0) || (carryout !== 0) || (overflow !== 0)) $display("*** AND %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `AND; a = 32'h11111111; b = 32'hffffffff; #5000
    $display("AND %d %d ", a, b);
    if ((out !== 32'h11111111) || (carryout !== 0) || (overflow !== 0)) $display("*** AND %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `AND; a = 32'heeeeeeee; b = 32'h77777777; #5000
    $display("AND %d %d ", a, b);
    if ((out !== 32'h66666666) || (carryout !== 0) || (overflow !== 0)) $display("*** AND %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `NAND; a = 32'heeeeeeee; b = 32'h77777777; #5000
    $display("NAND%d %d ", a, b);
    if ((out !== 32'h99999999) || (carryout !== 0) || (overflow !== 0)) $display("*** NAND %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `NAND; a = 32'h11111111; b = 32'h10101010; #5000
    $display("NAND%d %d ", a, b);
    if ((out !== 32'hefefefef) || (carryout !== 0) || (overflow !== 0)) $display("*** NAND %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `NAND; a = 32'h77777777; b = 32'h88888888; #5000
    $display("NAND%d %d ", a, b);
    if ((out !== 32'hffffffff) || (carryout !== 0) || (overflow !== 0)) $display("*** NAND %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `NOR; a = 32'heeeeeeee; b = 32'h77777777; #5000
    $display("NOR %d %d ", a, b);
    if ((out !== 32'h0) || (carryout !== 0) || (overflow !== 0)) $display("*** NOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `NOR; a = 32'h0; b = 32'h77777777; #5000
    $display("NOR %d %d ", a, b);
    if ((out !== 32'h88888888) || (carryout !== 0) || (overflow !== 0)) $display("*** NOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `NOR; a = 32'heeeeeeee; b = 32'h00000001; #5000
    $display("NOR %d %d ", a, b);
    if ((out !== 32'h11111110) || (carryout !== 0) || (overflow !== 0)) $display("*** NOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `OR; a = 32'heeeeeeee; b = 32'h77777777; #5000
    $display("OR  %d %d ", a, b);
    if ((out !== 32'hffffffff) || (carryout !== 0) || (overflow !== 0)) $display("*** OR   %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `OR; a = 32'h0; b = 32'h77777777; #5000
    $display("OR  %d %d ", a, b);
    if ((out !== 32'h77777777) || (carryout !== 0) || (overflow !== 0)) $display("*** OR   %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    address = `OR; a = 32'heeeeeeee; b = 32'h00000001; #5000
    $display("OR  %d %d ", a, b);
    if ((out !== 32'heeeeeeef) || (carryout !== 0) || (overflow !== 0)) $display("*** OR   %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);
    
    end 
endmodule
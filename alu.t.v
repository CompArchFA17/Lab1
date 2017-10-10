`include "alu.v"
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
    reg[31:0] a,b;
    wire carryout, overflow, zero;
    wire[31:0] out;

    ALU alu(out, carryout, zero, overflow, a, b, address);

    initial begin 

    $dumpfile("alu.vcd");
    $dumpvars(0,alu);

	address = `SUB; a = 32'd10; b = 32'd10; #5000
    if ((out !== 32'd0) || (carryout !== 1) || (overflow !== 0)) $display("SUB %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);

    address = `ADD; a = 32'd10; b = 32'd10; #5000
    if ((out !== 32'd20) || (carryout !== 0) || (overflow !== 0)) $display("ADD %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);

    address = `XOR; a = 32'd10; b = 32'd10; #5000
    if ((out !== 32'd0) || (carryout !== 0) || (overflow !== 0)) $display("XOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);

   address = `SLT; a = 32'd15; b = 32'd10; #5000
   if ((out !== 32'd0) || (carryout !== 0) || (overflow !== 0)) $display("SLT %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);

    address = `AND; a = 32'd10; b = 32'd10; #5000
    if ((out !== 32'd10) || (carryout !== 0) || (overflow !== 0)) $display("AND %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);

    address = `NAND; a = 32'd10; b = 32'd10; #5000
    if ((out !== 32'hfffffff5) || (carryout !== 0) || (overflow !== 0)) $display("NAND %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);

    address = `NOR; a = 32'd10; b = 32'd10; #5000
    if ((out !== 32'hfffffff5) || (carryout !== 0) || (overflow !== 0)) $display("NOR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);

    address = `OR; a = 32'd10; b = 32'd10; #5000
    if ((out !== 32'd10) || (carryout !== 0) || (overflow !== 0)) $display("OR %d %d failed. out: %d carryout: %d overflow: %d", a, b, out, carryout, overflow);


    end 
endmodule
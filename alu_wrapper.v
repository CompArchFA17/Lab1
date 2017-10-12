`timescale 1ns / 1ps
`include "alu.v"


//--------------------------------------------------------------------------------
// Basic building block modules
//--------------------------------------------------------------------------------

// D flip-flop with parameterized bit width (default: 1-bit)
// Parameters in Verilog: http://www.asic-world.com/verilog/para_modules1.html
module dff #( parameter W = 1 )
(
    input trigger,
    input enable,
    input      [W-1:0] d,
    output reg [W-1:0] q
);
    always @(posedge trigger) begin
        if(enable) begin
            q <= d;
        end
    end
endmodule

// JK flip-flop
module jkff1
(
    input trigger,
    input j,
    input k,
    output reg q
);
    always @(posedge trigger) begin
        if(j && ~k) begin
            q <= 1'b1;
        end
        else if(k && ~j) begin
            q <= 1'b0;
        end
        else if(k && j) begin
            q <= ~q;
        end
    end
endmodule

// Two-input MUX with parameterized bit width (default: 1-bit)
module mux2 #( parameter W = 1 )
(
    input[W-1:0]    in0,
    input[W-1:0]    in1,
    input           sel,
    output[W-1:0]   out
);
    // Conditional operator - http://www.verilog.renerta.com/source/vrg00010.htm
    assign out = (sel) ? in1 : in0;
endmodule



module alu_wrapper
(
    input        clk,
    input  [3:0] sw,
    input  [3:0] btn,
    output [3:0] led
);

    wire[31:0] opA, opB;       // Stored inputs to ALU
    wire[31:0] res0;
    wire[3:0] res1;     // Output display options
    wire res_sel;             // Select between display options
    wire cout;                // Carry out from ALU
    wire ovf;                 // Overflow from ALU
    wire zero;                // Zero flag from ALU
   

    // Memory for stored operands (parametric width set to 4 bits)
    dff #(4) opA_mem(.trigger(clk), .enable(btn[0]), .d(sw), .q(opA[0 +:4]));
    dff #(4) opB_mem(.trigger(clk), .enable(btn[1]), .d(sw), .q(opB[0 +:4]));

    // Capture button input to switch which MUX input to LEDs
    jkff1 src_sel(.trigger(clk), .j(btn[3]), .k(btn[2]), .q(res_sel));
    mux2 #(4) output_select(.in0(res0[0 +:4]), .in1(res1), .sel(res_sel), .out(led));

    // TODO: You write this in your adder.v
    ALU alu(.result(res0), .carryout(cout), .zero(zero), .overflow(ovf), .operandA(opA), .operandB(opB));

    // Assign bits of second display output to show carry out and overflow
    assign res1[0] = cout;
    assign res1[1] = ovf;
    assign res1[2] = zero;
    assign res1[3] = 1'b0;

endmodule

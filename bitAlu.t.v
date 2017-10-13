`timescale 1 ns / 1 ps
`include "alu.v"

module testALUunit ();
    reg bitA, bitB, carryin, less, invertBFlag;
    reg[2:0] muxIndex;
    wire bitR;
    wire carryout;

    ALUunit alu (bitR, carryout, bitA, bitB, carryin, less, muxIndex, invertBFlag);

    initial begin
    $display("bitA bitB carryin less muxIndex invertBFlag | bitR carryout");
    bitA=1;bitB=1;carryin=0;less=0;muxIndex=`AND;invertBFlag=0; #3000
    $display("%b    %b    %b       %b    %b       %b          |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=1;bitB=0;carryin=0;less=0;muxIndex=`AND;invertBFlag=0; #3000
    $display("%b    %b    %b       %b    %b       %b          |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);

    end
endmodule

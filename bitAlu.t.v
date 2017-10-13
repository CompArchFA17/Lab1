`timescale 1 ns / 1 ps
`include "alu.v"

module testALUunit ();
    reg bitA, bitB, carryin, less, invertBFlag;
    reg[2:0] muxIndex;
    wire bitR;
    wire carryout;

    ALUunit alu (bitR, carryout, bitA, bitB, carryin, less, muxIndex, invertBFlag);

    initial begin
    $display("testing ADD");
    $display("bitA bitB carryin less muxIndex invertBFlag | bitR carryout");
    bitA=1;bitB=0;carryin=0;less=0;muxIndex=3'd0;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=0;bitB=0;carryin=0;less=0;muxIndex=3'd0;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=0;bitB=1;carryin=0;less=0;muxIndex=3'd0;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=1;bitB=1;carryin=0;less=0;muxIndex=3'd0;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=0;bitB=0;carryin=1;less=0;muxIndex=3'd0;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=1;bitB=0;carryin=1;less=0;muxIndex=3'd0;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=1;bitB=1;carryin=1;less=0;muxIndex=3'd0;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);

    $display("testing SUB");
    bitA=0;bitB=0;carryin=0;less=0;muxIndex=3'd0;invertBFlag=1; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=1;bitB=0;carryin=0;less=0;muxIndex=3'd0;invertBFlag=1; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=0;bitB=1;carryin=0;less=0;muxIndex=3'd0;invertBFlag=1; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=1;bitB=1;carryin=0;less=0;muxIndex=3'd0;invertBFlag=1; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=0;bitB=0;carryin=1;less=0;muxIndex=3'd0;invertBFlag=1; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=1;bitB=0;carryin=1;less=0;muxIndex=3'd0;invertBFlag=1; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=0;bitB=1;carryin=1;less=0;muxIndex=3'd0;invertBFlag=1; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=1;bitB=1;carryin=1;less=0;muxIndex=3'd0;invertBFlag=1; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);

    $display("testing XOR");
    bitA=0;bitB=0;carryin=0;less=0;muxIndex=3'd2;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=1;bitB=0;carryin=0;less=0;muxIndex=3'd2;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=0;bitB=1;carryin=0;less=0;muxIndex=3'd2;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=1;bitB=1;carryin=0;less=0;muxIndex=3'd2;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);

    $display("testing SLT");
    bitA=0;bitB=0;carryin=0;less=0;muxIndex=3'd3;invertBFlag=1; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=0;bitB=0;carryin=0;less=1;muxIndex=3'd3;invertBFlag=1; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);

    $display("testing AND");
    bitA=0;bitB=0;carryin=0;less=0;muxIndex=3'd4;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=1;bitB=0;carryin=0;less=0;muxIndex=3'd4;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=0;bitB=1;carryin=0;less=0;muxIndex=3'd4;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=1;bitB=1;carryin=0;less=0;muxIndex=3'd4;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);

    $display("testing NAND");
    bitA=0;bitB=0;carryin=0;less=0;muxIndex=3'd5;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=1;bitB=0;carryin=0;less=0;muxIndex=3'd5;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=0;bitB=1;carryin=0;less=0;muxIndex=3'd5;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=1;bitB=1;carryin=0;less=0;muxIndex=3'd5;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);

    $display("testing NOR");
    bitA=0;bitB=0;carryin=0;less=0;muxIndex=3'd6;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=1;bitB=0;carryin=0;less=0;muxIndex=3'd6;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=0;bitB=1;carryin=0;less=0;muxIndex=3'd6;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=1;bitB=1;carryin=0;less=0;muxIndex=3'd6;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);

    $display("testing OR");
    bitA=0;bitB=0;carryin=0;less=0;muxIndex=3'd7;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=1;bitB=0;carryin=0;less=0;muxIndex=3'd7;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=0;bitB=1;carryin=0;less=0;muxIndex=3'd7;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    bitA=1;bitB=1;carryin=0;less=0;muxIndex=3'd7;invertBFlag=0; #10000
    $display("%b  %b  %b  %b  %b  %b |  %b  %b", bitA, bitB, carryin, less, muxIndex, invertBFlag, bitR, carryout);
    end
endmodule

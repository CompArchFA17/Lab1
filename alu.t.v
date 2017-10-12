`include "ALU.v"
`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

module ALU_test();
  reg [31:0] A, B;
  reg [2:0] command;
  wire [31:0] result;
  wire carryout,zero,overflow;

  ALU ALU_full(result[31:0],carryout,zero,overflow,A[31:0],B[31:0],command[2:0]);

  reg [31:0] testAVals [11:0];
  reg [31:0] testBVals [11:0];
  reg [2:0] testcommand[11:0];
  reg [31:0] testresults [11:0];
  reg testcarryouts [11:0];
  reg testzero [11:0];
  reg testoverflow[11:0];

  task testALU;
    input expectedCarryout, expectedZero, expectedOverflow;
    input [31:0] a,b,expectedResult;
    input [2:0] MuxIndex;
    begin
      A=a; B=b; command=MuxIndex; #500
      if (result == expectedResult && carryout == expectedCarryout && overflow == expectedOverflow && zero == expectedZero)
        $display("Test succeeded");
      else if (result == expectedResult)
        $display("Output matches, unexpected flags for inputs %b and %b", a, b);
      else
        $display("Expected %b for inputs %b and %b, got %b.", carryout, a, b, result);
    end
  endtask

  reg i;

  initial begin

    testAVals[0] = 32'b0111111111111111; testBVals[0] = 32'h0001; testcommand[0] = `ADD; testresults[0] = 32'hFFFF; testoverflow[0] = 1; testzero[0]=0; testcarryouts[0]=1;

    testAVals[1] = 32'd100; testBVals[1] = 32'd475; testcommand[1] = `ADD; testresults[1] = 32'd575; testcarryouts[1] = 0; testzero[1]=0; testoverflow[1]=0;



    testAVals[2] = 32'h0FFF; testBVals[2] = 32'h00FF; testcommand[2] = `SUB; testresults[2] = 32'h0F00; testcarryouts[1] = 0; testzero[1]=0; testoverflow[2]=0;

    testAVals[3] = 32'h0000; testBVals[3] = 32'hFFFF; testcommand[3] = `SUB; testresults[3] = 32'h0000; testcarryouts[1] = 1; testzero[1]=0; testoverflow[3]=1;



    testAVals[4] = 32'h0F0F; testBVals[4] = 32'hF0FF; testcommand[4] = `XOR; testresults[4] = 32'hFFF0; testcarryouts[1] = 0; testzero[1]=0; testoverflow[4]=0;

    testAVals[5] = 32'hFFFF; testBVals[5] = 32'h00FF; testcommand[5] = `AND; testresults[5] = 32'h00FF; testcarryouts[1] = 0; testzero[1]=0; testoverflow[5]=0;

    testAVals[6] = 32'hFF00; testBVals[6] = 32'hFFF0; testcommand[6] = `NAND; testresults[6] = 32'h00FF; testcarryouts[1] = 0; testzero[1]=0; testoverflow[6]=0;

    testAVals[7] = 32'h00FF; testBVals[7] = 32'h0FFF; testcommand[7] = `NOR; testresults[7] = 32'hF000; testcarryouts[1] = 0; testzero[1]=0; testoverflow[7]=0;

    testAVals[8] = 32'h00FF; testBVals[8] = 32'h0F0F; testcommand[8] = `OR; testresults[8] = 32'h0FFF; testcarryouts[1] = 0; testzero[1]=0; testoverflow[8]=0;



    testAVals[9] = 32'd15422; testBVals[9] = 32'd15421; testcommand[9] = `SLT; testresults[9] = 32'b0000000000000001; testcarryouts[9] = 0; testzero[9]=0; testoverflow[9]=0;

    testAVals[10] = 32'd15422; testBVals[10] = 32'd15422; testcommand[10] = `SLT; testresults[10] = 32'h0000; testcarryouts[10] = 0; testzero[10]=1; testoverflow[10]=0;

    testAVals[11] = 32'd15422; testBVals[11] = 32'd15423; testcommand[11] = `SLT; testresults[11] = 32'h0000; testcarryouts[11] = 0; testzero[11]=0; testoverflow[11]=0;



    $display("  A  |  B  | command | result | carryout | zero | overflow");
    for (i = 0; i < 12; i = i + 1) begin
      testALU(testcarryin[i],testBinvert[i],testless[i],testAVals[i], testBVals[i], testresults[i], testcarryouts[i], testmuxindex[i]);
    end
  end
endmodule
`include "alu1bit.v"
`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

module alu1bit_test();
  reg A, B, carryin, Ainvert, Binvert, less;
  reg [2:0] muxindex;
  wire result,carryout;

  ALU1bit alu1bit(result,carryout,carryin,Ainvert,Binvert,less,A,B,muxindex[2:0]);

  reg testAVals [29:0];
  reg testBVals [29:0];
  reg testcarryin [29:0];
  reg testAinvert[29:0];
  reg testBinvert[29:0];
  reg testless[29:0];
  reg [2:0] testmuxindex[29:0];
  reg testresults [29:0];
  reg testcarryouts [29:0];

  task testALU;
    input cin,Ainv,Binv,Less,a, b, expectedOut, expectedOverflow;
    input [2:0] MuxIndex;
    begin
      A=a; B=b; carryin=cin; Ainvert=Ainv; Binvert=Binv;less=Less; muxindex=MuxIndex; #500
      if (result == expectedOut && carryout == expectedOverflow)
        $display("Test succeeded");
      else if (result == expectedOut && carryout)
        $display("Output matches, unexpected overflow for inputs %b and %b", a, b);
      else
        $display("Expected %b for inputs %b and %b, got %b.", carryout, a, b, result);
    end
  endtask

  reg i;

  initial begin

    testAVals[0] = 0; testBVals[0] = 0; testcarryin[0] = 0; testAinvert[0]=0; testBinvert[0] = 0; testless[0] = 0; testmuxindex[0] = `ADD; testresults[0] = 0; testcarryouts[0] = 0;

    testAVals[1] = 0; testBVals[1] = 1; testcarryin[1] = 0; testAinvert[1]=0; testBinvert[1] = 0; testless[1] = 0; testmuxindex[1] = `ADD; testresults[1] = 1; testcarryouts[1] = 0;

    testAVals[2] = 1; testBVals[2] = 1; testcarryin[2] = 0; testAinvert[2]=0; testBinvert[2] = 0; testless[2] = 0; testmuxindex[2] = `ADD; testresults[2] = 0; testcarryouts[2] = 1;

    testAVals[3] = 1; testBVals[3] = 1; testcarryin[3] = 1; testAinvert[3]=0; testBinvert[3] = 0; testless[3] = 0; testmuxindex[3] = `ADD; testresults[3] = 1; testcarryouts[3] = 1;



    testAVals[4] = 0; testBVals[4] = 0; testcarryin[4] = 1; testAinvert[4]=0; testBinvert[4] = 1; testless[4] = 0; testmuxindex[4] = `SUB; testresults[4] = 0; testcarryouts[4] = 0;

    testAVals[5] = 1; testBVals[5] = 0; testcarryin[5] = 1; testAinvert[5]=0; testBinvert[5] = 1; testless[5] = 0; testmuxindex[5] = `SUB; testresults[5] = 1; testcarryouts[5] = 0;

    testAVals[6] = 0; testBVals[6] = 1; testcarryin[6] = 1; testAinvert[6]=0; testBinvert[6] = 1; testless[6] = 0; testmuxindex[6] = `SUB; testresults[6] = 0; testcarryouts[6] = 1;

    testAVals[7] = 1; testBVals[7] = 1; testcarryin[7] = 1; testAinvert[7]=0; testBinvert[7] = 1; testless[7] = 0; testmuxindex[7] = `SUB; testresults[7] = 0; testcarryouts[7] = 0;



    testAVals[8] = 0; testBVals[8] = 0; testcarryin[8] = 0; testAinvert[8]=0; testBinvert[8] = 0; testless[8] = 0; testmuxindex[8] = `XOR; testresults[8] = 0; testcarryouts[8] = 0;

    testAVals[9] = 0; testBVals[9] = 1; testcarryin[9] = 0; testAinvert[9]=0; testBinvert[9] = 0; testless[9] = 0; testmuxindex[9] = `XOR; testresults[9] = 1; testcarryouts[9] = 0;

    testAVals[10] = 1; testBVals[10] = 0; testcarryin[10] = 0; testAinvert[10]=0; testBinvert[10] = 0; testless[10] = 0; testmuxindex[10] = `XOR; testresults[10] = 1; testcarryouts[10] = 0;

    testAVals[11] = 1; testBVals[11] = 1; testcarryin[11] = 0; testAinvert[11]=0; testBinvert[11] = 0; testless[11] = 0; testmuxindex[11] = `XOR; testresults[11] = 0; testcarryouts[11] = 0;



    testAVals[12] = 1; testBVals[12] = 1; testcarryin[12] = 1; testAinvert[12]=0; testBinvert[12] = 0; testless[12] = 0; testmuxindex[12] = `SLT; testresults[12] = 0; testcarryouts[12] = 0;

    testAVals[13] = 0; testBVals[13] = 0; testcarryin[13] = 0; testAinvert[13]=0; testBinvert[13] = 0; testless[13] = 1; testmuxindex[13] = `SLT; testresults[13] = 1; testcarryouts[13] = 0;



    testAVals[14] = 0; testBVals[14] = 0; testcarryin[14] = 0; testAinvert[14]=0; testBinvert[14] = 0; testless[14] = 0; testmuxindex[14] = `AND; testresults[14] = 0; testcarryouts[14] = 0;

    testAVals[15] = 0; testBVals[15] = 1; testcarryin[15] = 0; testAinvert[15]=0; testBinvert[15] = 0; testless[15] = 0; testmuxindex[15] = `AND; testresults[15] = 0; testcarryouts[15] = 0;

    testAVals[14] = 1; testBVals[16] = 0; testcarryin[16] = 0; testAinvert[16]=0; testBinvert[16] = 0; testless[16] = 0; testmuxindex[16] = `AND; testresults[16] = 0; testcarryouts[16] = 0;

    testAVals[17] = 1; testBVals[17] = 1; testcarryin[17] = 0; testAinvert[17]=0; testBinvert[17] = 0; testless[17] = 0; testmuxindex[17] = `AND; testresults[17] = 1; testcarryouts[17] = 0;



    testAVals[18] = 0; testBVals[18] = 0; testcarryin[18] = 0; testAinvert[18]=1; testBinvert[18] = 0; testless[18] = 0; testmuxindex[18] = `NAND; testresults[18] = 1; testcarryouts[18] = 0;

    testAVals[19] = 0; testBVals[19] = 1; testcarryin[19] = 0; testAinvert[19]=1; testBinvert[19] = 0; testless[19] = 0; testmuxindex[19] = `NAND; testresults[19] = 1; testcarryouts[19] = 0;

    testAVals[20] = 1; testBVals[20] = 0; testcarryin[20] = 0; testAinvert[20]=1; testBinvert[20] = 0; testless[20] = 0; testmuxindex[20] = `NAND; testresults[20] = 1; testcarryouts[20] = 0;

    testAVals[21] = 1; testBVals[21] = 1; testcarryin[21] = 0; testAinvert[21]=1; testBinvert[21] = 0; testless[21] = 0; testmuxindex[21] = `NAND; testresults[21] = 0; testcarryouts[21] = 0;



    testAVals[22] = 0; testBVals[22] = 0; testcarryin[22] = 0; testAinvert[22]=1; testBinvert[22] = 0; testless[22] = 0; testmuxindex[22] = `NOR; testresults[22] = 1; testcarryouts[22] = 0;

    testAVals[23] = 0; testBVals[23] = 1; testcarryin[23] = 0; testAinvert[23]=1; testBinvert[23] = 0; testless[23] = 0; testmuxindex[23] = `NOR; testresults[23] = 0; testcarryouts[23] = 0;

    testAVals[24] = 1; testBVals[24] = 0; testcarryin[24] = 0; testAinvert[24]=1; testBinvert[24] = 0; testless[24] = 0; testmuxindex[24] = `NOR; testresults[24] = 0; testcarryouts[24] = 0;

    testAVals[25] = 1; testBVals[25] = 1; testcarryin[25] = 0; testAinvert[25]=1; testBinvert[25] = 0; testless[25] = 0; testmuxindex[25] = `NOR; testresults[25] = 0; testcarryouts[25] = 0;



    testAVals[26] = 0; testBVals[26] = 0; testcarryin[26] = 0; testAinvert[26]=0; testBinvert[26] = 0; testless[26] = 0; testmuxindex[26] = `OR; testresults[26] = 0; testcarryouts[26] = 0;

    testAVals[27] = 0; testBVals[27] = 1; testcarryin[27] = 0; testAinvert[27]=0; testBinvert[27] = 0; testless[27] = 0; testmuxindex[27] = `OR; testresults[27] = 1; testcarryouts[27] = 0;

    testAVals[28] = 1; testBVals[28] = 0; testcarryin[28] = 0; testAinvert[28]=0; testBinvert[28] = 0; testless[28] = 0; testmuxindex[28] = `OR; testresults[28] = 1; testcarryouts[28] = 0;

    testAVals[29] = 1; testBVals[29] = 1; testcarryin[29] = 0; testAinvert[29]=0; testBinvert[29] = 0; testless[29] = 0; testmuxindex[29] = `OR; testresults[29] = 1; testcarryouts[29] = 0;



    $display("  A  |  B  |  carryin  | Ainvert | Binvert | less | muxindex | result | carryout ");
    for (i = 0; i < 16; i = i + 1) begin
      testALU(testcarryin[i],testBinvert[i],testless[i],testAVals[i], testBVals[i], testresults[i], testcarryouts[i], testmuxindex[i]);
    end
  end
endmodule
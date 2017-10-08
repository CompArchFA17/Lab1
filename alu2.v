`define AND and #20     // nand with nor is 20 
`define NAND nand #10   // base is 10
`define NOT not #10     // not base is 10
`define OR or #20       // nor with not is 20
`define NOR nor #10     // base is 10 
`define XOR xor #40     // and with or is 40

module TwoInMux
(
    output outfinal,
    input S,
    input in0, in1
);   
    wire nS; 
    wire out0; 
    wire out1; 

    //`NOT Sinv(nS, S);   
    //`NAND n0(out0, S, in0);
    //`NAND n1(out1, nS, in1);
    //`NAND n2(outfinal, out0, out1);  // final output of mux

    `NOT Sinv(nS, S);   
                `AND andgate1(out0, in0, nS);
    `AND andgate3(out1, in1, S);
                `OR orgate(outfinal, out0, out1);
endmodule

module FourInMux
(
    output out,
    input S0, S1,
    input in0, in1, in2, in3
);
    wire nS0; 
    wire nS1; 

    wire out0; 
    wire out1; 
    wire out2; 
    wire out3; 

    `NOT S0inv(nS0, S0);
    `NOT S1inv(nS1, S1);
    `NAND n0(out0, nS0, nS1, in0);
    `NAND n1(out1, S0,  nS1, in1);
    `NAND n2(out2, nS0, S1, in2);
    `NAND n3(out3, S0,  S1, in3);

    `NAND addthem(out, out0, out1, out2, out3);
endmodule

module AndNand
(
output AndNandOut, 
input A, B, 
input[2:0] Command

);

wire AnandB;
wire AandB;

                `NAND n0(AnandB, A, B);
                `NOT Ainv(AandB, AnandB);
                TwoInMux potato(AndNandOut, Command[0], AandB, AnandB);    // order to follow out,S,in0, in1

endmodule

module OrNorXor
(
output OrNorXorOut,
input A, B,
input[2:0] Command
);
wire AnorB;
wire AorB;
wire AnandB;
wire nXor;
wire AxorB;
wire XorNor;

                `NOR nor0(AnorB, A, B);
                `NOT n0(AorB, AnorB);
                `NAND and0(AnandB, A, B);
                `NAND and1(nXor, AnandB, AorB);
                `NOT n1(AxorB, nXor);

                TwoInMux mux0(XorNor, Command[2], AxorB, AnorB);
                TwoInMux mux1(OrNorXorOut, Command[0], XorNor, AorB);
endmodule

module ZerothAddSubSLT
(
output AddSubSLTSum, carryout, //overflow, 
input A, B,
input[2:0] Command
//input carryin  
);
                wire nB;
                wire BornB;
                wire AxorB;
                wire AandB;
                wire CINandAxorB;
                
                `NOT Binv(nB, B);
                TwoInMux mux0(BornB, Command[0], B, nB); 
                `XOR XOR1(AxorB, A, BornB); 
                `XOR XOR2(AddSubSLTSum, AxorB, Command[0]); 
                `AND AND1(AandB, A, BornB); 
                `AND AND2(CINandAxorB, AxorB, Command[0]);
                `OR OR1(carryout, AandB, CINandAxorB); 
endmodule

module MiddleAddSubSLT
(
output AddSubSLTSum, carryout, //overflow, 
output subtract, 
input A, B,
input[2:0] Command, 
input carryin  
);
                wire nB;
                wire BornB;
                wire AxorB;
                wire AandB;
                wire CINandAxorB;
                wire nCmd2;
                
                `NOT Binv(nB, B);
                TwoInMux mux0(BornB, Command[0], B, nB); 
                `NOT n0(nCmd2, Command[2]);
                `AND subtractchoose(subtract, Command[0], nCmd2); 
                `XOR XOR1(AxorB, A, BornB); 
                `XOR XOR2(AddSubSLTSum, AxorB, carryin); 
                `AND AND1(AandB, A, BornB); 
                `AND AND2(CINandAxorB, AxorB, carryin);
                `OR OR1(carryout, AandB, CINandAxorB); 
endmodule

module LastAddSubSLT
(
output AddSubSLTSum, carryout, overflow, 
input A, B,
input[2:0] Command, 
input carryin  
);
                wire nB;
                wire BornB;
                wire AxorB;
                wire AandB;
                wire CINandAxorB;
                
                `NOT Binv(nB, B);
                TwoInMux mux0(BornB, Command[0], B, nB); 
                `XOR XOR1(AxorB, A, BornB); 
                `XOR XOR2(AddSubSLTSum, AxorB, carryin); 
                `AND AND1(AandB, A, BornB); 
                `AND AND2(CINandAxorB, AxorB, carryin);
                `OR OR1(carryout, AandB, CINandAxorB); 
                `XOR xor3(overflow, carryout, carryin);
endmodule

module Bitslice
(
output OneBitFinalOut, 
output AddSubSLTSum, carryout, //overflow, 
output OrNorXorOut,
output AndNandOut,
output subtract,
input A, B, 
input[2:0] Command,
input carryin

);
                wire Cmd0Start;
                wire Cmd1Start;               
                wire nB;
                wire BornB;
                wire AxorB;
                wire AandB;
                wire CINandAxorB;

                wire AnorB;
                wire AorB;
                wire AnandB;
                wire nXor;
                wire XorNor;
                
                MiddleAddSubSLT rottenpotato(AddSumSLTSum, carryout, subtract, A, B, Command, carryin); 
                OrNorXor idahopotato(OrNorXorOut, A, B, Command);
                AndNand sweetpotato(AndNandOut, A, B, Command);

                FourInMux ZeroMux(Cmd0Start, Command[0], Command[1], AddSumSLTSum, AddSumSLTSum, OrNorXorOut, AddSumSLTSum);
                FourInMux OneMux(Cmd1Start, Command[0], Command[1], AndNandOut, AndNandOut, OrNorXorOut, OrNorXorOut);
                TwoInMux TwoMux(OneBitFinalOut, Command[2], Cmd0Start, Cmd1Start);
endmodule 

module AddSubSLT32
(
output [size-1:0]AddSubSLTSum, 
output carryout,      
output overflow, 
output SLTflag,
output [size-1:0]subtract, 
input [size-1:0] A, B, 
input [2:0] Command,
input [size-1:0]carryin  // we think this doesn't do anything but don't want to break everything
);
                wire [size-1:0] CarryoutWire;
	wire SLTon;
                
                MiddleAddSubSLT attempt2(AddSubSLTSum[0], CarryoutWire[0], subtract[0], A[0], B[0], Command, subtract[0]);
                
                genvar i; 
                parameter size = 4; 
                generate 
                for (i=1; i<size; i=i+1)
                     begin: addbits
                     MiddleAddSubSLT attempt(AddSubSLTSum[i], CarryoutWire[i], subtract[i], A[i], B[i], Command, CarryoutWire[i-1]); 
                     end        
                endgenerate 
	
	//set carryout = carryoutwire[size-1]
	`OR finalcarryout(carryout, CarryoutWire[size-1], 0);

	`XOR overflowcheck(overflow, carryout, CarryoutWire[size-2]);

	`AND sltcheck0(SLTon, Command[1], subtract[0]);
	`AND sltcheck1(SLTflag, SLTon, AddSubSLTSum[size-1]);
endmodule


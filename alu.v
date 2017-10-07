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
input[2:0] Command, 
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


module BitSlice
(


);


endmodule 





//final 32-bit ALU

`include "adder_subtracter.v"
`include "slt.v" 

module ALUcontrolLUT //Ben Hill's code
(
	output reg	[31:0]controlsignal, //final 32-bit output
	output cout, //addsub only
	output flag, //addsub only
	output [31:0]finalsignal,
	input [2:0]ALUcommand,
	input [31:0]a,
	input [31:0]b,
	input [31:0]xorin, //placeholders
	input [31:0]andin,
	input [31:0]nandin,
	input [31:0]norin,
	input [31:0]orin

);
adder_subtracter addsub0([31:0]addsub,cout,flag,[31:0]a,[31:0]b,[2:0]ALUcommand);
full_slt_32bit slt0=([31:0]slt,[31:0]a,[31:0]b);


  always @(ALUcommand) 
  	begin
    case (ALUcommand==[0,0,0])
    	controlsignal==addsub;
  	endcase
  	case (ALUcommand==[0,0,1])
    	controlsignal==addsub;
  	endcase
    case (ALUcommand==[0,1,0])
    	controlsignal==xor;
  	endcase
    case (ALUcommand==[0,1,1])
    	controlsignal==slt;
  	endcase
  	case (ALUcommand==[1,0,0])
    	controlsignal==and;
  	endcase
  	case (ALUcommand==[1,0,1])
    	controlsignal==nand;
  	endcase
  	case (ALUcommand==[1,1,0])
    	controlsignal==nor;
  	endcase
  	case (ALUcommand==[1,0,0])
    	controlsignal==or;
  	endcase
endmodule

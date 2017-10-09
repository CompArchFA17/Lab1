
module testMultiplexer ();
wire AndNandOut;
reg A, B;
reg[2:0] Command;
//reg S;
wire OneBitFinalOut;
wire AddSubSLTSum, carryout, subtract; //overflow, 
reg carryin;
wire OrNorXorOut;

	//wire muxout;
    //reg S0, S1;
    //reg in0, in1, in2, in3;

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

	MiddleAddSubSLT testadd(AddSubSLTSum, carryout, subtract, A, B, Command, carryin);

    AndNand newpotato(AndNandOut, A, B, Command); 

	OrNorXor ortest(OrNorXorOut, A, B, Command);

	Bitslice yukongoldpotato(OneBitFinalOut, AddSubSLTSum, carryout, OrNorXorOut, AndNandOut, subtract, A, B, Command, carryin);


//FourInMux arbitrarypotato(muxout, S0, S1, in0, in1, in2, in3);

initial begin

// just the adder - proper behavior
	$display("Adder/Subtractor");
    $display("A B| Command |  Output | Expected Output");
    A=1;B=1;Command=3'b000; carryin = 0; #1000 
    $display("%b  %b |   %b |  %b | 0 | %b", A, B, Command, AddSubSLTSum, carryout);
    A=1;B=0;Command=3'b000; carryin = 0; #1000 
    $display("%b  %b |   %b |  %b | 1 | %b", A, B, Command, AddSubSLTSum, carryout);
    A=0;B=1;Command=3'b000; carryin = 0; #1000 
    $display("%b  %b |   %b |  %b | 1 | %b", A, B, Command, AddSubSLTSum, carryout);   					 
	A=0;B=0;Command=3'b000; carryin = 0; #1000 
    $display("%b  %b |   %b |  %b | 0 | %b", A, B, Command, AddSubSLTSum, carryout);	
    A=1;B=1;Command=3'b001; carryin = 1; #1000 
    $display("%b  %b |   %b |  %b | 0 | %b", A, B, Command, AddSubSLTSum, carryout);

// testing subtraction
	$display("One Bitslice Adder/Subtractor");
    $display("A B| Command |Out|ExOut|Carryout");
    A=1;B=1;Command=3'b000; carryin=0; #1000 
    $display("%b  %b |   %b |  %b | 0 | %b", A, B, Command, OneBitFinalOut,  carryout);
    A=1;B=0;Command=3'b000; carryin=0; #1000 
    $display("%b  %b |   %b |  %b | 1 | %b", A, B, Command, OneBitFinalOut,  carryout);
    A=0;B=0;Command=3'b000; carryin=0; #1000 
    $display("%b  %b |   %b |  %b | 0 | %b", A, B, Command, OneBitFinalOut,  carryout);

    A=1;B=1;Command=3'b001; carryin=1; #1000 
    $display("%b  %b |   %b |  %b | 0 | %b", A, B, Command, OneBitFinalOut,  carryout);
    A=1;B=0;Command=3'b001; carryin=1; #1000 
    $display("%b  %b |   %b |  %b | 1 | %b", A, B, Command, OneBitFinalOut,  carryout);
    A=0;B=0;Command=3'b001; carryin=1; #1000 
    $display("%b  %b |   %b |  %b | 0 | %b", A, B, Command, OneBitFinalOut,  carryout);


    //$display("A B| Command |  Output | Expected Output- pure sadness");
    //S0 = 1; S1 = 0; in0 = 1; in1 = 1; in2 = 0; in3 = 0; #1000 
    //$display("%b  %b | %b %b %b %b |  %b | 1", S0, S1, in0, in1, in2, in3, muxout);

// testing addition
    $display("A B| Command |  Output | Expected Output-sadness|Carryout");
    A=1;B=1;Command=3'b000; carryin=0; #1000 
    $display("%b  %b |   %b |  %b | 0 | %b", A, B, Command, OneBitFinalOut,  carryout);
    A=1;B=0;Command=3'b000; carryin=0; #1000 
    $display("%b  %b |   %b |  %b | 1 | %b", A, B, Command, OneBitFinalOut,  carryout);
    A=0;B=0;Command=3'b000; carryin=0; #1000 
    $display("%b  %b |   %b |  %b | 0 | %b", A, B, Command, OneBitFinalOut,  carryout);


// Exhaustively testing AND/NAND 
    $display("A B| Command | command0 Output | Expected Output - AND TESTS");
    A=1;B=1;Command=3'b000; #1000 
    $display("%b  %b |   %b |  %b  %b | 1", A, B, Command, Command[0], AndNandOut);
    A=1;B=1;Command=3'b001; #1000 
    $display("%b  %b |   %b |  %b  %b | 0", A, B, Command, Command[1], AndNandOut);
    A=0;B=1;Command=3'b000; #1000 
    $display("%b  %b |   %b |  %b  %b | 0", A, B, Command, Command[0], AndNandOut);
    A=1;B=0;Command=3'b001; #1000 
    $display("%b  %b |   %b |  %b  %b | 1", A, B, Command, Command[1], AndNandOut);


// Exhaustively testing OR/NOR/XOR
    $display("A B | Command | Output | Expected Output - OR TESTS");
	A=1; B=1; Command=3'b111; #1000
	$display("%b %b |    %b  |  %b   | 1 - OR TEST", A, B, Command, OrNorXorOut);
	A=1; B=0; Command=3'b111; #1000
	$display("%b %b |    %b  |  %b   | 1 - OR TEST", A, B, Command, OrNorXorOut);
	A=0; B=1; Command=3'b111; #1000
	$display("%b %b |    %b  |  %b   | 1 - OR TEST", A, B, Command, OrNorXorOut);
	A=0; B=0; Command=3'b111; #1000
	$display("%b %b |    %b  |  %b   | 0 - OR TEST", A, B, Command, OrNorXorOut);


	A=1; B=1; Command=3'b110; #1000
	$display("%b %b |    %b  |  %b   | 0 - NOR TEST", A, B, Command, OrNorXorOut);
	A=1; B=0; Command=3'b110; #1000
	$display("%b %b |    %b  |  %b   | 0 - NOR TEST", A, B, Command, OrNorXorOut);
	A=0; B=1; Command=3'b110; #1000
	$display("%b %b |    %b  |  %b   | 0 - NOR TEST", A, B, Command, OrNorXorOut);
	A=0; B=0; Command=3'b110; #1000
	$display("%b %b |    %b  |  %b   | 1 - NOR TEST", A, B, Command, OrNorXorOut);

	A=1; B=1; Command=3'b010; #1000
	$display("%b %b |    %b  |  %b   | 0 - XOR TEST", A, B, Command, OrNorXorOut);
	A=1; B=0; Command=3'b010; #1000
	$display("%b %b |    %b  |  %b   | 1 - XOR TEST", A, B, Command, OrNorXorOut);
	A=0; B=1; Command=3'b010; #1000
	$display("%b %b |    %b  |  %b   | 1 - XOR TEST", A, B, Command, OrNorXorOut);
	A=0; B=0; Command=3'b010; #1000
	$display("%b %b |    %b  |  %b   | 0 - XOR TEST", A, B, Command, OrNorXorOut);

    end


endmodule

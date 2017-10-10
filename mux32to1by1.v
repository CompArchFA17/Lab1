// 32 bit mux
module mux32to1by1
(
output      out,
input[4:0]  address,
input[31:0] inputs
);
  assign out = inputs[address];
endmodule


// 32x32bit mux
module mux32to1by32
(
output[31:0]  out,
input[4:0]    address,
input[31:0]   inputs
);

  wire[31:0] mux[31:0];			// Create a 2D array of wires
  assign mux[0] = inputs[0];		// Connect the sources of the array
  for (i=0;i<32;i=i+1) begin
  	mux[i]=inputs[i];
  end
  assign out = mux[address];	// Connect the output of the array
endmodule


// 32 bit decoder
module decoder1to32
(
output[31:0]  out,
input         enable,
input[4:0]    address
);
    assign out = enable<<address; 
endmodule
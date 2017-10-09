// Multiplexer testbench
`timescale 1 ns / 1 ps
`include "alu1bit.v"

module testMultiplexer ();
  reg[2:0] address;
  reg[7:0] inputs;
  wire out;

  //behavioralMultiplexer mux(out, addr0, addr1, in0, in1, in2, in3);
  behavioralMultiplexer mux(out, address, inputs);

  initial begin
    $display("address | inputs   | Out | Expected Output");
    inputs=8'b00000001;address=3'b000; #1000
    $display("%b     | %b | %b   | %b", address, inputs, out, 1);
    inputs=8'b00000100;address=3'b010; #1000
    $display("%b     | %b | %b   | %b", address, inputs, out, 1);
    inputs=8'b10000000;address=3'b111; #1000
    $display("%b     | %b | %b   | %b", address, inputs, out, 1);
    inputs=8'b01000000;address=3'b110; #1000
    $display("%b     | %b | %b   | %b", address, inputs, out, 1);
  end
endmodule

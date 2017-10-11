// MUX testbench
`timescale 1 ns / 1 ps
`include "mux.v"

module testMUX();
  reg a, b, c, d;
  reg s0, s1;
  wire out;

  reg[4:0] i;
  reg[2:0] sel;
  reg err;

  multiplexer mux (out, a, b, c, d, s1, s0);

initial begin
  err = 0;
  for (sel=0; sel<3'b100; sel=sel+1)
  begin
    s0=sel[0];
    s1=sel[1];
    for (i=0; i<5'b10000; i=i+1)
    begin
      a=i[3]; b=i[2]; c=i[1]; d=i[0];
      #1000
      //if (1)
      if (out^i[sel])
      begin
        $display("failed case input: %b, select: %b, output: %b", i[3:0], sel[1:0], out);
        err = 1;
      end
    end
  end
  if (~err)
  begin
    $display("all tests passed");
  end
end
endmodule

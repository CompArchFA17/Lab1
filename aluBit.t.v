// Test bench for bitslice of ALU without MUX

`timescale 1 ns / 1 ps
`include "aluBit.v"

module testBitslice();
  reg a, b, c, i0;
  reg[4:0] i;
  wire sumXOR, carryAND, nab, orNOR;
  wire val;
  reg[4:0] count;

  aluBit bitslice (sumXOR, carryAND, nab, orNOR, a, b, c, i0);

initial begin
  count = 0;
  i = 5'b00000;
  for (i=5'b00000; i<5'b10000; i=i+1)
  begin
    a = i[0];
    b = i[1];
    c = i[2];
    i0 = i[3];
    #1000
    if ((sumXOR^(a^b))&~c)
    begin
      $display("failed xor: a b c i0 result");
      $display("            %b %b %b  %b   %b", a, b, c, i0, sumXOR);
    end
    else if ((carryAND^(a&b))&~c)
    begin
      $display("failed and: a b c i0 result");
      $display("            %b %b %b  %b   %b", a, b, c, i0, carryAND);
    end
    else if (nab^(a~&b))
    begin
      $display("failed nand: a b c i0 result");
      $display("             %b %b %b  %b   %b", a, b, c, i0, nab);
    end
    else if ((orNOR^(a~|b))&~i0)
    begin
      $display("failed nor: a b c i0 result");
      $display("            %b %b %b  %b   %b", a, b, c, i0, orNOR);
    end
    else if ((orNOR^(a|b))&i0)
    begin
      $display("failed or: a b c i0 result");
      $display("            %b %b %b  %b   %b", a, b, c, i0, orNOR);
    end
    else if (sumXOR^(a^b^c))
    begin
      $display("failed sum: a b c i0 result");
      $display("            %b %b %b  %b   %b", a, b, c, i0, sumXOR);
    end
    else if (carryAND^((a&b)|(a&c)|(b&c)))
    begin
      $display("failed carry: a b c i0 result");
      $display("              %b %b %b  %b   %b", a, b, c, i0, carryAND);
    end
    else
    begin
      count = count + 1;
    end
  end
  $display("all tests passed for %d cases", count);
end
endmodule

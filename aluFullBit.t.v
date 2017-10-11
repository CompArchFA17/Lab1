// Full BitSlice testbench
`timescale 1 ns / 1 ps
`include "aluFullBit.v"

`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

module testFullBit();
  reg a, b, c, i0;
  reg[3:0] in;
  reg s0, s1;
  wire out, carry;

  reg[4:0] i;
  reg[1:0] sel;
  reg err;
  reg tmp_s0;
  reg tmp_s1;

  aluFullBit aluSlice  (out, carry, a, b, c, i0, {s1, s0});

initial begin
  err = 0;
  for (in=0; in<4'b1000; in=in+1)
  begin
    tmp_s0 = in[1]|in[0];
    tmp_s1 = ~in[1];
    s0 = tmp_s0~&in[2];
    s1 = tmp_s1~&in[2];
    sel = {s1, s0};
    for (i=0; i<5'b10000; i=i+1)
    begin
      a=i[3]; b=i[2]; c=i[1]; i0=in[0];
      #10000
      case (in[2:0])
        `ADD:
        begin
          if (out^(a^b^c))
          begin
            $display("failed sum: a b c i0 sel result");
            $display("            %b %b %b  %b  %b   %b", a, b, c, i0, sel, out);
            err = 1;
          end
          if (carry^((a&b)|(a&c)|(b&c)))
          begin
            $display("failed carry: a b c i0 sel result");
            $display("              %b %b %b  %b  %b   %b", a, b, c, i0, sel, out);
            err = 1;
          end
        end
        `SUB: begin end
        `XOR:
        begin
          if ((out^(a^b))&~c)
          begin
            $display("failed xor: a b c i0 sel result");
            $display("            %b %b %b  %b  %b   %b", a, b, c, i0, sel, out);
            err = 1;
          end
        end
        `SLT: begin end
        `AND:
        begin
          if ((out^(a&b))&~c)
          begin
            $display("failed and: a b c i0 sel result");
            $display("            %b %b %b  %b  %b   %b", a, b, c, i0, sel, out);
            err = 1;
          end
        end
        `NAND:
        begin
          if (out^(a~&b))
          begin
            $display("failed nand: a b c i0 sel result");
            $display("             %b %b %b  %b  %b   %b", a, b, c, i0, sel, out);
            err = 1;
          end
        end
        `NOR:
        begin
          if (out^(a~|b))
          begin
            $display("failed nor: a b c i0 sel result");
            $display("            %b %b %b  %b  %b   %b", a, b, c, i0, sel, out);
            err = 1;
          end
        end
        `OR:
        begin
          if (out^(a|b))
          begin
            $display("failed or: a b c i0 sel result");
            $display("           %b %b %b  %b  %b   %b", a, b, c, i0, sel, out);
            err = 1;
          end
        end
      endcase
    end
  end
  if (~err)
  begin
    $display("all tests passed");
  end
end
endmodule     

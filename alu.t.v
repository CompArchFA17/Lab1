module ALUcontrolLUT
(
output reg[2:0] 	muxindex,
output reg	invertB,
output reg	othercontrolsignal,
...
input[2:0]	ALUcommand
)

  always @(ALUcommand) begin
    case (ALUcommand)
      `ADD:  begin muxindex = 0; invertB=0; othercontrolsignal = ?; end    
      `SUB:  begin muxindex = 0; invertB=1; othercontrolsignal = ?; end
      `XOR:  begin muxindex = 1; invertB=0; othercontrolsignal = ?; end    
      `SLT:  begin muxindex = 2; invertB=?; othercontrolsignal = ?; end
      `AND:  begin muxindex = 3; invertB=?; othercontrolsignal = ?; end    
      `NAND: begin muxindex = 3; invertB=?; othercontrolsignal = ?; end
      `NOR:  begin muxindex = ?; invertB=?; othercontrolsignal = ?; end    
      `OR:   begin muxindex = ?; invertB=?; othercontrolsignal = ?; end
    endcase
  end
endmodule
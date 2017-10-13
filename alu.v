`include "alu1.v"
module ALU(
output[31:0]  result,
output        carryout,
output        zero,
output        overflow,
input[31:0]   operandA,
input[31:0]   operandB,
input[2:0]    command
);
    wire[32:0] carryinbus;
    wire[31:0] zerobus;
    wire[31:0] overrideBus;
    wire[31:0] resultBus;
    wire mixedSigns;
    wire sameSigns;
    wire possibleOverflow;
    wire sltPre;
    wire flagsEnable;
    wire carryoutint, overflowint;
   

    reg[7:0] commandslice;
    always @(command) begin
      case (command)
      0:  begin commandslice = 1<<0; end
      1:  begin commandslice = 1<<1; end
      2:  begin commandslice = 1<<2; end
      3:  begin commandslice = 1<<3; end
      4:  begin commandslice = 1<<4; end
      5:  begin commandslice = 1<<5; end
      6:  begin commandslice = 1<<6; end
      7:  begin commandslice = 1<<7; end
      endcase
    end

    genvar     i;
    generate
    for(i = 0; i < 32; i = i + 1) begin: alu_slices
      alu1 alu1_inst(resultBus[i],
                     carryinbus[i+1],
                     zerobus[i],
                     operandA[i],
                     operandB[i],
                     carryinbus[i],
                     commandslice);
       // we need to be able to force the first bit to be a 1
       // for SLT. Otherwise, we never use the override bus.
       if (i != 0) begin
         `OR false_inst(overrideBus[i], 1'b0, 1'b0);
       end
    end
    endgenerate
    //set the the first carry in only if we are subtracting
    // this or gate is a wire
    `OR subflag(carryinbus[0], commandslice[1], commandslice[1]);
    //set carryout to the lest carry bit
    //this or gate is also a wire
    `OR carryor(carryoutint, carryinbus[32], carryinbus[32]);
    //and all the zero outputs to get the zero output
    and32 zeroout(zero, zerobus);
    //calculate overflow
    `XOR overflowXor(possibleOverflow, result[31], carryout);
    `XNOR overflowXnor(sameSigns, operandA[31], operandB[31]);
    `AND overflowAnd(overflowint, possibleOverflow, sameSigns);
    //handle the slt stuff
    `NOT sltNot(mixedSigns, sameSigns);
    `AND sltOut(sltPre, carryinbus[32], commandslice[3]);
    `XOR sltOut2(overrideBus[0], sltPre, mixedSigns);
    or32P resultOr(result, resultBus,  overrideBus);
    //flag enabling
    `OR addorsub(flagsEnable, commandslice[0], commandslice[1]);
    `AND overflowand(overflow, overflowint, flagsEnable);
   `AND carryoutand(carryout, carryoutint, flagsEnable);
   
endmodule

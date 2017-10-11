// LUT for translating commands to control logic

// define commands
`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

module ALU_LUT
(
    output reg[2:0] select,
    output reg invert,
    input[2:0] operation
);
    wire[2:0] operation;

    always @(operation) begin
        case (operation)
            `ADD:  begin select = 0; invert = 0; end    
            `SUB:  begin select = 0; invert = 1; end
            `AND:  begin select = 1; invert = 0; end
            `NAND: begin select = 2; invert = 0; end
            `NOR:  begin select = 3; invert = 0; end
            `OR:   begin select = 4; invert = 0; end
            `XOR:  begin select = 5; invert = 0; end
            `SLT:  begin select = 6; invert = 0; end   
        endcase
    end

endmodule
//Test harness for testing 32 bit ALU
`define     code_ADD    3'b000
`define     code_SUB    3'b001
`define     code_XOR    3'b010
`define     code_SLT    3'b011
`define     code_AND    3'b100
`define     code_NAND   3'b101
`define     code_NOR    3'b110
`define     code_OR     3'b111

`include "alu.v"

module ALUTestHarness ();
    // Declare registers for inputs
    reg signed [31:0] A, B;
    reg[2:0] command;

    // Declare output wires
    wire cout, ovf, zero;
    wire[31:0] out;

    // Instantiate DUT
    ALU alu (out, cout, ovf, zero, A, B, command);

    // Declare helper variable registers

    // Set of operands to loop through for ADD, SUB and SLT
    reg[191:0] a_vals = {
        32'd400000000,
        32'd1500000000,
       -32'd300000000,
       -32'd1000000000,
       -32'd2147483647,
        32'd5000
    };
    reg[191:0] b_vals = {
        32'd500000000,
        32'd1000000000,
       -32'd100000000,
       -32'd2000000000,
        32'd2147483647,
        32'd5000
    };

    // Expected output flags
    // cout | ovf | zero
    reg[17:0] add_res = {
        3'b000,
        3'b010,
        3'b100,
        3'b110,
        3'b101,
        3'b000
    };

    // Expected output flags
    // cout | ovf | zero
    reg[17:0] sub_res = {
        3'b000,
        3'b100,
        3'b000,
        3'b100,
        3'b110,
        3'b101
    };

    reg[2:0] logic_index;
    reg ex_cout, ex_ovf, ex_zero;
    reg[3:0] add_index;
    reg[15:0] testfailed;

    initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, alu);
    testfailed = 0;

    $display("Test Commence");

    // Test Worst Case Delay
    //   Setup by doing SLT on -2147483648 1
    A = -2147483648; B = 1; command = `code_SLT; #2000

    if ( out != 32'b1 ) begin
        testfailed = testfailed +1;
        $display("Test SLT A:%b B:%b Failed, Expected Out:%b, Got Out:%b", A, B, 32'b1, out);
    end

    // Next measure delay for SLT on 0 0
    A = 0; B = 0; #2000
    if ( out != 32'b0 ) begin
        testfailed = testfailed +1;
        $display("Test SLT A:%b B:%b Failed, Expected Out:%b, Got Out:%b", A, B, 32'b0, out);
    end


    // Test block logic to check all of the bits
    command = `code_XOR;
    for (logic_index = 0; logic_index < 4; logic_index = logic_index + 1) begin
        A = (logic_index[0]==0) ? 32'd0 : 32'd2147483647;
        B = (logic_index[1]==0) ? 32'd0 : 32'd2147483647;#2000
        if (out != (A^B)) begin
            testfailed = testfailed +1;
            $display("Test XOR A:%b B:%b Failed, Expected Out:%b Got Out:%b", A, B, A^B, out);
        end
        if (cout == 1 || ovf == 1 || zero == 1) begin
            testfailed = testfailed +1;
            $display("Test XOR A:%b B:%b Failed, Produced Flags cout:%b, ovf:%b, zero:%b", A, B, cout, ovf, zero);
        end
    end

    command = `code_AND;
    for (logic_index = 0; logic_index < 4; logic_index = logic_index + 1) begin
        A = (logic_index[0]==0) ? 32'd0 : 32'd65535;
        B = (logic_index[1]==0) ? 32'd0 : 32'd65535;#2000
        if (out != (A&B)) begin
            testfailed = testfailed +1;
            $display("Test AND A:%b B:%b Failed, Expected Out:%b Got Out:%b", A, B, A&B, out);
        end
        if (cout == 1 || ovf == 1 || zero == 1) begin
            testfailed = testfailed +1;
            $display("Test AND A:%b B:%b Failed, Produced Flags cout:%b, ovf:%b, zero:%b", A, B, cout, ovf, zero);
        end
    end

    command = `code_NAND;
    for (logic_index = 0; logic_index < 4; logic_index = logic_index + 1) begin
        A = (logic_index[0]==0) ? 32'd0 : 32'd65535;
        B = (logic_index[1]==0) ? 32'd0 : 32'd65535;#2000
        if (out != (A~&B)) begin
            testfailed = testfailed +1;
            $display("Test NAND A:%b B:%b Failed, Expected Out:%b Got Out:%b", A, B, A~&B, out);
        end
        if (cout == 1 || ovf == 1 || zero == 1) begin
            testfailed = testfailed +1;
            $display("Test NAND A:%b B:%b Failed, Produced Flags cout:%b, ovf:%b, zero:%b", A, B, cout, ovf, zero);
        end
    end

    command = `code_NOR;
    for (logic_index = 0; logic_index < 4; logic_index = logic_index + 1) begin
        A = (logic_index[0]==0) ? 32'd0 : 32'd65535;
        B = (logic_index[1]==0) ? 32'd0 : 32'd65535;#2000
        if (out != (A~|B)) begin
            testfailed = testfailed +1;
            $display("Test NOR A:%b B:%b Failed, Expected Out:%b Got Out:%b", A, B, A~|B, out);
        end
        if (cout == 1 || ovf == 1 || zero == 1) begin
            testfailed = testfailed +1;
            $display("Test NOR A:%b B:%b Failed, Produced Flags cout:%b, ovf:%b, zero:%b", A, B, cout, ovf, zero);
        end
    end

    command = `code_OR;
    for (logic_index = 0; logic_index < 4; logic_index = logic_index + 1) begin
        A = (logic_index[0]==0) ? 32'd0 : 32'd65535;
        B = (logic_index[1]==0) ? 32'd0 : 32'd65535;#2000
        if (out != (A|B)) begin
            testfailed = testfailed +1;
            $display("Test OR A:%b B:%b Failed, Expected Out:%b Got Out:%b", A, B, A|B, out);
        end
        if (cout == 1 || ovf == 1 || zero == 1) begin
            testfailed = testfailed +1;
            $display("Test OR A:%b B:%b Failed, Produced Flags cout:%b, ovf:%b, zero:%b", A, B, cout, ovf, zero);
        end
    end


    // Test all signals in ADD by using all bits for a non-zero result
    command = `code_ADD;
    // 0111... + 1111...
    A = 2147483647; B = -1;#2000
    if (out != 2147483646) begin
        testfailed = testfailed +1;
        $display("Test ADD A:%b B:%b Failed, Expected Out:%b Got Out:%b", A, B, 2147483646, out);
    end

    // 1111... + 1000...
    A = -1; B = 32'b1<<31;#2000
    if (out != 2147483647) begin
        testfailed = testfailed +1;
        $display("Test ADD A:%b B:%b Failed, Expected Out:%b Got Out:%b", A, B, 2147483647, out);
    end

    // Test a few internal carries for ADD
    // ...0001 + ...0001
    A = 32'b1; B = 32'b1;#2000
    if (out != 32'b10) begin
        testfailed = testfailed +1;
        $display("Test ADD A:%b B:%b Failed, Expected Out:%b Got Out:%b", A, B, 32'b10, out);
    end

    // ...0010 + 0010
    A = 32'b10; B =32'b10;#2000
    if (out != 32'b100) begin
        testfailed = testfailed +1;
        $display("Test ADD A:%b B:%b Failed, Expected Out:%b Got Out:%b", A, B, 32'b100, out);
    end

    // 0100... + 0100...
    A = 32'b1<<30; B = 32'b1<<30 ;#2000
    if (out != 32'b1<<31) begin
        testfailed = testfailed +1;
        $display("Test ADD A:%b B:%b Failed, Expected Out:%b Got Out:%b", A, B, 32'b1<<31, out);
    end

    // 1000... + 1000...
    A = 32'b1<<31; B = 32'b1<<31 ;#2000
    if (out != 32'b0) begin
        testfailed = testfailed +1;
        $display("Test ADD A:%b B:%b Failed, Expected Out:%b Got Out:%b", A, B, 32'b0, out);
    end


    // ADD SUB SLT interesting cases
    command = `code_ADD;
    for (add_index = 0; add_index<6; add_index = add_index + 1) begin
        A = a_vals[((add_index*32)-1)-:32]; // Grab the relevant chunk of the register of queued operations
        B = b_vals[((add_index*32)-1)-:32];#2000
        {ex_cout,ex_ovf,ex_zero} = add_res[((add_index*3)-1)-:3];

        if (out != (A+B)) begin
            testfailed = testfailed +1;
            $display("Test ADD A:%d B:%d Failed, Expected Out:%d Got Out:%d", A, B, A+B, out);
        end
        if (cout != ex_cout) begin
            testfailed = testfailed +1;
            $display("Test ADD A:%d B:%d Failed, Expected cout:%d Got cout:%d", A, B, ex_cout, cout);
        end
        if (ovf != ex_ovf) begin
            testfailed = testfailed +1;
            $display("Test ADD A:%d B:%d Failed, Expected ovf:%d Got ovf:%d", A, B, ex_ovf, ovf);
        end
        if (zero != ex_zero) begin
            testfailed = testfailed +1;
            $display("Test ADD A:%d B:%d Failed, Expected zero:%d Got zero:%d", A, B, ex_zero, zero);
        end
    end

    //SUB
    command = `code_SUB;
    for (add_index = 0; add_index<6; add_index = add_index + 1) begin
        A = a_vals[((add_index*32)-1)-:32]; // Grab the relevant chunk of the register of queued operations
        B = b_vals[((add_index*32)-1)-:32];#2000
        {ex_cout,ex_ovf,ex_zero} = sub_res[((add_index*3)-1)-:3];

        if (out != (A-B)) begin
            testfailed = testfailed +1;
            $display("Test SUB A:%d B:%d Failed, Expected Out:%d Got Out:%d", A, B, A-B, out);
        end
        if (cout != ex_cout) begin
            testfailed = testfailed +1;
            $display("Test SUB A:%d B:%d Failed, Expected cout:%d Got cout:%d", A, B, ex_cout, cout);
        end
        if (ovf != ex_ovf) begin
            testfailed = testfailed +1;
            $display("Test SUB A:%d B:%d Failed, Expected ovf:%d Got ovf:%d", A, B, ex_ovf, ovf);
        end
        if (zero != ex_zero) begin
            testfailed = testfailed +1;
            $display("Test SUB A:%d B:%d Failed, Expected zero:%d Got zero:%d", A, B, ex_zero, zero);
        end
    end

    //SLT
    command = `code_SLT;
    for (add_index = 0; add_index<6; add_index = add_index + 1) begin
        A = a_vals[((add_index*32)-1)-:32]; // Grab the relevant chunk of the register of queued operations
        B = b_vals[((add_index*32)-1)-:32];#2000

        if (out != ((A<B)?1:0)) begin
            testfailed = testfailed +1;
            $display("Test SLT A:%d B:%d Failed, Expected Out:%d Got Out:%d", A, B, (A<B)?1:0, out);
        end
        if (cout != 0 || ovf != 0 || zero != 0) begin
            testfailed = testfailed +1;
            $display("Test SLT Failed, cout:%b ovf:%b zero:%b", cout, ovf, zero);
        end
    end

    if (testfailed > 0) begin
        $display(" %d Tests Failed", testfailed);
    end else begin
        $display(" Tests Passed!");
    end

    end
endmodule

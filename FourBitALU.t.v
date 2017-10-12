//Test harness for exhaustively testing ADD SUB and SLT in 4-bit ALU

`include "FourBitALU.v"

module FourBitALUTestHarness ();

    // Declare registers for inputs
    reg[3:0] A, B;
    reg[2:0] command;


    // Declare output wires
    wire ovf, cout, zero;
    wire[3:0] out;

    // Instantiate DUT
    FourBitALU four_bit_alu (out, cout, ovf, zero, A, B, command);

    // Declare helper variable registers
    reg[4:0] a_index, b_index;
    reg signed [4:0] temp_sum;
    reg[3:0] ex_out;
    reg ex_ovf, ex_cout, ex_zero;
    reg testfailed;

    initial begin
    $dumpfile("fourbitalu.vcd");
    $dumpvars(0, four_bit_alu);
    // Start testing ADD
    command = 3'd0;
    //Loop A
    for (a_index=0; a_index<16; a_index=a_index+1) begin
        A = a_index;
        // Loop B
        for (b_index=0; b_index<16; b_index=b_index+1) begin
            B = b_index; #1000
            temp_sum = A + B; // Do an add

            ex_out = temp_sum[3:0];

            // Set up expected carryout
            if (temp_sum > 15) begin
            ex_cout = 1;
            end else begin
            ex_cout = 0;
            end

            // set up expected overflow
            if (A[3] == B[3] && temp_sum[3] != B[3]) begin
            ex_ovf = 1;
            end else begin
            ex_ovf = 0;
            end

            // set up expected zero
            if (temp_sum [3:0] == 0) begin
                ex_zero = 1;
            end else begin
                ex_zero = 0;
            end

            // set up expected carryout
            ex_cout = temp_sum[4];


            // Test res
            if (out != ex_out) begin
                testfailed = testfailed + 1;
                $display("Test Case ADD A:%b B:%b Failed, Got Out:%b Expected Out:%b", A, B, out, ex_out);
            end
            // Test ovf
            if (ovf != ex_ovf) begin
                testfailed = testfailed + 1;
                $display("Test Case ADD A:%b B:%b Failed, Got OVF:%b Expected OVF:%b", A, B, ovf, ex_ovf);
            end
            // Test zero
            if (zero != ex_zero) begin
                testfailed = testfailed + 1;
                $display("Test Case ADD A:%b B:%b Failed, Got zero:%b Expected zero:%b", A, B, zero, ex_zero);
            end
            // Test cout
            if (cout != ex_cout) begin
                testfailed = testfailed + 1;
                $display("Test Case ADD A:%b B:%b Failed, Got cout:%b Expected cout:%b", A, B, cout, ex_cout);
            end
        end
    end


    // Test SUB
    command = 3'd1;
    //Loop A
    for (a_index=0; a_index<16; a_index=a_index+1) begin
        A = a_index;
        // Loop B
        for (b_index=0; b_index<16; b_index=b_index+1) begin
            B = b_index; #1000
            temp_sum = {1'b0, A} + {1'b0,(~B)} + 1; //Carefully widen and do a subtract to preserve sign

            ex_out = temp_sum[3:0];

            // Set up expected carryout
            if (temp_sum > 15) begin
            ex_cout = 1;
            end else begin
            ex_cout = 0;
            end

            // set up expected overflow
            if ((A[3] != B[3]) && (temp_sum[3] == B[3])) begin
                ex_ovf = 1;
            end else begin
                ex_ovf = 0;
            end

            // set up expected zero
            if (temp_sum [3:0] == 0) begin
                ex_zero = 1;
            end else begin
                ex_zero = 0;
            end

            // set up expected carryout
            ex_cout = temp_sum[4];


            // Test res
            if (out != ex_out) begin
                testfailed = testfailed + 1;
                $display("Test Case SUB A:%b B:%b ~B:%b temp_sum:%b Failed, Got Out:%b Expected Out:%b", A, B, (~B), temp_sum, out, ex_out);
            end
            // Test ovf
            if (ovf != ex_ovf) begin
                testfailed = testfailed + 1;
                $display("Test Case SUB A:%b B:%b ~B:%b temp_sum:%b Failed, Got OVF:%b Expected OVF:%b", A, B, (~B), temp_sum, ovf, ex_ovf);
            end
            // Test zero
            if (zero != ex_zero) begin
                testfailed = testfailed + 1;
                $display("Test Case SUB A:%b B:%b ~B:%b temp_sum:%b Failed, Got zero:%b Expected zero:%b", A, B, (~B), temp_sum, zero, ex_zero);
            end
            // Test cout
            if (cout != ex_cout) begin
                testfailed = testfailed + 1;
                $display("Test Case SUB A:%b B:%b ~B:%b temp_sum:%b Failed, Got cout:%b Expected cout:%b", A, B, (~B), temp_sum, cout, ex_cout);
            end
        end
    end



    //Test SLT
    command = 3'd3;
    //Loop A
    for (a_index=0; a_index<16; a_index=a_index+1) begin
        A = a_index;
        // Loop B
        for (b_index=0; b_index<16; b_index=b_index+1) begin
            B = b_index; #1000

            // Set up expected carryout
            ex_cout = 0;

            // set up expected overflow
            ex_ovf = 0;

            // set up expected zero
            ex_zero = 0;

            // set up expected output
            if ( (A[3] == 1 && B[3] == 0) || (A[3] == B[3]) && (A < B) ) begin
                ex_out = 1;
            end else begin
                ex_out = 0;
            end


            // Test res
            if (out != ex_out) begin
                testfailed = testfailed + 1;
                $display("Test Case SLT A:%b B:%b Failed, Got Out:%b Expected Out:%b", A, B, out, ex_out);
            end
            // Test ovf
            if (ovf != ex_ovf) begin
                testfailed = testfailed + 1;
                $display("Test Case SLT A:%b B:%b Failed, Got OVF:%b Expected OVF:%b", A, B, ovf, ex_ovf);
            end
            // Test zero
            if (zero != ex_zero) begin
                testfailed = testfailed + 1;
                $display("Test Case SLT A:%b B:%b Failed, Got zero:%b Expected zero:%b", A, B, zero, ex_zero);
            end
            // Test cout
            if (cout != ex_cout) begin
                testfailed = testfailed + 1;
                $display("Test Case SUB A:%b B:%b Failed, Got cout:%b Expected cout:%b", A, B, cout, ex_cout);
            end
        end
    end

    if (testfailed > 0) begin
        $display("%d Tests Failed", testfailed);
    end else begin
        $display("Tests Passed");
    end


    end
endmodule

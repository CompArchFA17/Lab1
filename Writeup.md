## Implementation
Going into this lab we knew the bigget decision to be made for the ALU would be whether to implement it through a bit slice method or individualy via several independent logic circuits through a decoder. In the end we decided to use a bit slice because it is much easier to define dynamically and in the end should result in a more compact design.

### Bit Slice
We broke up the alu into a bit sliced implementation. Basically we made a bunch of one bit ALUs and strung their carryouts to the next ALUs carryin. The bit slices accepted their opcodes in unary instead of binary, meaning that they had eight wires, one for each opcode, one of which would be high at a time. The meant we needed only one decoder, but we had to invent a unary multiplexer to output the result.

Only three of the opcodes use carry functionality: add, sub, and slt.

### SLT
Our bit sliced SLT uses carryin and carryout to compare numbers without addition or subtraction. It's Basically a recursive compare algorithm. Ignoring sign for now, if the last bit of A is greater than the last bit of B, A is greater than B. If it is less, A is not greater than B. If they are equal, then you move on to the next bit, and compare them. By sending the result up the carry chain when the nth bit of A matches the nth bit of B, we get a bit by bit comparison of A and B, which doesn't even always need to wait for the carry to go all the way through. By passing a 0 to the first carry in, we get SLT. If we passed a 1 to the first carry in, we would have LTE.

Finally, we just set the first bit of the result to the value of carryout. This is done outside of the bit slice.

This implemenation is always wrong if the signs of the operands are different, so we just negate the output if that is the case.

### ALU
The first thing that the ALU does when it recieves information (op A, op B, command) is expand the command from a 3 bit binary bus to a 7 bit one-hot bus. This operation if not implemented in the top level of the ALU would be required in each ALU sliced bit individually, so in this case implementing it once for the top level gives a 32 fold gate reduction.

#### Subtraction
In the case of subtraction the LSB of the carryin bus is flipped to a 1 and each individual bit of the B operand is flipped by the 1 bit ALU slices which then do single bit addition, resulting in a subtraction action.

#### Addition
In the case of addition each the LSB of the carryin bus is left empty and the carryout of each 1 bit ALU slice is connected to the carryin of the next bit, with the final connected to an AND gate to enable the carryout flag.

## Test Results
After some difficulties with post processing, we got our tests to pass. We weren't sure if carryout and zero were flags that should not be set for other operands beside ADD and SUB, so we didn't test that.

### Test Choice
We chose tests that would cover edge cases for the difficult operands: overflow and underflow for subtraction and addition, and all the +/- permutations for SLT. We also chose some more standard tests for each operator.

### Test Driven Development Catches Bugs
We waited until after writing the ALU to begin writing comprehensive test cases. After writing just two test cases we were able to find and fix two bugs in post-processing. We were incorrectly diagnosing overflow on subtraction, because the signs must not match for overflow to occur in subtraction. We also found a typo where we were XORin instead of ORing.

## Timing

## Work Plan Reflection
Writing the implementation happened fairly quickly in about the time we predicted, however the act of gathering information and creating visuals for the final write up turned out to be more time intensive than we had planned

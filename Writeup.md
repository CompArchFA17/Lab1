## Implementation
Going into this lab we knew the bigget decision to be made for the ALU would be whether to implement it through a bit slice method or individualy via several independent logic circuits through a decoder. In the end we decided to use a bit slice because it is much easier to define dynamically and in the end should result in a more compact design.

### Bit Slice

### SLT

### ALU
The first thing that the ALU does when it recieves information (op A, op B, command) is expand the command from a 3 bit binary bus to a 7 bit one-hot bus. This operation if not implemented in the top level of the ALU would be required in each ALU sliced bit individually, so in this case implementing it once for the top level gives a 32 fold gate reduction. 

#### Subtraction
In the case of subtraction the LSB of the carryin bus is flipped to a 1 and each individual bit of the B operand is flipped by the 1 bit ALU slices which then do single bit addition, resulting in a subtraction action.

#### Addition
In the case of addition each the LSB of the carryin bus is left empty and the carryout of each 1 bit ALU slice is connected to the carryin of the next bit, with the final connected to an AND gate to enable the carryout flag.

## Test Results
### Test Choice
### Test Driven Development Catches Bugs
### Discovered Tests

## Timing

## Work Plan Reflection
Writing the implementation happened fairly quickly in about the time we predicted, however the act of gathering information and creating visuals for the 

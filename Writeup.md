## Implementation
Going into this lab we knew the bigget decision to be made for the ALU would be whether to implement it through a bit slice method or individualy via several independent logic circuits through a decoder. In the end we decided to use a bit slice because it is much easier to define dynamically and in the end should result in a more compact design.

### Bit Slice

### SLT

### ALU
The first thing that the ALU does when it recieves information (op A, op B, command) is expand the command from a 3 bit binary bus to a 7 bit one-hot bus. This operation if not implemented in the top level of the ALU would be required in each ALU sliced bit individually, so in this case implementing it once for the top level gives a 32 fold gate reduction.  

## Test Results
### Test Choice
### Test Driven Development Catches Bugs
### Discovered Tests

## Timing

## Work Plan Reflection

<!---
In this lab your team is designing the ALU subsystem. Write a report to the project manager in charge of 
the entire CPU demonstrating that your ALU design is complete, correct, and ready to be included in the CPU.

Implementation

Discuss any interesting design choices you made along the way.

Include block diagrams of your ALU at an appropriate level of detail: the top-level diagram above is too 
abstract to say anything about your particular design, while a single figure with every AND gate and wire 
would be unintelligible. Use your hierarchy and organization to show the important pieces. If you took a 
Bitslice approach, you should show a single bit and how they fit together.

Test Results

For each ALU operation, include the following in your report:

A written description of what tests you chose, and why you chose them. This should be roughly a couple 
sentences per operation.
Specific instances where your test bench caught a flaw in your design.
As your ALU design evolves, you may find that new test cases should be added to your test bench. 
This is a good thing. When this happens, record specifically why these tests were added.
Timing Analysis

Provide the worst case propagation delay for each of the operations of the ALU. This can be calculated 
or simulated (preferably both). Note: the propagation delay for some operations may depend heavily 
on your choice of operands.

Work Plan Reflection

Compare how long each unit work actually took to how long you predicted it would take. This will help 
you better schedule future labs.
-->

# Final Report

Our ALU implements all the 8 functions laid out. We have delay of 2000 time units for all our functions.

Our ALU is broken down into many modules. At the very bottom, we have our 32-bit logic gates, `and32`, 
`xor32`, etc. Then we have modules for the 32 bit arithmetic operations - add, sub, slt. Then we have a
module for the ALU itself.

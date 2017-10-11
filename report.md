# Lab 1

## Serena Chen, Annie Ku, and Kaitlyn Keil

### Implementation

We decided to create modules for 32 bit logic. The base of these were NAND, NOR, and NOT gates, where individual bits were compared or negated. Each major gate, then, contained 32 1- or 2-input gates. For AND and OR, we sent the input through the 32-bit NAND and NOR respectively, then through the 32-bit NOT to negate it. XOR we treated as we did the basic gates, with each 2-input XOR having a longer delay. Similarly, we created a 32-bit adder and subtractor. The adder used 4-bit adders, and the subtractor took the inputs, inverted the second one with the 32-bit NOT, added a 32’b1 with the 32-bit adder, and then added the two numbers together. For overflow, it checked both whether there was overflow in the inversion (true when starting with the largest possible negative value) or in the final result.

!(https://github.com/kuannie1/Lab1/blob/master/blockdiagram1.png)

!(https://github.com/kuannie1/Lab1/blob/master/blockdiagram2.png)

We decided to implement subtractor this was as opposed to using the invertB flag that was suggested in the Control Logic LUT. This was because we decided that the invertB flag was best used when either creating new gates not used in previous homeworks (thus having adder accept slightly different inputs) or when bit-slicing within the ALU itself, which would make it simpler to invert and add that initial carry-in. This might make it take more space overall, but it simplified the ALU control, which we implemented using a switch statement that checks for changes in the command or either input value.

Finally, we added significant delays (2500 time units) to allow time for the propagation of all our values. The delay lengths are based on observation of what worked, longest for subtraction and SLT operations. 

### Test Results

**ADD:** We started by making sure the very basic cases worked, such as adding 10 with 10. After assuring that this worked like we expected, we tested edge cases, such as adding 1 to the largest positive number available and causing overflow, adding compliments to flag zero, and other tests that pushed the basic limits. This alerted us to some of our initial timing issues, though not the later ones.

**SUB:** Many of our subtraction test cases are similar to the addition. We tried several that would result in 0, many that involved the maximum negative and positive, and subtracting compliments. However, we found a flaw when we tried to do 32’d0 - 32’h80000000. This resulted in 32’h80000000 with no overflow, which was false. We were able to use this case to add a line that checked if inverting the number caused overflow, in which case the entire test would as well. The subtraction tests, along with SLT, helped us find the majority of our timing problems due to the long propagation length.

**XOR:** Our XOR tests took some of the maximum and minimum values and compared it. We were checking for cases where everything was true, everything was false, or alternating.

**SLT:** We had several issues with SLT. Because of this, we extensively tested edge cases, like comparing 0 with 32’h80000000. As discussed before, this was an unusual case because of how inverting the second number went. The fact that this broke often alerted us to the problem in our subtraction module, which we then fixed. We also tested equivalent numbers and complements. SLT showed us most of our timing issues, because when we increased delays, it began to work more efficiently. This is because it used a subtractor, which was already the greatest time sink.

**AND, NAND, NOR, and OR:** These tests followed similar patterns to XOR. We looked at extreme edge cases, but as there was never a risk of overflow, we never experienced difficulties. Nonetheless, we tested them on extreme values, middle values, and 0s.

**Timing:** We counted a single-input basic gate (NOT) as a delay of 10, and a two-input basic gate (NAND and NOR) as delay of 20. As the 32-input gates run all the inputs simultaneously through their respective gates, this did not increase the timing for the 32-bit gates. AND and OR inverted NAND and NOR, so took 30 each. XOR we guessed at 30, because we knew there was more complicated logic going on behind the scenes (likely each input would go through a not, an and, and then another not (with the first two in parallel with a non-inverted and) for output). However, we decided our time was better spent on other aspects of the ALU, since the general delay of XOR would not cause significant delay in the face of SUB or SLT. Below is the by-hand calculations of the gate delays.

| OPERATION | ADD | SUB | XOR | SLT | AND | NAND | NOR | OR |
| DELAY | 1090 | 2220 | 30 | 2250 | 30 | 20 | 20 | 30 |

Below is the GTKwave timing analysis.

!(https://github.com/kuannie1/Lab1/blob/master/timing_analysis.png)

### Work Plan Reflection

We were very optimistic in our work plan. While we did finish on 10/11, as planned, constructing the circuit and accounting for 32 bits took us longer than anticipated. Our switch statement LUT took us less than the 30 minutes anticipated once we decided that was what we wanted, but making fixes to the modules called made the Verilog take until 10/11, with at least 6 hours total spent on building and tweaking the implementation.

The test bench also took longer to write, though we broke up individually to work on this. While writing the tests themselves probably took us each about 30 minutes, fixing the issues that it showed made it seem much longer. This was finished along with the Verilog on 10/11, two days after our initial plan.

Finally, the report did not take us as long as we anticipated, which was good, seeing as everything else took a little bit longer. However, we did not need much of our Thursday leeway time, which is a good benefit.

In the future, we will give more time for figuring out Verilog’s particular quirks and implementing modules that need to be tested.


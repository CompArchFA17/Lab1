# Lab 1 Report

### Changjun Lim, Sungwoo Park


### test case


SLT

We choose 6 cases for SLT. There are 3 parameter related to results, sign of A, sign of B, and A < B. It could be categorized to 8(=2<sup>3</sup>) cases, but when A is negative and B is positive, A < B is always true and when A is positive and B is negative, A < B is always false. So there are only 6 categories.

For bitwise logic operations(XOR, AND, NAND, NOR, OR), we choose 2 cases and set each case to have 4 categories(in the truth table) in 32 bits.





## error case

example 1)
testing ADD
operandA operandB command |              result             carryout zero overflow| expected outputs
00000002 00000001 0       | xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx01    0     z   x       | 00000000000000000000000000000011  0  0  0
ffffffff ffffffff 0       | xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx0    1     z   x       | 11111111111111111111111111111110  1  0  0
00000000 00000000 0       | 00000000000000000000000000000000    0     z   0       | 00000000000000000000000000000000  0  1  0
7fffffff 00000001 0       | x0101010101010101010101010101010    0     z   0       | 10000000000000000000000000000000  0  0  1
testing SUB
00000003 00000001 1       | xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx0    x     z   x       | 00000000000000000000000000000010  0  0  0
80000000 00000001 1       | x1010101010101010101010101010101    1     z   0       | 01111111111111111111111111111111  1  0  1
00000000 00000000 1       | 10101010101010101010101010101010    0     z   1       | 00000000000000000000000000000000  0  1  0
ffffffff ffffffff 1       | 10101010101010101010101010101010    0     z   1       | 00000000000000000000000000000000  1  1  0
testing XOR
aa550055 aaff55aa 2       | 0x0x0x0010101010xxxxxxx1x1x1x1x1    1     z   1       | 00000000101010100101010111111111  0  0  0
ffff0000 00ff00ff 2       | x1x1x1x1xxxxxxx00000000xx1x1x1x1    1     z   0       | 11111111000000000000000011111111  0  0  0
testing SLT
555555aa 55aa55aa 3       | x0x0x0x0x0x0x0x0x0x0x0x0x0x0x0x0    0     z   0       | 00000000000000000000000000000001  0  0  0
555555aa 555555aa 3       | x0x0x0x0x0x0x0x0x0x0x0x0x0x0x0x0    0     z   0       | 00000000000000000000000000000000  0  0  0
00ff00ff ff00ff00 3       | 0000000xxxxxxxx00000000xxxxxxxx0    0     z   0       | 00000000000000000000000000000000  0  0  0
ffffff00 0000ffff 3       | xxxxxxxxxxxxxxx00000000000000001    1     z   1       | 00000000000000000000000000000001  0  0  0
aaaa55aa aa5555aa 3       | 0x0x0x0x0x0x0x0xxxxxxxxxxxxxxxxx    x     z   x       | 00000000000000000000000000000001  0  0  0
ff55ff00 ffff5500 3       | x0x0x0x0x0x0x0xxxxxxxxx0x0x0x0x0    0     z   0       | 00000000000000000000000000000000  0  0  0
testing AND
ffff0000 00ff00ff 4       | xxxxxxxx1111111x0000000000000000    x     z   x       | 00000000111111110000000000000000  0  0  0
ff00aa55 aaaa55aa 4       | xxxxxxx0000000000000000000000000    1     z   0       | 10101010000000000000000000000000  0  0  0
testing NAND
ffff0000 00ff00ff 5       | x1x1x1x1xxxxxxx0xxxxxxx1x1x1x1x1    1     z   0       | 11111111000000001111111111111111  0  0  0
ff00aa55 aaaa55aa 5       | x1x1x1x1x1x1x1x1x1x1x1x1x1x1x1x1    1     z   1       | 01010101111111111111111111111111  0  0  0
testing NOR
55550055 aaff55aa 6       | x0x0x0x0x0x0x0x0x0x0x0x000000000    0     z   0       | 00000000000000000101010100000000  0  0  0
ffff0000 00ff00ff 6       | xxxxxxxxxxxxxxx0xxxxxxxx00000000    x     z   x       | 00000000111111110000000000000000  0  0  0
testing OR
55ffaa00 aaaa55aa 7       | x1x1x1x1x1x1x1xxxxxxxxxxx0x0x0x0    1     z   0       | 11111111111111111111111110101010  0  0  0
ffff0000 00ff00ff 7       | 111111111111111x0000000xx1x1x1x1    1     z   0       | 11111111111111110000000011111111  0  0  0

connect result bit to carryin/carryout part




Work Plan Reflection

testbench design ~10/10 2hours

alu design ~10/10 0.5hours
~10/11 2hours
~10/12 0.5hours


revise code ~10/11 0.5hours
~10/12 2.5hours
all: compile test

compile: multiplexer.v adder.v 3bitMux.v alu.v
	iverilog -o 3bitMux_test 3bitMux.t.v
	iverilog -o bitALU_test bitAlu.t.v
	iverilog -o alu_test alu.t.v

test: multiplexer.v adder.v 3bitMux.v alu.v
	./3bitMux_test
	./bitALU_test
	./alu_test

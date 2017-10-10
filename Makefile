test: build
	./alu

build: alu.t.v alu.v alu1.v
	iverilog alu.t.v -o alu

clean:
	rm alu


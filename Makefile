# SPDX-License-Identifier: MIT
# Author: Robert Balas <balasr@iis.ee.ethz.ch>

# Requires Verilator 5

VERILATOR = verilator
BIN = hello

all: ./obj_dir/$(BIN)

./obj_dir/$(BIN):
	$(VERILATOR) --trace-fst --timescale 1ns/1ns --timing --binary --build hello.sv  -o $(BIN)

run: ./obj_dir/$(BIN)
	./$^

.PHONY: gtkwave
gtkwave:
	gtkwave $(BIN).fst

.PHONY: clean
clean:
	$(RM) -r obj_dir/

export PATH:=/cygdrive/c/Hwdev/modelsim181/modelsim_ase/win32aloem:/cygdrive/c/Hwdev/iverilog/bin/:/cygdrive/c/Hwdev/sjasmplus/:/cygdrive/c/Dev/srec/:${PATH}

all: testbench_pwldac

testbench_pwldac: V=testbench_pwldac.v


# testbench_%:
# 	iverilog -g2005-sv ${VFLAGS} -o $@.vvp $@.v ${V}
# 	vvp $@.vvp
# 	@rm $@.vvp

testbench_%:
	test ! -d work || rm -rf work
	vlib work
	test ! -n "$(filter %.v,${V})" || vlog -sv $(filter %.v,${V})
	test ! -n "$(filter %.vhd %.vhdl,${V})" || vcom $(filter %.vhd %.vhdl,${V})
	vsim -do 'run -all' $@
	@rm transcript

%.bin: %.asm
	sjasmplus $<
%.mem: %.bin
	srec_cat $< -binary -o $@ -vmem 8

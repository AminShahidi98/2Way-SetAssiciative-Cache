SetActiveLib -work
#Compiling UUT module design files

comp -include "$dsn\src\TestBench\Cache_TB.v"
asim +access +r Cache_tb

wave
wave -noreg dout0
wave -noreg dout1
wave -noreg clk
wave -noreg sel0
wave -noreg sel1
wave -noreg we
wave -noreg addr_in
wave -noreg HIT0
wave -noreg HIT1
wave -noreg addr_mem
wave -noreg di0
wave -noreg di1

run

#End simulation macro

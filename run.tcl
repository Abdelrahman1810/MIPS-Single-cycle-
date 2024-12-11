vlib work
vlog {C:\Users\abdel\Desktop\New folder\ca TEST\AAC\muxNbit_2_1.v}
vlog {C:\Users\abdel\Desktop\New folder\ca TEST\AAC\ALUControl.v}
vlog {C:\Users\abdel\Desktop\New folder\ca TEST\AAC\BranchTargetAddress.v}
vlog {C:\Users\abdel\Desktop\New folder\ca TEST\AAC\ControlUnit.v}
# vlog {C:\Users\abdel\Desktop\New folder\ca TEST\AAC\DataMemory.dat}
vlog {C:\Users\abdel\Desktop\New folder\ca TEST\AAC\DataPath.v}
vlog {C:\Users\abdel\Desktop\New folder\ca TEST\AAC\Datamemory.v}
# vlog {C:\Users\abdel\Desktop\New folder\ca TEST\AAC\InstructionData.dat}
vlog {C:\Users\abdel\Desktop\New folder\ca TEST\AAC\InstructionMemory.v}
vlog {C:\Users\abdel\Desktop\New folder\ca TEST\AAC\MainALU.v}
vlog {C:\Users\abdel\Desktop\New folder\ca TEST\AAC\PCadder.v}
vlog {C:\Users\abdel\Desktop\New folder\ca TEST\AAC\ProgramCounter.v}
# vlog {C:\Users\abdel\Desktop\New folder\ca TEST\AAC\RegisterData.dat}
vlog {C:\Users\abdel\Desktop\New folder\ca TEST\AAC\RegistersFile.v}
vlog {C:\Users\abdel\Desktop\New folder\ca TEST\AAC\SignExtend.v}
# vlog {C:\Users\abdel\Desktop\New folder\ca TEST\AAC\assembly.s}
vlog {C:\Users\abdel\Desktop\New folder\ca TEST\AAC\testbench.sv}


vsim -voptargs=+acc work.testbench
add wave -position insertpoint  \
sim:/testbench/datapath/regfile/regmem
add wave -position insertpoint  \
sim:/testbench/datapath/datamem/DataMem
add wave -position insertpoint  \
sim:/testbench/datapath/insMem/InstructionData

# add wave -position insertpoint  \
# {sim:/testbench/datapath/datamem/DataMem[128]}
# add wave -position insertpoint  \
# {sim:/testbench/datapath/datamem/DataMem[132]}
# add wave -position insertpoint  \
# {sim:/testbench/datapath/datamem/DataMem[136]}
# add wave -position insertpoint \
# {sim:/testbench/datapath/datamem/DataMem[140]}
# add wave -position insertpoint  \
# {sim:/testbench/datapath/datamem/DataMem[144]}
# add wave -position insertpoint  \
# {sim:/testbench/datapath/datamem/DataMem[148]}

# add wave -position insertpoint -color gold  \
# {sim:/testbench/datapath/regfile/regmem[16]}
# add wave -position insertpoint -color gold  \
# {sim:/testbench/datapath/regfile/regmem[10]}
# add wave -position insertpoint -color gold  \
# {sim:/testbench/datapath/regfile/regmem[11]}

# add wave -r /*
add wave *
run -all

# quit -sim
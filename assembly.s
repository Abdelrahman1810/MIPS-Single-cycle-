@ write your assembly code =>
@ then transelate it into Machine code 
@ then write it in InstructionData.dat
@ do NOT forget that Instruction Memory read word by wird

addi t2 $zero 0x5   // 200A0005 (2) max
addi t3 $zero 0x5   // 200B0005 (3) min

@ in Intruction memory
@ 20_0A_00_05 => 4 word
@ 20_0B_00_05 => 4 word
@ 20
@ 0A
@ 00
@ 05
@ 20
@ 0B
@ 00
@ 05
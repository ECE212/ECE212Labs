/******************************************************
This is the Initialization file to load contents to memory.
In this subroutine, it initializes memory locations assigned values for
manipulation.
Because the contents in the .data section get placed at an arbitary memory
location, we want to force the data to be stored at a specific location.
In a nutshell, we are basically swapping memory contents.
The memory locations set are at 
0x43000000 - Number of data points
0x43000004 - Contains X points
0x43000008 - Contains Y points
0x4300000C - Contains the address of temporary storage
0x43000010 - Contains the address of where to store you final value
Input parameters: Nothing
Output parameters: Nothing
******************************************************/


.text

.equ Opcode, 0x43000000

.global Intialization

Intialization:

lea      -40(%a7),%a7 
movem.l %d2-%d7/%a2-%a5,(%a7)

move.l #Opcode, %a3 
lea Instruction, %a2 
move.l (%a2), (%a3)
add.l #4, %a2 
add.l #4, %a3 
move.l (%a2), (%a3) 
add.l #4, %a2 
add.l #4, %a3 
move.l (%a2), (%a3)
add.l #4, %a2 
add.l #4, %a3 
move.l (%a2), (%a3) 
add.l #4, %a2 
add.l #4, %a3 
move.l (%a2), (%a3) 
add.l #4, %a2 
add.l #4, %a3 
move.l (%a2), (%a3) 



move.l #Opcode, %a4 
move.l 4(%a4), %a3
move.l (%a4), %d2
lea FirstBlock, %a2 
again: move.l (%a2), (%a3) 
cmpi.l #1, %d2
beq next
add.l #4, %a2 
add.l #4, %a3 
sub.l #1, %d2
bra again 

next:

move.l #Opcode, %a4 
move.l 8(%a4), %a3
move.l (%a4), %d2
lea SecondBlock, %a2 
again1: move.l (%a2), (%a3) 
cmpi.l #1, %d2
beq next1
add.l #4, %a2 
add.l #4, %a3 
sub.l #1, %d2
bra again1
 
next1:

movem.l (%a7),%d2-%d7/%a2-%a5 
lea      40(%a7),%a7 

rts

.data

Instruction:
.long 51
/*.long 0x33*/
.long 0x43100000
.long 0x43200000
.long 0x43300000
.long 0x43400000
.long 0x43500000


FirstBlock:
.long 0
.long 2
.long 3
.long 7
.long 8
.long 10
.long 11
.long 15
.long 19
.long 21
.long 22
/*10*/
.long 24
.long 28
.long 29
.long 33
.long 34
.long 35
.long 37
.long 41
.long 43
.long 44
/*20*/
.long 48
.long 49
.long 51
.long 55
.long 57
.long 58
.long 60
.long 61
.long 65
.long 69
/*30*/
.long 70
.long 72
.long 73
.long 77
.long 78
.long 80
.long 81
.long 83
.long 87
.long 89
/*40*/
.long 91
.long 93
.long 97
.long 99
.long 103
.long 104
.long 106
.long 107
.long 109
.long 110



 
SecondBlock:
.long 0
.long 4
.long 9
.long 49
.long 64
.long 100
.long 121
.long 225
.long 361
.long 441
.long 484
/*10*/
.long 576
.long 784
.long 841
.long 1089
.long 1156
.long 1225
.long 1369
.long 1681
.long 1849
.long 1936
/*20*/
.long 2304
.long 2401
.long 2601
.long 3025
.long 3249
.long 3364
.long 3600
.long 3721
.long 4225
.long 4761
/*30*/
.long 4900
.long 5184
.long 5329
.long 5929
.long 6084
.long 6400
.long 6561
.long 6889
.long 7569
.long 7921
/*40*/
.long 8281
.long 8649
.long 9409
.long 9801
.long 10609
.long 10816
.long 11236
.long 11449
.long 11881
.long 12100


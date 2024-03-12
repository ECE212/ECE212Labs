/* DO NOT MODIFY THIS --------------------------------------------*/
.text
.global Stats
.extern iprintf
.extern cr
.extern value
.extern getstring
/*----------------------------------------------------------------*/

/******************************************************************/
/* General Information ********************************************/
/* File Name: Lab3b.s **************************************/
/* Names of Students: _________________ and ____________________ **/
/* Date: _________________                                       **/
/* General Description:                                          **/
/*                                                               **/
/******************************************************************/
Stats:
/*Write your program here******************************************/
sub.l #40, %a7
movem.l %a2-%a5/%d2-%d7, (%a7)


.equ Min, 0
.equ Max, 4
.equ Mean, 8
.equ Divisible, 12


/* a2 array index, a3 results
d2 divisable
d3 entries
d4 dummy variable
d5 number of div
d6 counter
 */
move.l %d3, %d6

clr.l %d5
clr.l Mean(%a3)
move.l (%a2), %d4
move.l %d4, Min(%a3)
move.l %d4, Max(%a3)

Loop:
move.l (%a2)+, %d4
cmp.l Min(%a3), %d4
blt min
Return1:
cmp.l Max(%a3), %d4
bgt max
Return2:
add.l %d4, Mean(%a3)


divu.w %d2, %d4

lsr.l #8, %d4
lsr.l #8, %d4

beq div
Return3:
sub.l #1, %d6
bne Loop
bra end


min:
move.l %d4, Min(%a3)
bra Return1

max:
move.l %d4, Max(%a3)
bra Return2

div:

move.l %d5, %d4
muls.w #4, %d4
move.l -(%a2), Divisible(%a3, %d4)
add.l #4, %a2
add.l #1, %d5
bra Return3

end:
move.l Mean(%a3), %d4
divu.l %d3, %d4
move.l %d4, Mean(%a3)
move.l %d5, 52(%sp)
movem.l (%a7), %a2-%a5/%d2-%d7
add.l #40, %a7

rts 

/*End of Subroutine **************************************************/ 
.data
/*All Strings placed here **************************************************/



/*End of Strings **************************************************/

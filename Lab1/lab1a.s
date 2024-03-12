/* DO NOT MODIFY THIS --------------------------------------------*/
.text

.global AssemblyProgram

AssemblyProgram:
lea      -40(%a7),%a7 /*Backing up data and address registers */
movem.l %d2-%d7/%a2-%a5,(%a7)
/*----------------------------------------------------------------*/

/******************************************************************/
/* General Information ********************************************/
/* File Name: Lab1a.s *********************************************/
/* Names of Students: Darius Fang and Marlene Gong*****************/
/* Date: Feb 5 2020                                              **/
/* General Description:                                          **/
/*                                                               **/
/******************************************************************/

/*Write your program here******************************************/


movea.l #0x43000000, %a2
move.l (%a2), %d2

movea.l #0x43100000, %a3
move.l (%a3), %d3

cmpi.l #0x0d, %d2
beq done
bra compare

LOOP:
move.l %d3, (%a3)
adda.l #4, %a2
move.l (%a2), %d2

adda.l #4, %a3
move.l (%a3), %d3

cmpi.l #0x0d, %d2
beq done
bra compare



compare:

cmpi.l #0x30, %d2
blt ERROR

cmpi.l #0x3A, %d2
blt DEC

cmpi.l #0x40, %d2
blt ERROR

cmpi.l #0x47, %d2
blt UPPER

cmpi.l #0x61, %d2
blt ERROR

cmpi.l #0x67, %d2
blt LOWER
bra ERROR

ERROR:
move.l #0xFFFFFFFF, %d3
bra LOOP

DEC:
move.l %d2, %d3
sub.l #0x30, %d3
bra LOOP

LOWER:

move.l %d2, %d3
sub.l #87, %d3
bra LOOP

UPPER:

move.l %d2, %d3
sub.l #55, %d3
bra LOOP

done:


/*End of program **************************************************/

/* DO NOT MODIFY THIS --------------------------------------------*/
movem.l (%a7),%d2-%d7/%a2-%a5 /*Restore data and address registers */
lea      40(%a7),%a7 
rts
/*----------------------------------------------------------------*/

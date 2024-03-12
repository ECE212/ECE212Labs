/* DO NOT MODIFY THIS --------------------------------------------*/
.text

.global AssemblyProgram

AssemblyProgram:
lea      -40(%a7),%a7 /*Backing up data and address registers */
movem.l %d2-%d7/%a2-%a5,(%a7)
/*----------------------------------------------------------------*/

/******************************************************************/
/* General Information ********************************************/
/* File Name: Lab2a.s *********************************************/
/* Names of Students: _________________ and ____________________ **/
/* Date: _________________                                       **/
/* General Description:                                          **/
/*                                                               **/
/******************************************************************/

/*Write your program here******************************************/

/*Part A **********************************************************/

move.l (0x43000004), %a2
move.l (0x43000008), %a3
move.l (0x4300000C), %a4

move.l (%a2), %d2
add.l (%a3), %d2
move.l %d2, (%a4)

move.l 4(%a2), %d2
add.l 4(%a3), %d2
move.l %d2, 4(%a4)

move.l 8(%a2), %d2
add.l 8(%a3), %d2
move.l %d2, 8(%a4)


/*Part B **********************************************************/
move.l (0x43000010), %a4
move.l (0x43000000), %d1
clr.l %d4
clr.l %d5
cmp.l %d1, %d5
ble loop

loop:
move.l (%a2, %d4), %d2
add.l (%a3, %d4), %d2
move.l %d2, (%a4, %d4)
add.l #1, %d5
add.l #4, %d4
cmp.l %d1, %d5
ble loop



/*Part C **********************************************************/

move.l (0x43000014), %a4
clr.l %d4
bra loop1


loop1:
move.l (%a2)+, %d2
add.l (%a3)+, %d2
move.l %d2, (%a4)+
add.l #1, %d4
cmp.l %d1, %d4
ble loop1


/*End of program **************************************************/

/* DO NOT MODIFY THIS --------------------------------------------*/
movem.l (%a7),%d2-%d7/%a2-%a5 /*Restore data and address registers */
lea      40(%a7),%a7 
rts
/*----------------------------------------------------------------*/

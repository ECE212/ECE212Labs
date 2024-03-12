/* DO NOT MODIFY THIS --------------------------------------------*/
.text

.global AssemblyProgram

AssemblyProgram:
lea      -40(%a7),%a7 /*Backing up data and address registers */
movem.l %d2-%d7/%a2-%a5,(%a7)
/*----------------------------------------------------------------*/

/******************************************************************/
/* General Information ********************************************/
/* File Name: Lab2.s *********************************************/
/* Names of Students: _________________ and ____________________ **/
/* Date: _________________                                       **/
/* General Description:                                          **/
/*                                                               **/
/******************************************************************/

/*Write your program here******************************************/

move.l (0x43000000), %d2 /* number of points */

move.l (0x43000004), %a2 /* x */
move.l (0x43000008), %a3 /* y */

move.l (0x43000010), %a4 /* sum of trapizoid area */
clr.l (%a4)
clr.l %d5 /* area */
move.l #1, %d6

loop:

move.l 4(%a2), %d3
sub.l (%a2)+, %d3 /* delta x */
move.l 4(%a3), %d4
add.l (%a3)+, %d4 /* sum of y */

cmpi.l #2, %d3
beq double /* x is 2 */
bgt quad /* x is 4 */
bra compare /* x is 1 */

double:
lsl.l #1, %d4
bra compare

quad:
lsl.l #2, %d4
bra compare

compare:
add.l %d4, %d5 /* add to area */
add.l #1, %d6
cmp.l %d2, %d6
blt loop

lsr.l #1, %d5 /* half the area */
move.l %d5, (%a4) /* return */















/*End of program **************************************************/

/* DO NOT MODIFY THIS --------------------------------------------*/
movem.l (%a7),%d2-%d7/%a2-%a5 /*Restore data and address registers */
lea      40(%a7),%a7 
rts
/*----------------------------------------------------------------*/

/* DO NOT MODIFY THIS --------------------------------------------*/
.text
.global LedSub
.extern cr
.extern iprintf
.extern getchr
.extern TurnOnLed
.extern TurnOffLed
.extern Row
.extern Column
.extern Delay
/*----------------------------------------------------------------*/

/******************************************************************/
/* General Information *******************************************************/
/* File Name: Lab4c.s ********************************************************/
/* Names of Students: Darius Fang and Marlene Gong *******************/
/* IDs: 1570975 and 1572719 ***********************************************/
/* Date: April 1, 2020 *********************************************************/
/* General Description: Subroutine uses pattern address to display      **/
/* a pattern on the LED array                                                                  **/
/******************************************************************/
LedSub:
/*Write your program here******************************************/

sub.l #40, %a7                    /* preserve registers ... */
movem.l %a2-%a5/%d2-%d7, (%a7)    /* ...except for stack pointer  */

move.l 44(%sp), %a2               /* set a2 to point at pattern address */

/* d2 value
d3 count column
d4 count rows
d5 pointer
*/

clr.l %d2                        /* clear d2 */
clr.l %d3                        /* clear d3, column 0 */
clr.l %d4                        /* clear d4, row 0 */

move.l #7, d5                    /* move 7 to d5 */

nextRow:
cmp.l #8, %d4                    /* otherwise, compare row number with 8 */
bge end                        	 /* if greater than or equal to, branch to end */
move.b (%a2, %d4), %d2           /* otherwise, increment a2 pointer by d4, copy byte to d2 */
add.l #1, %d4                    /* add 1 to the row number */
bra nextCol                    	 /* branch to nextCol */

nextCol:
cmp.l #8, %d3                    /* otherwise, compare column number with 8 */
bge finalCol                     /* if greater than or equal to, branch to finalCol */
move.l %d3, %d6                  /* otherwise, copy column number to d6 */
sub.l %d5, %d6                   /* subtract 7 from column number */
neg.l %d6                        /* negative result */
btst.b %d6, %d2                  /* test bit targeted by result */
bne turnOn                    	 /* if bit isn’t 0, branch to turnOn */
add.l #1, %d3                    /* add 1 to column number */
bra nextCol                      /* branch to nextCol */

finalCol:
clr.l %d3                        /* clear d3, column 0 */
bra nextRow                      /* branch to nextRow */

turnOn:
move.l %d3, -(%a7)               /* push column number onto stack */
jsr Column                       /* jump to Column subroutine */
add.l #4, %a7                    /* clean up stack */

move.l %d4, -(%a7)               /* push row number onto stack */
jsr Row                          /* jump to Row subroutine */
add.l #4, %a7                    /* clean up stack */

jsr TurnOnLed                    /* jump to TurnOnLed subroutine */

move.l #300, -(%a7)              /* push delay time (300ms) onto stack */
jsr Delay                        /* jump to Delay subroutine */
add.l #4, %a7                    /* clean up stack */

jsr TurnOffLed                   /* jump to TurnOffLed subroutine */


add.l #1, %d3                    /* add 1 to row number */
bra nextCol                      /* branch to nextCol */

end:
movem.l (%a7), %a2-%a5/%d2-%d7   /* restore registers */
add.l #40, %a7                   /* stack pointer points at return address */

rts                              /* return to main program */

/*End of Subroutine **************************************************/ 
.data
/*All Strings placed here **************************************************/



/*End of Strings **************************************************/
/******************************************************/

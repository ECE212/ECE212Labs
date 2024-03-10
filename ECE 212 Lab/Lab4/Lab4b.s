/* DO NOT MODIFY THIS --------------------------------------------*/
.text
.global convert
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
/* File Name: Lab4b.s ********************************************************/
/* Names of Students: Darius Fang and Marlene Gong *******************/
/* IDs: 1570975 and 1572719 ***********************************************/
/* Date: April 1, 2020 *********************************************************/
/* General Description: Subroutine converts user input into a               **/
/* pattern address                                                                                  **/
/******************************************************************/
convert:
/*Write your program here******************************************/

sub.l #40, %a7                    /* preserve registers ... */
movem.l %a2-%a5/%d2-%d7, (%a7)    /* ...except for stack pointer  */

move.l 44(%sp), -(%sp)            /* push user input onto stack */
jsr convert1                      /* jump to subroutine convert1 */
move.l (%sp)+, %d2                /* copy pattern address to d2 */
move.l %d2, 44(%sp)               /* pass pattern address as output parameter */

movem.l (%a7), %a2-%a5/%d2-%d7    /* restore registers */
add.l #40, %a7                    /* stack pointer points at return address */

rts                               /* return to main program */

/*End of Subroutine **************************************************/ 
.data
/*All Strings placed here **************************************************/


/*End of Strings **************************************************/

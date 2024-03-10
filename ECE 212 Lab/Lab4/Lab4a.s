/* DO NOT MODIFY THIS --------------------------------------------*/
.text
.global WelcomePrompt
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
/* General Information ********************************************************/
/* File Name: Lab4a.s ********************************************************/
/* Names of Students: Darius Fang and Marlene Gong *******************/
/* IDs: 1570975 and 1572719 ***********************************************/
/* Date: April 1, 2020 *********************************************************/
/* General Description: Subroutine will prompt user to enter an upper **/
/* case letter or number from the keyboard                                           **/
/******************************************************************/
WelcomePrompt:
/*Write your program here******************************************/

sub.l #40, %a7                    /* preserve registers ... */
movem.l %a2-%a5/%d2-%d7, (%a7)    /* ...except for stack pointer  */

pea Greeting                      /* push welcome string onto stack */
jsr iprintf                       /* jump to iprintf subroutine, print string */
jsr cr                            /* jump to cr subroutine, generate carriage return and linefeed */
addq.l #4, %sp                    /* clean up stack */

pea Entry                         /* push entry prompt string onto stack */
jsr iprintf                       /* jump to iprintf subroutine, print string */
jsr cr                            /* jump to cr subroutine, generate carriage return and linefeed */
addq.l #4, %sp                    /* clean up stack */

GetEntry:
jsr getchr                        /* jump to getchr subroutine, store user input in d0 */
move.l %d0, %d2                   /* copy user input into d2 */
move.l %d2, -(%sp)                /* push user input onto stack */
jsr putchr                        /* jump to putchr subroutine, display user input */
add.l #4, %sp                     /* clean up stack */
jsr cr                            /* jump to cr subroutine, generate carriage return and linefeed */

cmp.l #0x30, %d2                  /* compare user input with 0x30 (ASCII 0) */
blt ERROR                         /* if less than, branch to ERROR */
cmp.l #0x39, %d2                  /* otherwise, compare user input to 0x39 (ASCII 9) */
ble END                           /* if less than or equal to, branch to END */
cmp.l #0x41, %d2                  /* otherwise, compare user input to 0x41 (ASCII A) */
blt ERROR                         /* if less than, branch to ERROR */
cmp.l #0x5A, %d2                  /* otherwise, compare user input to 0x5A (ASCII Z) */
ble END                           /* if less than or equal to, branch to END */


ERROR:
pea Error_str                     /* otherwise, push error string onto stack */
jsr iprintf                       /* jump to iprintf subroutine, print string */
jsr cr                            /* jump to cr subroutine, generate carriage return and linefeed */
addq.l #4, %sp                    /* clean up stack */
bra GetEntry                      /* branch to GetEntry */


END:
move.l %d2, 44(%sp)               /* pass user input as output parameter */

movem.l (%a7), %a2-%a5/%d2-%d7    /* restore registers */
add.l #40, %a7                    /* stack pointer points at return address */

rts                               /* return to main program */

/*End of Subroutine **************************************************/ 
.data
/*All Strings placed here **************************************************/

Greeting:
.string "Welcome to Wing's LED Display"

Entry:
.string "Please enter an UpperCase letter or Number from the keyboard"

Error_str:
.string "Invalid entry, please enter proper keystroke from keyboard"


/*End of Strings **************************************************/
/******************************************************/

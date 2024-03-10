/* DO NOT MODIFY THIS --------------------------------------------*/
.text
.global WelcomePrompt
.extern iprintf
.extern cr
.extern value
.extern getstring
/*----------------------------------------------------------------*/

/******************************************************************/
/* General Information ********************************************/
/* File Name: Lab3a.s **************************************/
/* Names of Students: _________________ and ____________________ **/
/* Date: _________________                                       **/
/* General Description:                                          **/
/*                                                               **/
/******************************************************************/
WelcomePrompt:
/*Write your program here******************************************/

sub.l #40, %a7
movem.l %a2-%a5/%d2-%d7, (%a7)


move.l #0x43000000, %a2
clr.l %d5

pea Greeting
jsr iprintf
jsr cr
addq.l #4, %sp
move.l #0, %d3

get_entry:
move.l #0, %d5
pea Entries
jsr iprintf
jsr cr
addq.l #4, %sp
jsr getstring

move.l %d0, %d2
move.l %d2, -(%sp)
jsr value
add.l #4, %sp
jsr cr
move.l %d2, 48(%sp)


cmp.l #3, %d2
blt error_input
cmp.l #15, %d2
ble get_div
bra error_input


get_div:
move.l #1, %d5
move.l %d2, %d4
sub.l #1, %d4


pea Divisor
jsr iprintf
jsr cr
addq.l #4, %sp
jsr getstring


move.l %d0, %d2

move.l %d2, -(%sp)
jsr value
add.l #4, %sp
move.l %d2, 44(%sp)
jsr cr

cmp.l #2, %d2
blt error_input
cmp.l #5, %d2
ble get_posNum
bra error_input


get_posNum:
move.l #2, %d5
pea posNumber
jsr iprintf
jsr cr
addq.l #4, %sp
jsr getstring


move.l %d0, %d2

move.l %d2, -(%sp)
jsr value
addq.l #4, %sp
jsr cr

cmp.l #0, %d2
ble error_input
move.l %d2, (%a2)+
sub.l #1, %d4

bne get_posNum
bra get_lastNum

get_lastNum:
move.l #3, %d5
pea lastNumber
jsr iprintf
jsr cr
addq.l #4, %sp
jsr getstring


move.l %d0, %d2

move.l %d2, -(%sp)
jsr value
addq.l #4, %sp
jsr cr

cmp.l #0, %d2
ble error_input
move.l %d2, (%a2)+
bra end




error_input:
pea Invalid
jsr iprintf
jsr cr
addq.l #4, %sp
cmp.l #0, %d5
beq get_entry
cmp.l #1, %d5
beq get_div
cmp.l #2, %d5
beq get_posNum
cmp.l #3, %d5
beq get_lastNum



end:

movem.l (%a7), %a2-%a5/%d2-%d7
add.l #40, %a7
rts

/*End of Subroutine **************************************************/ 
.data
/*All Strings placed here **************************************************/
Greeting:
.string "Welcome to Wing's Stats Program"

Entries:
.string "Please enter the number(3min-15max) of entries followed by 'enter'"

Divisor:
.string "Please enter the divisor(2min-5max) followed by 'enter'"

posNumber:
.string "Please enter a number(positive only)"

lastNumber:
.string "Please enter the last number(positive only)"

Invalid:
.string "Invalid entry, please enter proper value."


/*End of Strings **************************************************/


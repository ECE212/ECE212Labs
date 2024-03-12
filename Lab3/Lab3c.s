/* DO NOT MODIFY THIS --------------------------------------------*/
.text
.global Display
.extern iprintf
.extern cr
.extern value
.extern getstring
/*----------------------------------------------------------------*/

/******************************************************************/
/* General Information ********************************************/
/* File Name: Lab3c.s **************************************/
/* Names of Students: _________________ and ____________________ **/
/* Date: _________________                                       **/
/* General Description:                                          **/
/*                                                               **/
/******************************************************************/
Display:
/*Write your program here******************************************/
sub.l #40, %a7
movem.l %a2-%a5/%d2-%d7, (%a7)



pea numEntries
jsr iprintf
addq.l #4, %sp
move.l %d3, -(%sp)
jsr value
jsr cr
add.l #4, %sp

loop:
move.l (%a2)+, %d5
move.l %d5, -(%sp)
jsr value
add.l #4, %sp
jsr cr
sub.l #1, %d3
bne loop

movea.l #0x43100000, %a2
pea minNum
jsr iprintf
add.l #4, %sp
move.l (%a2)+, %d3
move.l %d3, -(%sp)
jsr value
add.l #4, %sp
jsr cr

pea maxNum
jsr iprintf
add.l #4, %sp
move.l (%a2)+, %d3
move.l %d3, -(%sp)
jsr value
add.l #4, %sp
jsr cr

pea meanNum
jsr iprintf
add.l #4, %sp
move.l (%a2)+, %d3
move.l %d3, -(%sp)
jsr value
add.l #4, %sp
jsr cr

pea ThereAre
jsr iprintf
add.l #4, %sp
move.l %d4, -(%sp)
jsr value
add.l #4, %sp

pea divisible
jsr iprintf
add.l #4, %sp
move.l %d2, -(%sp)
jsr value
add.l #4, %sp
jsr cr

pea TheyAre					
jsr iprintf						
add.l #4, %sp					

divLoop:
pea space					
jsr iprintf						
add.l #4, %sp					
move.l (%a2)+, %d3			
move.l %d3, -(%sp)					
jsr value						
add.l #4, %sp					
sub.l #1, %d4					
bne divLoop				
jsr cr

pea end
jsr iprintf
add.l #4, %sp
jsr cr

movem.l (%a7), %a2-%a5/%d2-%d7
add.l #40, %a7

rts 

/*End of Subroutine **************************************************/ 
.data
/*All Strings placed here **************************************************/


numEntries:
.string "The number of entries was "

minNum:
.string "Min number = "

maxNum:
.string "Max number = "

meanNum:
.string "Mean number = "

ThereAre:
.string "There are "

TheyAre:
.string “They are”

space:
.string “ “

divisible:
.string " number(s) divisible by "

end:
.string "Program ended"



/*End of Strings **************************************************/

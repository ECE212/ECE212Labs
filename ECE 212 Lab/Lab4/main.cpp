#include <predef.h>
#include <stdio.h>
#include <ctype.h>
#include <startnet.h>
#include <autoupdate.h>
#include <NetworkDebug.h>
#include <pins.h>
#include <sim.h>

extern "C" {
void UserMain(void * pd);
}
/* Where we define our functions */
extern "C" {
	void AssemblyProgram();
	void WelcomePrompt();
	void LedSub();
	void convert();
	void convert1();
	void TurnOnLed(); /*Subroutine to turn on 1 LED*/
	void TurnOffLed(); /*Subroutine to turn off 1 LED*/
	void Row(int B); /*Subroutine to control which row */
	void Column(int C);	/*Subroutine to control which column*/
	void Delay(int D); /*delay subroutine*/
	int getchr(); /*function to get value of keyboard character*/
	void cr(); /*Carriage return and line feed subroutine*/
	void putchr(int B);
	int getstring(); /*Subroutine to get numerical value from keyboard*/
	void value1(int P1);
	void value(int P1); /*Subroutine to print decimal value to monitor*/
}
void value(int P1)
{
		iprintf( "\%d\n", P1);
}
/*****************************************************
A Subroutine that gets a numerical value from the keyboard
Input = nothing
Output = numerical value in register D0
This subroutine includes buffer check by clearing the buffer
if a wrong input is given and prompts the user to re-enter
a valid number
*****************************************************/
int number;
int getstring()
{
			int r;
repeat:		r = scanf("%d", &number );
/*******************************************
 * clears the buffer if a wrong input is given
*********************************************/
		if (r==0)
		{	getchar();
			iprintf("\n");
			iprintf("Not a number entered, please enter valid number \n");
			goto repeat;
		}
			return number;
}

void value1(int P1)
{
		iprintf( "0x\%X\n", P1);
}
/*****************************************************
 *Turn on LED subroutine. This outputs pin 31 high which is
 tied to the enable pins on the 3-8 decoder chips
 Input parameter = nothing
 Outpt parameter = nothing
 *****************************************************/
void TurnOnLed()

{		J2[31].set();

}
/*****************************************************
 *Turn off LED subroutine. This outputs pin 31 low which is
 tied to the enable pins on the 3-8 decoder chips
 Input parameter = nothing
 Outpt parameter = nothing
 *****************************************************/
void TurnOffLed()
{		J2[31].clr();

}
/*****************************************************
A subroutine to choose which column on the LED array
to control
Input parameter - column number(#0=col0,#7=col7)
******************************************************/
void Column(int C)
{
if (C==0)
{
	//GPIO
	J2[25].clr();J2[26].clr();J2[27].clr();
}
	else
	if (C==1)
	{

		J2[25].set();J2[26].clr();J2[27].clr();
	}
	else
	if (C==2)
	{

		J2[25].clr();J2[26].set();J2[27].clr();
	}
	else
	if (C==3)
	{

		J2[25].set();J2[26].set();J2[27].clr();
	}
	else
	if (C==4)
	{

		J2[25].clr();J2[26].clr();J2[27].set();
	}
	else
	if (C==5)
	{

		J2[25].set();J2[26].clr();J2[27].set();
	}
	else
	if (C==6)
	{

		J2[25].clr();J2[26].set();J2[27].set();
	}
	else
	if (C==7)
	{

		J2[25].set();J2[26].set();J2[27].set();
	}
	else
	if (C>7)
	{
		iprintf("column error\n");
	}
	else
	iprintf("column good\n");
}
/*****************************************************
A subroutine to choose which row on the LED array
to control
Input parameter - row number(#0=row0,#7=row7)
******************************************************/
void Row(int B)
{
if (B==0)
{

	J2[28].clr();J2[29].clr();J2[30].clr();
}
	else
	if (B==1)
	{

	J2[28].set();J2[29].clr();J2[30].clr();
	}
	else
	if (B==2)
	{

		J2[28].clr();J2[29].set();J2[30].clr();
	}
	else
	if (B==3)
	{

		J2[28].set();J2[29].set();J2[30].clr();
	}
	else
	if (B==4)
	{

		J2[28].clr();J2[29].clr();J2[30].set();
	}
	else
	if (B==5)
	{

		J2[28].set();J2[29].clr();J2[30].set();
	}
	else
	if (B==6)
	{

		J2[28].clr();J2[29].set();J2[30].set();
	}
	else
	if (B==7)
	{

		J2[28].set();J2[29].set();J2[30].set();
	}
	else
	if (B>7)
	{
		iprintf("row error\n");
	}
	else
	iprintf("row good\n");
}
/*****************************************************
A subroutine to delay.
Input parameter = delay time
Output paramter = nothing
******************************************************/
void Delay(int D)
{
  int x = 0;

while (x<D) {

   iprintf("");
x++;
}
}

/*****************************************************
A function to get character from the keyboard
Input = nothing
Output = places the Ascii character input into data
register D0
*****************************************************/
int getchr()
{
			return getchar();
}
void putchr(int B)
{
			putchar(B);
}
/****************************************************
Carriage return and line feed function
Input = nothing
Output = nothing
*****************************************************/
void cr()
{
		iprintf( "\r\n");
}

const char * AppName="ECELab4Mod54115HardwareVerificationProgram";

void UserMain(void * pd) {
    InitializeStack();
    OSChangePrio(MAIN_PRIO);
    EnableAutoUpdate();

    #ifdef _DEBUG
    InitializeNetworkGDB_and_Wait();
    #endif
    iprintf("Application started\n");
    /*****************************************************
    Configure ports 15,16,19,20,23,24,31,37 as general purpose I/O. They are also tied to the board LEDS
    *****************************************************/



    	J2[25].function(PINJ2_25_GPIO);
    	J2[26].function(PINJ2_26_GPIO);
    	J2[27].function(PINJ2_27_GPIO);
    	J2[28].function(PINJ2_28_GPIO);
    	J2[29].function(PINJ2_29_GPIO);
    	J2[30].function(PINJ2_30_GPIO);
    	J2[31].function(PINJ2_31_GPIO);


    	OSTimeDly(100);
    while (1) {
    	AssemblyProgram();
        OSTimeDly(20);
    }
}

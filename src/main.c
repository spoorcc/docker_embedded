#include  <msp430g2553.h>

volatile unsigned int i = 0;

#define LED1 0x01

void main(void)
{
  //Shutdown the watchdog
  WDTCTL = WDTPW + WDTHOLD;
  P1DIR |= LED1;

  for (;;)
  {
    P1OUT ^= LED1;

    for(i=0; i< 20000; i++);
  }
}

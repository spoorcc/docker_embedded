#include <stdint.h>
#include "stm8s208s.h"

void main(void)
{
    CLK_CKDIVR = 0x00; // Set the frequency to 16 MHz
    //CLK_PCKENR1 |= PCKEN17; // Enable clock to timer
    __asm__ ("	bset	0x50c7, #7");

    // Configure timer
    // 1000 ticks per second
    TIM1_PSCRH = (16000>>8);
    TIM1_PSCRL = (uint8_t)(16000 & 0xff);
    // Enable timer
    TIM1_CR1 = 0x01;

    /* Set PB0 as output */
    //PB_DDR |= (GPIO_OUTPUT_MODE<<PIN0);
    __asm__ ("	bset	0x5007, #0");

    /* Set low speed mode */
    //PB_CR2 &= ~(0x01<<PIN0);
    __asm__ ("	bres	0x5009, #0");

    /* Set Push/Pull mode */
    //PB_CR1 |= (0x01<<PIN0);
    __asm__ ("	bset	0x5008, #0");


    for(;;)
    {
        if (((unsigned char)TIM1_CNTRL) % 1000 <= 500) {
            //PB_ODR ^= (0x01<<PIN0);
            __asm__ ("	bcpl	0x5005, #0");
        }
    }
}

#include <stdint.h>
#include "stm8s208s.h"

unsigned int clock(void)
{
    unsigned char h = TIM1_PCNTRH;
    unsigned char l = TIM1_PCNTRL;
    return((unsigned int)(h) << 8 | l);
}

void main(void)
{
    CLK_DIVR = 0x00; // Set the frequency to 16 MHz
    CLK_PCKENR2 |= 0x02; // Enable clock to timer

    // Configure timer
    // 1000 ticks per second
    TIM1_PSCRH = 0x3e;
    TIM1_PSCRL = 0x80;
    // Enable timer
    TIM1_CR1 = 0x01;

    /* Set PB0 as output */
    PB_DDR |= (GPIO_OUTPUT_MODE<<PIN0);

    /* Set Push/Pull mode */
    PB_CR1 |= (0x01<<PIN0);

    /* Set low speed mode */
    PB_CR2 |= (0x00<<PIN0);

    for(;;)
    {
        if (clock() % 1000 <= 500)
            PB_ODR ^= (0x01<<PIN0);
    }
}

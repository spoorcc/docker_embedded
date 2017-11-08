#include <stdint.h>
#include "stm8s208s.h"

void main(void)
{
    MEMLOC(CLK_CKDIVR) = 0x00; // Set the frequency to 16 MHz
    BITSET(CLK_PCKENR1, 7);

    // Configure timer
    // 1000 ticks per second
    MEMLOC(TIM1_PSCRH) = (16000>>8);
    MEMLOC(TIM1_PSCRL) = (uint8_t)(16000 & 0xff);
    // Enable timer
    MEMLOC(TIM1_CR1) = 0x01;

    /* Set PB0 as output */
    BITSET(PB_DDR, 0);

    /* Set low speed mode */
    BITRST(PB_CR2, 0);

    /* Set Push/Pull mode */
    BITSET(PB_CR1, 0);

    for(;;)
    {
        if ((MEMLOC(TIM1_CNTRL)) % 1000 <= 500) {
            BITTOG(PB_ODR, 0);
        }
    }
}

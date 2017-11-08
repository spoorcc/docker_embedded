#include <stdint.h>
#include "stm8s208s.h"

void main(void)
{
    MEMLOC(CLK_CKDIVR) = 0x00; /* Set the frequency to 16 MHz */
    BITSET(CLK_PCKENR1, 7); /* Enable clk to TIM1 */

    // Configure timer
    // 250 ticks per second
    MEMLOC(TIM1_PSCRH) = (64000>>8);
    MEMLOC(TIM1_PSCRL) = (uint8_t)(64000 & 0xff);

    MEMLOC(TIM1_CR1) = 0x01; /* Enable timer */

    BITSET(PB_DDR, 0); /* Set PB0 as output */
    BITRST(PB_CR2, 0); /* Set low speed mode */
    BITSET(PB_CR1, 0); /* Set Push/Pull mode */

    for(;;) {
        if ((MEMLOC(TIM1_CNTRL)) % 250 <= 125) {
            BITTOG(PB_ODR, 0);
        }
    }
}

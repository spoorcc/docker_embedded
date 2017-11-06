#pragma once

#include <stdint.h>

#define PB_ODR   (*(volatile uint8_t *)0x5005)
#define PB_IDR   (*(volatile uint8_t *)0x5006)
#define PB_DDR   (*(volatile uint8_t *)0x5007)
#define PB_CR1   (*(volatile uint8_t *)0x5008)
#define PB_CR2   (*(volatile uint8_t *)0x5009)

#define CLK_CKDIVR   (*(volatile uint8_t *)0x50c6)
#define CLK_PCKENR1   (*(volatile uint8_t *)0x50c7)
#define PCKEN17 (0x01<<7) /* Enables clock to TIM1 */
#define CLK_PCKENR2   (*(volatile uint8_t *)0x50ca)


#define TIM1_CR1   (*(volatile uint8_t *)0x5250)
#define TIM1_CNTRH   (*(volatile uint8_t *)0x52bf)
#define TIM1_CNTRL   (*(volatile uint8_t *)0x52c0)
#define TIM1_PSCRH   (*(volatile uint8_t *)0x5260)
#define TIM1_PSCRL   (*(volatile uint8_t *)0x5261)

#define PIN0 (0)
#define PIN1 (1)
#define PIN2 (2)
#define PIN3 (3)
#define PIN4 (4)
#define PIN5 (5)
#define PIN6 (6)
#define PIN7 (7)

#define GPIO_INPUT_MODE (0x00)
#define GPIO_OUTPUT_MODE (0x01)

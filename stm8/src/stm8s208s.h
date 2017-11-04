#pragma once

#include <stdint.h>

#define PB_ODR   (*(volatile uint8_t *)0x5005)
#define PB_IDR   (*(volatile uint8_t *)0x5005)
#define PB_DDR   (*(volatile uint8_t *)0x5007)
#define PB_CR1   (*(volatile uint8_t *)0x5008)
#define PB_CR2   (*(volatile uint8_t *)0x5009)

#define CLK_DIVR   (*(volatile uint8_t *)0x50c0)
#define CLK_PCKENR2   (*(volatile uint8_t *)0x50c4)

#define TIM1_CR1   (*(volatile uint8_t *)0x52b0)
#define TIM1_PCNTRH   (*(volatile uint8_t *)0x52bf)
#define TIM1_PCNTRL   (*(volatile uint8_t *)0x52c0)
#define TIM1_PSCRH   (*(volatile uint8_t *)0x52c1)
#define TIM1_PSCRL   (*(volatile uint8_t *)0x52c2)

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

#pragma once

#include <stdint.h>

#define STR(x)   #x
#define XSTR(x)  STR(x)
#define BITSET(addr, bit) __asm__("	bset	"XSTR(addr)", #"XSTR(bit));
#define BITRST(addr, bit) __asm__("	bres	"XSTR(addr)", #"XSTR(bit));
#define BITTOG(addr, bit) __asm__("	bcpl	"XSTR(addr)", #"XSTR(bit));
#define MEMLOC(addr) (*(volatile uint8_t *)addr)

#define PB_ODR   0x5005
#define PB_IDR   0x5006
#define PB_DDR   0x5007
#define PB_CR1   0x5008
#define PB_CR2   0x5009

#define CLK_CKDIVR   0x50c6
#define CLK_PCKENR1   0x50c7
#define PCKEN17 (0x01<<7) /* Enables clock to TIM1 */
#define CLK_PCKENR2   0x50ca

#define TIM1_CR1    0x5250
#define TIM1_CNTRH  0x52bf
#define TIM1_CNTRL  0x52c0
#define TIM1_PSCRH  0x5260
#define TIM1_PSCRL  0x5261


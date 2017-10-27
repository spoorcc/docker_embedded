#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
    DDRB |= (1 << PIN5);
    PORTB = 0x00;

    for(;;)
    {
        PORTB ^= (1 << PIN5);
        _delay_ms(500);
    }
}

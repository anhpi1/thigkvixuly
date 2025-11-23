#include <stdio.h>
#include <stdint.h>

uint16_t NUMBERS[][2]= {
    {0x10A0, 0x20E0}, 
    {0x30B0, 0x40F0},
    {0x50C0, 0x6000},
    {0x70D0, 0x8000}
};

uint16_t DIVISOR = 0x03E8;
uint16_t SUM_LOW = 0;
uint16_t SUM_HIGH = 0;
uint16_t QUOTIENT_LOW = 0;
uint16_t QUOTIENT_HIGH = 0;

int main()
{
    for (int i=0; i < 4; i++) {
        uint16_t val_low = NUMBERS[i][0];  
        uint16_t val_high = NUMBERS[i][1]; 

      
        uint16_t old_sum_low = SUM_LOW; 
        SUM_LOW += val_low;
        SUM_HIGH += val_high; 
    }

    uint32_t total_sum_32 = ((uint32_t)SUM_HIGH << 16) | SUM_LOW;
    uint32_t quotient = total_sum_32 / DIVISOR;
    
    QUOTIENT_LOW = quotient & 0xFFFF;       
    QUOTIENT_HIGH = (quotient >> 16) & 0xFFFF; 

    printf("SUM_LOW: 0x%04X, SUM_HIGH: 0x%04X\n", SUM_LOW, SUM_HIGH);
    printf("QUOTIENT_LOW: 0x%04X, QUOTIENT_HIGH: 0x%04X\n", QUOTIENT_LOW, QUOTIENT_HIGH);
    
    return 0;
}
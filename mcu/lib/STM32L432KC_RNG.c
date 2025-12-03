// STM32L432KC_RNG.c
// Source code for RNG functions
#include "STM32L432KC.h"
#include "STM32L432KC_RNG.h"
#include "STM32L432KC_RCC.h"

void initRNG(void)
{
    // 1. Enable RNG clock
    RCC->AHB2ENR |= RCC_AHB2ENR_RNGEN;
    RCC->CR |= RCC_CR_MSION;     // Enable MSI
    while (!(RCC->CR & RCC_CR_MSIRDY));
    // 2. Enable RNG
    RNG->CR |= RNG_CR_RNGEN;


    RNG->CR |= RNG_CR_IE;
}

uint32_t RNG_GetRandom(void)
{
    // Wait for data ready
    while (!(RNG_SR_DRDY)) {
        if (RNG->SR & (RNG_SR_SEIS | RNG_SR_CEIS)) {
            // Clear errors
            RNG->SR |= RNG_SR_SEIS | RNG_SR_CEIS;
            // Restart RNG
            RNG->CR &= ~RNG_CR_RNGEN;
            RNG->CR |= RNG_CR_RNGEN;
        }
    }
    return RNG->DR;
}

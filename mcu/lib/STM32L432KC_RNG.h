// STM32L432KC_RNG.h
// TODO: Kanoa Parker
// TODO: kanparker@g.hmc.edu
// TODO: 12/1/2025
// TODO: Modules for RNG on STM32L432KC

#ifndef STM32L432KC_RNG_H
#define STM32L432KC_RNG_H

#include <stdint.h>
#include <stm32l432xx.h>

void initRNG(void);
uint32_t RNG_GetRandom(void);

#endif
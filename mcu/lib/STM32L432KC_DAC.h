// STM32L432KC_DAC.h
// TODO: Kanoa Parker
// TODO: kanparker@g.hmc.edu
// TODO: 11/23/2025
// TODO: Modules for DAC on STM32L432KC

#ifndef STM32L432KC_DAC_H
#define STM32L432KC_DAC_H

#include <stdint.h>
#include <stm32l432xx.h>
#include "STM32L432KC_GPIO.h"

void DAC_init(void);
void DAC_set_value(uint16_t value);

#endif
// STM32L432KC_DAC.c
// Source code for DAC functions
#include "STM32L432KC.h"
#include "STM32L432KC_DAC.h"
#include "STM32L432KC_GPIO.h"
#include "STM32L432KC_RCC.h"


void DAC_init(void) {
  // Enable clock for DAC
  
  RCC->APB1ENR1 |= RCC_APB1ENR1_DAC1EN;
  // Configure GPIO pin for DAC output (e.g., PA4 for DAC1_OUT1)
  pinMode(PA4, GPIO_ANALOG);
  GPIOA->PUPDR &= ~GPIO_PUPDR_PUPD4;      // No pull-up, no pull-down


  // Configure DAC
  DAC->CR &= ~DAC_CR_EN1;                 // Disable DAC channel 1
  DAC->CR &= ~DAC_CR_TEN1;                 // Enable trigger for channel 1
  
  DAC->CR |= _VAL2FLD(DAC_CR_TSEL1, 0b111);   // Select software trigger
  
  /*
  DAC1->CCR = 0;                    // Offset trimming = 0 recommended
  DAC1->CR |= DAC_CR_CEN1;          // Start calibration

  // 8. Wait for calibration to finish
  while (!(DAC->SR & DAC_SR_CAL_FLAG1));

  DAC1->CR &= ~DAC_CR_CEN1;
  */
  DAC->CR |= DAC_CR_EN1;                  // Enable DAC channel 1
}

void DAC_set_value(uint16_t value) {
  if (value > 4095) {
    value = 4095; // Clamp value to 12-bit range
  }
  DAC->DHR12R1 = value; // Set the DAC output value for channel 1
  DAC->SWTRIGR |= DAC_SWTRIGR_SWTRIG1; // Trigger the DAC conversion
  
}




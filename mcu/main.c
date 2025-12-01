/*********************************************************************
*                    SEGGER Microcontroller GmbH                     *
*                        The Embedded Experts                        *
**********************************************************************

-------------------------- END-OF-HEADER -----------------------------

File    : main.c
Purpose : Generic application start

*/

#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "main.h"



volatile uint16_t spot = 0;
volatile int value = 0;
uint32_t delay = 250;
volatile uint16_t readings[100];
uint16_t check = 43690;
volatile uint16_t output;


void startup(void){
  configureFlash();
  configureClock();
  gpioEnable(GPIO_PORT_A);
  gpioEnable(GPIO_PORT_B);
  gpioEnable(GPIO_PORT_C);
  RCC->APB2ENR |= (RCC_APB2ENR_TIM15EN);
  initTIM(TIM15);
  initTIM(TIM6);
  DAC_init();
  initSPI(0b101, 1, 1); // SPI clk = master clk / 64, CPOL = 1, CPHA = 1
  pinMode(PA0,GPIO_OUTPUT);
  pinMode(PA1,GPIO_INPUT);
  pinMode(PA5,GPIO_OUTPUT);
  pinMode(Distortion_Pin, GPIO_INPUT);

}

uint16_t getvalue(void){
  while(!digitalRead(PA1));//Wait for SPI Signal to be ready to send data

  digitalWrite(PA0, GPIO_HIGH); //Load Signal High
  digitalWrite(PA11,GPIO_HIGH); //CE High
  return spiSendReceive(check);
  digitalWrite(PA11,GPIO_LOW); //CE LOW
  while(SPI1->SR & SPI_SR_BSY); // Confirm all SPI transactions are completed
  digitalWrite(PA0, GPIO_LOW); // Write LOAD low
  

}

uint16_t clipping(uint16_t audio_value){
  if(audio_value>=3000) return 3000;
  else if(audio_value<=1000) return 1000;
  else return audio_value;
}

int main(void){
  startup();
  
  

  while(1){
  
  if(spot>=100){
    spot = 0;
  }

  readings[spot]=getvalue();
  
  if(digitalRead(Distortion_Pin)){
    output = clipping(readings[spot]);
  }

  DAC_set_value(output);
}


}

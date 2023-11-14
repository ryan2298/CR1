/*****************************************************************//**
 * @file main_vanilla_test.cpp
 *
 * @brief Basic test of 4 basic i/o cores
 *
 * @author p chu
 * @version v1.0: initial release
 *********************************************************************/

//#define _DEBUG
#include "chu_init.h"
#include "gpio_cores.h"
#include "i2c_core.h"
#include "sseg_core.h"

/**
 * blink once per second for 5 times.
 * provide a sanity check for timer (based on SYS_CLK_FREQ)
 * @param led_p pointer to led instance
 */
void timer_check(GpoCore *led_p) {
   int i;

   for (i = 0; i < 5; i++) {
      led_p->write(0xffff);
      sleep_ms(500);
      led_p->write(0x0000);
      sleep_ms(500);
      debug("timer check - (loop #)/now: ", i, now_ms());
   }
}

void adt7420_check(I2cCore *adt7420_p, GpoCore *led_p, SsegCore *sseg) {
   const uint8_t DEV_ADDR = 0x4b;
   uint8_t wbytes[2], bytes[2];
   //int ack;
   uint16_t tmp;
   float tmpC;
   int tmpC100;
   int array[4];

   // read adt7420 id register to verify device existence
   //ack = adt7420_p->read_dev_reg_byte(DEV_ADDR, 0x0b, &id);

   wbytes[0] = 0x0b;
   adt7420_p->write_transaction(DEV_ADDR, wbytes, 1, 1);
   adt7420_p->read_transaction(DEV_ADDR, bytes, 1, 0);
   uart.disp("read ADT7420 id (should be 0xcb): ");
   uart.disp(bytes[0], 16);
   uart.disp("\n\r");
   //debug("ADT check ack/id: ", ack, bytes[0]);
   // read 2 bytes
   //ack = adt7420_p->read_dev_reg_bytes(DEV_ADDR, 0x0, bytes, 2);
   wbytes[0] = 0x00;
   adt7420_p->write_transaction(DEV_ADDR, wbytes, 1, 1);
   adt7420_p->read_transaction(DEV_ADDR, bytes, 2, 0);

   // conversion
   tmp = (uint16_t) bytes[0];
   tmp = (tmp << 8) + (uint16_t) bytes[1];
   if (tmp & 0x8000) {
      tmp = tmp >> 3;
      tmpC = (float) ((int) tmp - 8192) / 16;
   } else {
      tmp = tmp >> 3;
      tmpC = (float) tmp / 16;
      tmpC100 = tmpC * 100;
   }
   uart.disp("temperature (C): ");
   uart.disp(tmpC);
   uart.disp("\n\r");

   array[3] = tmpC100 / 1000;
   tmpC100 = tmpC100 % 1000;
   array[2] = tmpC100 / 100;
   tmpC100 = tmpC100 % 100;
   array[1] = tmpC100 / 10;
   tmpC100 = tmpC100 % 10;
   array[0] = tmpC100; //array is filled with temperature digits

   sseg->write_1ptn(sseg->h2s(array[0]), 0);
   sseg->write_1ptn(sseg->h2s(array[1]), 1);
   sseg->write_1ptn(sseg->h2s(array[2]), 2);
   sseg->write_1ptn(sseg->h2s(array[3]), 3);

   sleep_ms(1000);
   led_p->write(0);
}

/**
 * check individual led
 * @param led_p pointer to led instance
 * @param n number of led
 */
//void led_check(GpoCore *led_p, int n) {
   //int i;

   //for (i = 0; i < n; i++) {
      //led_p->write(1, i);
      //sleep_ms(200);
      //led_p->write(0, i);
      //sleep_ms(200);
   //}
//}

void pwm_3color_led_check(PwmCore *pwm_p) {
   int i, n;
   double bright, duty;
   const double P20 = 1.2589;  // P20=100^(1/20); i.e., P20^20=100

   pwm_p->set_freq(50);
   for (n = 0; n < 3; n++) {
      bright = 1.0;
      for (i = 0; i < 20; i++) {
         bright = bright * P20;
         duty = bright / 100.0;
         pwm_p->set_duty(duty, n);
         pwm_p->set_duty(duty, n + 3);
         sleep_ms(100);
      }
      sleep_ms(300);
      pwm_p->set_duty(0.0, n);
      pwm_p->set_duty(0.0, n + 3);
   }
}

void sseg_check(SsegCore *sseg_p) {
   int i, n;
   uint8_t dp;

   //turn off led
   for (i = 0; i < 8; i++) {
      sseg_p->write_1ptn(0xff, i);
   }
   //turn off all decimal points
   sseg_p->set_dp(0x04);
}

/**
 * leds flash according to switch positions.
 * @param led_p pointer to led instance
 * @param sw_p pointer to switch instance
 */
//void sw_check(GpoCore *led_p, GpiCore *sw_p) {
   //int i, s;

   //s = sw_p->read();
   //for (i = 0; i < 30; i++) {
      //led_p->write(s);
      //sleep_ms(50);
      //led_p->write(0);
      //sleep_ms(50);
   //}
//}

/**
 * uart transmits test line.
 * @note uart instance is declared as global variable in chu_io_basic.h
 */
//void uart_check() {
   //static int loop = 0;

   //uart.disp("uart test #");
   //uart.disp(loop);
   //uart.disp("\n\r");
   //loop++;
//}

// instantiate switch, led
GpoCore led(get_slot_addr(BRIDGE_BASE, S2_LED));
GpiCore sw(get_slot_addr(BRIDGE_BASE, S3_SW));
PwmCore pulse(get_slot_addr(BRIDGE_BASE, S6_PWM));
I2cCore adt7420(get_slot_addr(BRIDGE_BASE, S10_I2C));
SsegCore sseg(get_slot_addr(BRIDGE_BASE, S8_SSEG));

int main() {

   while (1) {
      //timer_check(&led);
      //led_check(&led, 16);
      //sw_check(&led, &sw);
      //uart_check();
	  //pwm_3color_led_check(&pulse);
	  sseg_check(&sseg);
	  adt7420_check(&adt7420, &led, &sseg);
      debug("main - switch value / up time : ", sw.read(), now_ms());
   } //while
} //main


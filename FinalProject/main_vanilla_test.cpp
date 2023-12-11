//#define _DEBUG
#include "chu_init.h"
#include "gpio_cores.h"
#include "i2c_core.h"
#include "sseg_core.h"
#include "ps2_core.h"
#include "ddfs_core.h"

void ddfs_check(DdfsCore *ddfs_p, GpoCore *led_p, Ps2Core *ps2_p, SsegCore *sseg) {
   int tone;
   int guess = 5;
   int keyboardPress = 0;
   char ch;
   int correct = 0;
   unsigned short lfsr = now_ms();
   unsigned bit;

   ddfs_p->set_env_source(0);  // select envelop source

   do {
   	   //generate random value
	   bit  = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5) ) & 1;
	   lfsr =  (lfsr >> 1) | (bit << 15);
   	   tone = lfsr % 3;

   	   //play tone
   	   if (tone == 0) { //C
   		   ddfs_p->set_env(0.1);
   		   ddfs_p->set_carrier_freq(262);
   		   sleep_ms(2000);
   		   ddfs_p->set_env(0.0);
   	   }
   	   else if (tone == 1) {//F
   	   		   ddfs_p->set_env(0.1);
   	   		   ddfs_p->set_carrier_freq(349);
   	   		   sleep_ms(2000);
   	   		   ddfs_p->set_env(0.0);
   	   }
   	   else if (tone == 2) {//B
   	   		   ddfs_p->set_env(0.1);
   	   		   ddfs_p->set_carrier_freq(494);
   	   		   sleep_ms(2000);
   	   		   ddfs_p->set_env(0.0);
   	   }

   	   //CHOOSE
   	   sseg->write_1ptn(sseg->h2s(12), 6);  //C
   	   sseg->write_1ptn(137, 5);            //H
   	   sseg->write_1ptn(sseg->h2s(0), 3);   //O
   	   sseg->write_1ptn(sseg->h2s(0), 4);   //O
   	   sseg->write_1ptn(sseg->h2s(5), 2);   //S
   	   sseg->write_1ptn(sseg->h2s(14), 1);  //E

   	   sleep_ms(5000);

   	   for (int i = 0; i < 8; i++) {
   	      sseg->write_1ptn(0xff, i);
   	   }

   	   //get mouse guess
   	   while (!keyboardPress) {
   		   if (ps2_p->get_kb_ch(&ch)) {
   			   if (ch == 'c') {
   				   guess = 0;
   				   keyboardPress = 1;
   			   }
   			   else if (ch == 'f') {
   				   guess = 1;
   				   keyboardPress = 1;
   			   }
   			   else if (ch == 'b') {
   			   	   guess = 2;
   			   	   keyboardPress = 1;
   			   }
   			   else {
   				   keyboardPress = 0;
   			   }
   		   }
   	   }

   	   if (guess == tone) {
   		   ++correct;
   		   sseg->write_1ptn(sseg->h2s(12), 5);  //C
   		   sseg->write_1ptn(sseg->h2s(0), 3);   //O
   		   sseg->write_1ptn(sseg->h2s(0), 4);   //O
   		   sseg->write_1ptn(199, 2);            //L

   		   sleep_ms(2500);

   		   for (int i = 0; i < 8; i++) {
   			   sseg->write_1ptn(0xff, i);
   		   }
   	   }
   	   else {
   		   correct = 0;
   		   sseg->write_1ptn(134, 6);  //E
   		   sseg->write_1ptn(175, 5);   //r
   		   sseg->write_1ptn(175, 4);   //r
   		   sseg->write_1ptn(163, 3);  //o
   		   sseg->write_1ptn(175, 2);   //r

   		   sleep_ms(2500);

   		   for (int i = 0; i < 8; i++) {
   			   sseg->write_1ptn(0xff, i);
   		   }
   	   }

   	   keyboardPress = 0;

	} while (correct < 5);

    sseg->write_1ptn(sseg->h2s(12), 7);  //C
    sseg->write_1ptn(sseg->h2s(0), 6);   //O
    sseg->write_1ptn(sseg->h2s(0), 5);   //O
    sseg->write_1ptn(199, 4);            //L
    sseg->write_1ptn(sseg->h2s(12), 3);  //C
    sseg->write_1ptn(sseg->h2s(0), 2);   //O
    sseg->write_1ptn(sseg->h2s(0), 1);   //O
    sseg->write_1ptn(199, 0);            //L
    sleep_ms(2500);

    for (int i = 0; i < 8; i++) {
    	sseg->write_1ptn(0xff, i);
    }

    sleep_ms(2500);

    sseg->write_1ptn(sseg->h2s(12), 7);  //C
    sseg->write_1ptn(sseg->h2s(0), 6);   //O
    sseg->write_1ptn(sseg->h2s(0), 5);   //O
    sseg->write_1ptn(199, 4);            //L
    sseg->write_1ptn(sseg->h2s(12), 3);  //C
    sseg->write_1ptn(sseg->h2s(0), 2);   //O
    sseg->write_1ptn(sseg->h2s(0), 1);   //O
    sseg->write_1ptn(199, 0);            //L

    sleep_ms(2500);

    for (int i = 0; i < 8; i++) {
    	sseg->write_1ptn(0xff, i);
    }

    sleep_ms(2500);

    sseg->write_1ptn(sseg->h2s(12), 7);  //C
    sseg->write_1ptn(sseg->h2s(0), 6);   //O
    sseg->write_1ptn(sseg->h2s(0), 5);   //O
    sseg->write_1ptn(199, 4);            //L
    sseg->write_1ptn(sseg->h2s(12), 3);  //C
    sseg->write_1ptn(sseg->h2s(0), 2);   //O
    sseg->write_1ptn(sseg->h2s(0), 1);   //O
    sseg->write_1ptn(199, 0);            //L

    sleep_ms(2500);

    for (int i = 0; i < 8; i++) {
    	sseg->write_1ptn(0xff, i);
    }

    sleep_ms(2500);
}

void adt7420_check(I2cCore *adt7420_p, GpoCore *led_p, SsegCore *sseg) {
   const uint8_t DEV_ADDR = 0x4b;
   uint8_t wbytes[2], bytes[2];
   uint16_t tmp;
   float tmpC;
   int tmpC100;
   int array[4];

   wbytes[0] = 0x0b;
   adt7420_p->write_transaction(DEV_ADDR, wbytes, 1, 1);
   adt7420_p->read_transaction(DEV_ADDR, bytes, 1, 0);
   uart.disp("read ADT7420 id (should be 0xcb): ");
   uart.disp(bytes[0], 16);
   uart.disp("\n\r");
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

void sseg_check(SsegCore *sseg_p) {
   int i, n;
   uint8_t dp;

   //turn off led
   for (i = 0; i < 8; i++) {
      sseg_p->write_1ptn(0xff, i);
   }
   //turn off all decimal points
   sseg_p->set_dp(0x00);
}

// instantiate switch, led
GpoCore led(get_slot_addr(BRIDGE_BASE, S2_LED));
GpiCore sw(get_slot_addr(BRIDGE_BASE, S3_SW));
PwmCore pulse(get_slot_addr(BRIDGE_BASE, S6_PWM));
I2cCore adt7420(get_slot_addr(BRIDGE_BASE, S10_I2C));
SsegCore sseg(get_slot_addr(BRIDGE_BASE, S8_SSEG));
Ps2Core ps2(get_slot_addr(BRIDGE_BASE, S11_PS2));
DdfsCore ddfs(get_slot_addr(BRIDGE_BASE, S12_DDFS));

int main() {
   while (1) {
	  sseg_check(&sseg);
	  //ps2_check(&ps2);
	  ddfs_check(&ddfs, &led, &ps2, &sseg);
      debug("main - switch value / up time : ", sw.read(), now_ms());
   }
}

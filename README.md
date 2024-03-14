# CMOD_A7_Stopwatch_Handson
Our first feature would be to add a start/stop button to start and stop the stopwatch. __
To do this, we used the second button,btn[0], that is prebuilt into the board__
We assigned it to a variable pause and added it as an input in clock_tree.v__
When the button is pressed momentarily, the pause button change from 0 to 1 for a moment, this changes a variable, flag, in clock_tree.v from either 0 to 1 or 1 to 0.__
The flag will then act as a condition for the clock to stop updating or continue updating.()
Our second feature would be to add a buzzer to beep for 1s at the 2,4,6 and 8 minute mark.__
We assigned a buzzer to PIO35 and added it as an input in num_adder.v__
When the 7 segment screen input is 0200,0400,0600 and 0800, the variable egg_done will turn from 0 to 1__
Once the egg_done variable is 1 at the respective times, this will turn the buzzer on.__
When the time is not at the exact 0200,0400,0600 and 0800 marks, egg_done will turn back from 1 to 0 and the buzzer will turn off.()
Our third feature would be that we will have 4 leds to start blinking at the different times (0200,0400,0600 and 0800)__
We assign the leds to PIO36,PIO37,PIO38,PIO39 respectively and added it as an input in num_adder.v__
We then made a separate 25Hz from a 500Hz clock for the led to blink in clock_tree.v and added it as an input in num_adder.v__
When the 7 segment screen input is 0200, the variable led1_on will turn from 0 to 1.__ 
When it is 0400, the variable led2_on will turn from 0 to 1.__
When it is 0600, the variable led3_on will turn from 0 to 1.__
When it is 0800, the variable led4_on will turn from 0 to 1.__
When the respective ledX_on turns from 0 to 1, this will engage the LEDX_blinkblink_X to flash with accordance of the 25Hz clock.

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Singapore University of Tech and Design
// Engineer: Xiang Maoyang 
// Create Date: 11/27/2023 11:09:18 AM
// Design Name: 
// Module Name: Top Module
// Project Name: Stop Watch
// Target Devices: CMOD A7 FPGA BOARD
// Revision 0.01 - File Created
// Additional Comments:
//////////////////////////////////////////////////////////////////////////////////
module top_module(
        input sysclk,
        input [1:0] btn,
        output pio37,
        output pio38,
        output pio39,
        output pio40,
        output pio41,
        output pio42,
        output pio43,
        output pio44,
        output pio45,
        output pio46,
        output pio47,
        output pio48,
        output pio35, //for buzzer
        output pio29, //for flashing external LED
        output [1:0] led
        //output pio2, //declare pin 2 in use 
);
        
wire rstn;
assign rstn = ~btn[1];
wire CLK500Hz,CLK25Hz,CLK1Hz; //from 50 to 25
wire [15:0] bcd_tim;

wire pause;
assign pause = ~btn[0];

//define and indicate output and pinout for buzzer
wire buzzer;
assign pio35 = buzzer;

//define and indicate output and pinout for LED
wire LED1_blinkblink;
assign pio29 = LED1_blinkblink;

//initialization without needing to follow order
clock_tree clk_tree_u0(
    .CLK12MHZ(sysclk),
    .rstn(rstn),
    .pause(pause),
    .CLK500Hz(CLK500Hz),
    .CLK1Hz(CLK1Hz),
    .CLK25Hz(CLK25Hz) //for flashing external LED
);

//initialization with the nedd to follow order
timer timer_u0(rstn,CLK1Hz,CLK25Hz,bcd_tim,buzzer,LED1_blinkblink);

Segment segment_u0(rstn,CLK500Hz,bcd_tim,{pio43,pio46,pio47,pio37},{pio40,pio38,pio45,pio42,pio41,pio39,pio48,pio44});

assign led[0] = CLK1Hz;
assign led[1] = ~CLK1Hz;

endmodule
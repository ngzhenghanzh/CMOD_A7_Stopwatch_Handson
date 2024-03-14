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
        output [1:0] led
);
        
wire rstn;
assign rstn = ~btn[1];
wire CLK500Hz,CLK50Hz,CLK1Hz;
wire [15:0] bcd_tim;

wire pause;
assign pause = ~btn[0];

clock_tree clk_tree_u0(
    .CLK12MHZ(sysclk),
    .rstn(rstn),
    .pause(pause),
    .CLK500Hz(CLK500Hz),
    .CLK1Hz(CLK1Hz) 
);

timer timer_u0(rstn,CLK1Hz,bcd_tim);

Segment segment_u0(rstn,CLK500Hz,bcd_tim,{pio43,pio46,pio47,pio37},{pio40,pio38,pio45,pio42,pio41,pio39,pio48,pio44});

assign led[0] = CLK1Hz;
assign led[1] = ~CLK1Hz;

endmodule
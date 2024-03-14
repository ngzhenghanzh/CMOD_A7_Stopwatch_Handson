`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Singapore University of Tech and Design
// Engineer: Xiang Maoyang 
// Create Date: 11/27/2023 11:02:18 AM
// Design Name: 
// Module Name: Clock Tree;
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Dependencies: 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//////////////////////////////////////////////////////////////////////////////////
module clock_tree(
    input CLK12MHZ,         
    input rstn,             //NON_SYNC RESET (ACTIVE LOW)
    input pause,            // pause 
    output reg CLK500Hz,    //OUTPUT - 500Hz CLOCK;
    output reg CLK1Hz,       //OUTPUT - 1Hz   CLOCK;
    output reg CLK25Hz      //OUTPUT - 25Hz CLOCK;
);

reg [13:0] CLK_CNTER_500Hz;
reg [7:0] CLK_CNTER_1Hz;
reg [3:0] CLK_CNTER_25Hz;
reg [1:0] flag;

//Generate 500Hz CLK; 
always@(posedge CLK12MHZ, negedge rstn) begin
    if(!rstn) begin
        CLK_CNTER_500Hz<=14'h0000;
        CLK500Hz <= 1'b0;
    end
    else begin
        if(CLK_CNTER_500Hz == 14'd12_000-1'b1) begin
            CLK500Hz <= ~ CLK500Hz;
            CLK_CNTER_500Hz <= 14'h0000;
        end
        else CLK_CNTER_500Hz <= CLK_CNTER_500Hz + 1'b1;
    end
end

always@(posedge CLK12MHZ, negedge pause) begin
    if (!pause) begin 
        if (flag == 1'b0) begin
            flag <= 1'b1;
            end
        else begin 
            flag <= 1'b0;
            end
        end 
    end 
    
//Generate 1Hz CLK;
always@(posedge CLK500Hz, negedge rstn, negedge flag)begin
    if(!rstn) begin
        CLK_CNTER_1Hz<=8'h00;
        CLK1Hz <= 1'b0;
    end
    else begin
        if(CLK_CNTER_1Hz == 8'd250-1'b1) begin
            CLK1Hz <= ~ CLK1Hz;
            CLK_CNTER_1Hz <= 8'h00;
        end
        else if (!flag) begin
            CLK_CNTER_1Hz <= CLK_CNTER_1Hz; 
        end
        else CLK_CNTER_1Hz <= CLK_CNTER_1Hz + 1'b1;
    end
end

//Generate 25Hz CLK; for LED indicator lights
always@(posedge CLK500Hz, negedge rstn) begin
    if(!rstn) begin
        CLK_CNTER_25Hz <= 5'h0;
        CLK25Hz <= 1'b0;
    end
    else begin
        if(CLK_CNTER_25Hz == 5'd10-1'b1) begin //when there are 10 lows from 500hz wave
            CLK25Hz <= ~ CLK25Hz;//flip up from 0 to 1, creating oscillating wave
            CLK_CNTER_25Hz <= 5'h0;
        end
        else CLK_CNTER_25Hz <= CLK_CNTER_25Hz + 1'b1;
    end
end

endmodule
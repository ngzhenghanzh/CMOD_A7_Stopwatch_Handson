`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Singapore University Technology and Design
// Engineer: Xiang Maoyang
// Create Date: 11/14/2023 06:12:17 PM
// Design Name: clock and alarm
// Module Name: num_addsub
//////////////////////////////////////////////////////////////////////////////////

module timer(
    input rstn,
    input clk1hz,
    input clk25hz,
    output  [15:0] bcd_num,
    output buzzer,
    output LED1_blinkblink
);

// Timer Section is composed with 4 BCD Number counter(Minute Decade,Minute Unit, Second Decade, Minute Unit);
reg [3:0] sec_unit_bcd_r,sec_deca_bcd_r,min_unit_bcd_r,min_deca_bcd_r; //Register - (Minute Decade,Minute Unit, Second Decade, Second Unit);
reg sec_unit_cout,sec_deca_cout,min_unit_cout; //Carry Out Signal, When 4 BCD Number counter reach upper limit, it will generate a cout signal;

//for buzzer and external LED
reg egg_done = 1'b0;
reg buzzer_1;
assign buzzer = buzzer_1;
reg LED1_on = 1'b0;
reg LED1_blinkblink_1;
assign LED1_blinkblink = LED1_blinkblink_1;

//Counter           Upper Limit
//Minute Decade     5
//Minute Unit       9
//Second Decade     5
//Second Unit       9

always @(posedge clk1hz or negedge rstn)begin
    if(!rstn)begin
        sec_unit_bcd_r <= 4'd0; //Clear BCD Number Counter;
        sec_unit_cout <= 1'b0;  //Clear Cout Signal;
    end
    else begin
        if(sec_unit_bcd_r == 4'h9)begin
            sec_unit_cout <= 1'b1;  //Cout generate a posedge;
            sec_unit_bcd_r <= 4'd0; //Clear BCD Number Counter;
            //egg_done <= 1'b1;
            //LED_on <= 1'b1;
        end
        else begin
            sec_unit_cout <= 1'b0;                      //Clear Cout Signal;
            sec_unit_bcd_r <= sec_unit_bcd_r + 1'b1; // BCD Number Counter increase by '1';
           // egg_done <= 1'b0;
            //LED_on <= 1'b0;
        end
    end
end

always @(posedge sec_unit_cout or negedge rstn)begin
    if(!rstn)begin
        sec_deca_bcd_r <= 4'd0;
        sec_deca_cout <= 1'b0;
    end
    else begin
        if(sec_deca_bcd_r == 4'h5)begin
            sec_deca_cout <= 1'b1;
            sec_deca_bcd_r <= 4'd0;
        end
        else begin
            sec_deca_cout <= 1'b0;
            sec_deca_bcd_r <= sec_deca_bcd_r + 1'b1;
        end
    end
end

always @(posedge sec_deca_cout or negedge rstn)begin
    if(!rstn)begin
        min_unit_bcd_r <= 4'd0;
        min_unit_cout <= 1'b0;
    end
    else begin
        if(min_unit_bcd_r == 4'h9)begin
            min_unit_cout <= 1'b1;
            min_unit_bcd_r <= 4'd0;
        end
        else begin
            min_unit_cout <= 1'b0;
            min_unit_bcd_r <= min_unit_bcd_r + 1'b1;
        end
    end
end

always @(posedge min_unit_cout or negedge rstn)begin
    if(!rstn)begin
        min_deca_bcd_r <= 4'd0;
    end
    else begin
        if(min_deca_bcd_r == 4'h5)begin 
            min_deca_bcd_r <= 4'd0;
        end
        else begin
            min_deca_bcd_r <= min_deca_bcd_r + 1'b1;
        end
    end
end

//condition for buzzer and LED
always @(posedge clk1hz or negedge rstn)begin
    if(!rstn)begin
        egg_done <= 1'b0;
        LED1_on <= 1'b0;
    end
    else begin
        if((sec_unit_bcd_r == 4'h0)&&(sec_deca_bcd_r == 4'h1)&&(min_unit_bcd_r == 4'h0)&&(min_deca_bcd_r == 4'h0))begin // for and condition use &&
           // sec_unit_cout <= 1'b1;  //Cout generate a posedge;
           // sec_unit_bcd_r <= 4'd0; //Clear BCD Number Counter;
            egg_done <= 1'b1;
            LED1_on <= 1'b1;
        end
        else begin
            //sec_unit_cout <= 1'b0;                      //Clear Cout Signal;
            //sec_unit_bcd_r <= sec_unit_bcd_r + 1'b1; // BCD Number Counter increase by '1';
            egg_done <= 1'b0;
            //LED1_on <= 1'b0;
        end
    end
end

//for buzzer
always @(negedge clk1hz or negedge rstn) begin
    if(!rstn) begin
        buzzer_1 <= 1'b0; //off state
    end
    else begin
        if (egg_done) begin
            buzzer_1 <= 1'b1; //on state
        end
        else begin
            buzzer_1 <= 1'b0;
        end
    end
end

//for external LED
always @(negedge clk25hz or negedge rstn) begin
    if(!rstn) begin
        LED1_blinkblink_1 <= 1'b0; //off state
    end
    else begin
        if (LED1_on) begin
            LED1_blinkblink_1 <= 1'b1; //on state
            LED1_blinkblink_1 <= ~LED1_blinkblink_1; //flip to off state
        end
        else begin
            LED1_blinkblink_1 <= 1'b0;
        end
    end
end     

   
//When DIG4 on, BCD Number Display at this moment is bcd_num[3:0];  (i.e Stop Watch - Second Unit)
//When DIG3 on, BCD Number Display at this moment is bcd_num[7:4];  (i.e Stop Watch - Second Decade)
//When DIG2 on, BCD Number Display at this moment is bcd_num[11:8]; (i.e Stop Watch - Minute Unit)
//When DIG1 on, BCD Number Display at this moment is bcd_num[15:12];(i.e Stop Watch - Minute Decade)
assign  bcd_num[15:12]  = min_deca_bcd_r;
assign  bcd_num[11:8]   = min_unit_bcd_r;
assign  bcd_num[7:4]    = sec_deca_bcd_r;
assign  bcd_num[3:0]    = sec_unit_bcd_r;
 
endmodule
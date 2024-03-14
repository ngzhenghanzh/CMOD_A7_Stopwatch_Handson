module test_blink_tb();

reg clk500hz;
reg LED1_on;
wire LED_blinkblink;

LED_blinker LED_blinker_1(
    .clk500hz(clk500hz),
    .LED1_on(LED1_on),
    .LED_blinkblink(LED_blinkblink)
);

always begin
    #1 clk500hz = !clk500hz;
end

initial begin 
    clk500hz = 1'b0;
    #0 LED1_on = 1'b1;
    #10 LED1_on = 1'b0;
    #10 LED1_on = 1'b1;
    
    #10 $stop;
    
end

endmodule
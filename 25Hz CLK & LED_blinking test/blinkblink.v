module LED_blinker(
    input clk500hz,
    input LED1_on,
    output LED_blinkblink
    );
    
reg LED1_blinkblink_1;
assign LED_blinkblink = LED1_blinkblink_1;

always @(posedge clk500hz) begin
    if (LED1_on) begin
        LED1_blinkblink_1 <= 1'b1; //on state
        LED1_blinkblink_1 <= ~ LED1_blinkblink_1;
    end
    else begin
        LED1_blinkblink_1 <= 1'b0;
    end
end   
    
endmodule  
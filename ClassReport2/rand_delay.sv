module rand_delay(
    input logic tic,
    input logic rst,
    input logic stp,
    input logic en,
    output logic led,
    output logic [1:0] state,
    output logic [9:0] timing
    );
    
   logic [31:0] delayCounter;
   
   logic n_led;
   
   localparam [1:0] IDLE = 2'b00;
   localparam [1:0] COUNT = 2'b01;
   localparam [1:0] FINISH = 2'b10;
   
   logic [31:0] clockCounter;

    //always @(posedge(tic), posedge(rst), posedge(en), posedge(stp))
    always @(posedge(tic), posedge(rst)) 
        begin
        if (rst) 
            begin
            state <= IDLE;
            delayCounter <= 31'd99999999;
            clockCounter <= 0;
            led <= 0;
            timing <= 0;
            end 
        else if(en) 
            begin
            if(state == IDLE)
                begin
                delayCounter <= ($random %14 + 2)*1000;
                clockCounter <= 0;
                state <= COUNT;
                end   
           end
       else if (stp)
            begin
            if(state == COUNT)
                begin
                if (clockCounter < delayCounter) 
                    timing <= 10'b1111111111;
                state <= FINISH;
                end 
            end
        else
            begin
            if((state == COUNT) && ((clockCounter-delayCounter) != 31'd1000))
                begin
                clockCounter <= clockCounter + 1;
                end
            if ((state == COUNT) && (clockCounter > delayCounter))
                begin
                timing <= clockCounter - delayCounter;
                led <= 1'b1;
                end
            if((state == COUNT) && ((clockCounter-delayCounter) == 31'd1000))
                begin
                state <= FINISH;
                end
            end
    end
        
//    always_comb
//        begin
//        if((state == COUNT) && (clockCounter != 31'd1000))
//            begin
//            n_clockCounter <= clockCounter + 1;
//            end
//        if ((state == COUNT) && (clockCounter > delayCounter))
//            begin
//            timing <= clockCounter - delayCounter;
//            end
//        end
        
        
endmodule


`timescale 1ns / 1ps

module BinaryToBCDConverter(
    input logic [9:0] bin,
    output logic [11:0] bcd
    );
    
    logic [3:0] i;
    
    always @ (bin)
    begin
    if(bin == 10'b1111111111)
        bcd = 12'b111111111111;
    else
    begin
        bcd = 0;
        for (i = 0; i < 10; i = i + 1)
        begin
            bcd = {bcd[10:0], bin[9 - i]};
            if(i < 9 && bcd[3:0] > 4) 
                bcd[3:0] = bcd[3:0] + 3;
            if(i < 9 && bcd[7:4] > 4)
                bcd[7:4] = bcd[7:4] + 3;
            if(i < 9 && bcd[11:8] > 4)
                bcd[11:8] = bcd[11:8] + 3; 
        end
    end
    end    
    
endmodule

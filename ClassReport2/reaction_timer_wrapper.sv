`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2023 05:25:57 PM
// Design Name: 
// Module Name: reaction_timer_wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module reaction_timer_wrapper(
    input clk,
    input BTNC,
    output [7:0] sseg,
    output [7:0] AN
    );
    
    assign AN[7:4] = 4'b1111;
    
    logic [9:0] totalTicks;
    logic [31:0] count;
    logic [11:0] bcd;
    
    counter_timer uut(
        .clk(clk),
        .rst(BTNC),
        .up(1'b1),
        .en(1'b1),
        .totalTicks(totalTicks),
        .count(count)
    );
    
    BinaryToBCDConverter dut(
        .bin(totalTicks),
        .bcd(bcd)
    );
    
    sseg_decoder but(
        .clk(clk),
        .rst(BTNC),
        .bcd(bcd),
        .sseg(sseg),
        .an(AN[3:0])
    );
    
endmodule
